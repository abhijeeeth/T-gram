import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/Initializer.dart';
import 'package:tigramnks/model/nocapprovedrejecedmodel.dart';
import 'package:tigramnks/model/nocforwardedlistmodel.dart';
import 'package:tigramnks/model/nocfreshapplictaionmodel.dart';
import 'package:tigramnks/model/nocpendinglistmodel.dart';
import 'package:tigramnks/model/nocviewmodel.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/sqflite/dbhelper.dart'; // Add this import
import 'package:tigramnks/utils/local_storage.dart';

// Define the Bloc
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<SaveLocallyFieldVerifyData>(_savbeLocallyFieldVerifyData);
    on<FetchSpeciesList>(_fetchSpeciesList);
    on<UploadData>(_uploadData);
    on<login>(_login);
    on<NocFreshApplicationList>(nocFreshApplicationList);
    on<NocPendingApplicationList>(_nocPendingApplicationList);
    on<NocApprovedRejectedList>(_nocApprovedRejectedList);
    on<NocForwardedList>(_nocForwardedList);
    on<NocListIndividualView>(_nocListIndividualView);
    on<SiteInspection>(_siteInspection);
    on<SiteInspectionByRFO>(_siteInspectionByRFO);
    on<DeputyFileUpload>(_deputyFileUpload);
    // TODO: implement event handler
  }

  FutureOr _savbeLocallyFieldVerifyData(
      SaveLocallyFieldVerifyData event, Emitter<MainState> emit) async {
    try {
      // Store the basic user data
      Map<String, dynamic> userData = {
        'sessionToken': event.sessionToken,
        'userGroup': event.userGroup,
        'userId': event.userId,
        'Ids': event.Ids,
        'Range': event.Range,
        'userName': event.userName,
        'userEmail': event.userEmail,
      };

      await LocalStorage.saveUserData(event.Ids, userData);

      // Fetch application details from server
      String url = '${ServerHelper.baseUrl}auth/ViewApplication';
      Map data = {"app_id": event.Ids};

      var body = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "token ${event.sessionToken}"
          },
          body: body);

      if (response.statusCode == 200) {
        add(FetchSpeciesList(Ids: event.Ids, sessionToken: event.sessionToken));
        Map<String, dynamic> responseJSON = json.decode(response.body);

        // Save data to SQLite database
        try {
          DbHelper dbHelper = DbHelper();
          await dbHelper.ensureDatabaseCreated(); // Ensure database is ready

          if (responseJSON['data']?['applications'] != null) {
            for (var app in responseJSON['data']['applications']) {
              var result = await dbHelper.insertApplication(app);
              if (result == -1) {
                print("Failed to insert application: ${app['id']}");
              }
            }
          }
          if (responseJSON['data']?['image_documents'] != null) {
            for (var doc in responseJSON['data']['image_documents']) {
              await dbHelper.insertImageDocument(doc);
            }
          }

          // Save timber logs
          if (responseJSON['data']?['timber_log'] != null) {
            for (var log in responseJSON['data']['timber_log']) {
              await dbHelper.insertTimberLog(log);
            }
          }

          // Save species list
          if (responseJSON['data']?['trees_species_list'] != null) {
            for (var species in responseJSON['data']['trees_species_list']) {
              if (species['name'] != null) {
                await dbHelper.insertSpecies(species['name']);
              }
            }
          }

          if (responseJSON['data']?['additional_documents'] != null) {
            for (var doc in responseJSON['data']['additional_documents']) {
              await dbHelper.insertAdditionalDocument(doc);
            }
          }

          print("Application data successfully saved to SQLite database");
        } catch (dbError) {
          print("Error saving to SQLite database: $dbError");
          // Log more details to help diagnose the issue
          if (dbError.toString().contains('no column named')) {
            print(
                "Database schema mismatch. Try upgrading the database or reinstalling the app.");
          }
          // Continue execution even if database save fails
        }

        // Extract and store specific data categories separately for easier access
        if (responseJSON['data'] != null) {
          if (responseJSON['data']['applications'] != null &&
              responseJSON['data']['applications'].isNotEmpty) {
            await LocalStorage.saveApplicationDetails(
                event.Ids, responseJSON['data']['applications'][0]);
          }

          if (responseJSON['data']['timber_log'] != null) {
            await LocalStorage.saveTimberLog(
                event.Ids, responseJSON['data']['timber_log']);
          }

          if (responseJSON['data']['species_location'] != null) {
            await LocalStorage.saveSpeciesLocation(
                event.Ids, responseJSON['data']['species_location']);
          }

          if (responseJSON['data']['image_documents'] != null) {
            await LocalStorage.saveImageDocuments(
                event.Ids, responseJSON['data']['image_documents']);
          }
        }

        emit(FieldVerifyDataSavedState(success: true));
      } else {
        throw Exception(
            'Failed to fetch application data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saving field verification data: $e');
      emit(FieldVerifyDataSavedState(success: false, error: e.toString()));
    }
  }

  FutureOr<void> _fetchSpeciesList(
      FetchSpeciesList event, Emitter<MainState> emit) async {
    try {
      String url = '${ServerHelper.baseUrl}auth/get_req_log/';
      Map data = {"app_id": event.Ids};
      var body = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "token ${event.sessionToken}"
          },
          body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJSON = json.decode(response.body);
        log("Response JSON: $responseJSON");
        // Extract log details
        List<dynamic> logs = responseJSON['data'] ?? [];

        // Save logs to the transit_passes table in SQLite
        try {
          DbHelper dbHelper = DbHelper();
          await dbHelper.ensureDatabaseCreated();
          for (var logEntry in logs) {
            await dbHelper.insertTransitPass(logEntry);
          }
          print("Transit passes successfully saved to SQLite database");
        } catch (dbError) {
          print("Error saving transit passes to SQLite database: $dbError");
        }

        // Optionally, emit a state with the logs
        // emit(SpeciesListFetchedState(logs: logs));
      } else {
        throw Exception('Failed to fetch log data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching species list: $e');
      //emit(SpeciesListFetchedState(logs: [], error: e.toString()));
    }
  }

  FutureOr<void> _uploadData(UploadData event, Emitter<MainState> emit) async {
    try {
      final String sessionToken = ServerHelper.token.toString();
      log('Uploading data: $sessionToken');
      final String ids = event.data['id'].toString();
      final String base64ImagePic1 = event.data['location_img1'];
      final String base64ImagePic2 = event.data['location_img2'];
      final String base64ImagePic3 = event.data['location_img3'];
      final String base64ImagePic4 = event.data['location_img4'];
      final dynamic logDetails =
          event.data['log_details']; // Expecting a List<Map<String, dynamic>>
      final String latImage1 = event.data['image1_lat'];
      final String latImage2 = event.data['image2_lat'];
      final String latImage3 = event.data['image3_lat'];
      final String latImage4 = event.data['image4_lat'];
      final String longImage1 = event.data['image1_log'];
      final String longImage2 = event.data['image2_log'];
      final String longImage3 = event.data['image3_log'];
      final String longImage4 = event.data['image4_log'];

      const String url = '${ServerHelper.baseUrl}auth/field_verify/';
      Map data = {
        "app_id": ids,
        "location_img1": {"mime": "image/jpeg", "data": base64ImagePic1},
        "location_img2": {"mime": "image/jpeg", "data": base64ImagePic2},
        "location_img3": {"mime": "image/jpeg", "data": base64ImagePic3},
        "location_img4": {"mime": "image/jpeg", "data": base64ImagePic4},
        "summary": event.data['summary'],
        "log_details": logDetails,
        "image1_lat": latImage1,
        "image2_lat": latImage2,
        "image3_lat": latImage3,
        "image4_lat": latImage4,
        "image1_log": longImage1,
        "image2_log": longImage2,
        "image3_log": longImage3,
        "image4_log": longImage4,
      };
      log(data.toString());
      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      log(body.toString());
      log('Response: ${responseJson.toString()}');

      if (response.statusCode == 200) {
        try {
          // Get application ID from the data
          final String appId = ids;
          log('Attempting to delete location data for app ID: $appId');

          if (appId.isEmpty) {
            log('Error: Application ID is empty');
            emit(FieldVerifyDataSavedState(success: true));
            return;
          }

          // Initialize database helper
          DbHelper dbHelper = DbHelper();
          await dbHelper.ensureDatabaseCreated();

          // Safely parse appId to integer
          int? appIdInt;
          try {
            appIdInt = int.parse(appId);
          } catch (parseError) {
            log('Error parsing appId to integer: $parseError');
            emit(FieldVerifyDataSavedState(success: true));
            return;
          }

          // Get existing application locations for this app ID
          log('Fetching locations for appId: $appIdInt');
          List<Map<String, dynamic>> existingLocations =
              await dbHelper.getApplicationLocations(appIdInt);

          log('Found ${existingLocations.length} location records to delete');

          // Delete each location record for this application
          int deletedCount = 0;
          for (var location in existingLocations) {
            int locationId = location['id'];
            log('Deleting location ID: $locationId');
            int result = await dbHelper.deleteApplicationLocation(locationId);
            if (result > 0) {
              deletedCount++;
            } else {
              log('Failed to delete location ID: $locationId');
            }
          }

          log('Successfully deleted $deletedCount/${existingLocations.length} location records for app ID: $appId');
        } catch (dbError) {
          log('Error when deleting local data after successful upload: $dbError');
          // Continue with success state even if local cleanup fails
        }

        emit(FieldVerifyDataSavedState(success: true));
      } else {
        emit(FieldVerifyDataSavedState(
            success: false,
            error: responseJson['message'] ?? "Something went wrong"));
      }
    } catch (e) {
      emit(FieldVerifyDataSavedState(success: false, error: e.toString()));
    }
  }

  FutureOr<void> _login(login event, Emitter<MainState> emit) async {}

  FutureOr<void> nocFreshApplicationList(
      NocFreshApplicationList event, Emitter<MainState> emit) async {
    try {
      emit(NocFreshLIstloading());
      Initializer.nocFreshapplicationModel = NOCFreshapplicationModel.fromJson(
          await Initializer.get(
              'auth/PendingListViewApplicationNOC', event.sessionToken));
      if (Initializer.nocFreshapplicationModel.status == true) {
        emit(NocFreshListLoaded());
      } else {
        emit(NOClistfreshFailed());
      }
    } catch (e) {
      log('Error fetching NOC fresh application list: $e');
      emit(NOClistfreshFailed());
    }
  }

  FutureOr<void> _nocPendingApplicationList(
      NocPendingApplicationList event, Emitter<MainState> emit) async {
    try {
      emit(NocPendingLIstloading());
      Initializer.nocPendingModel = NOCPendingModel.fromJson(
          await Initializer.get(
              'auth/InProcessingListViewApplicationNOC', event.sessionToken));
      if (Initializer.nocPendingModel.status == true) {
        emit(NocPendingListLoaded());
      } else {
        emit(NOClistPendingFailed());
      }
    } catch (e) {
      log('Error fetching NOC pending application list: $e');
      emit(NOClistPendingFailed());
    }
  }

  FutureOr<void> _nocApprovedRejectedList(
      NocApprovedRejectedList event, Emitter<MainState> emit) async {
    try {
      emit(NocApprovedRejectedLIstloading());
      Initializer.nocApprovedRejectedModel = NOCApprovedRejectedModel.fromJson(
          await Initializer.get(
              'auth/ApprovedRejectListViewApplicationNOC', event.sessionToken));
      if (Initializer.nocApprovedRejectedModel.status == true) {
        emit(NocApprovedRejectedListLoaded());
      } else {
        emit(NOClistApprovedRejectedFailed());
      }
    } catch (e) {
      log('Error fetching NOC approved/rejected application list: $e');
      emit(NOClistApprovedRejectedFailed());
    }
  }

  FutureOr<void> _nocForwardedList(
      NocForwardedList event, Emitter<MainState> emit) async {
    try {
      emit(NocForwardedLIstloading());
      Initializer.nocForwardedListModel = NOCForwardedListModel.fromJson(
          await Initializer.get(
              'auth/ForwardedListViewApplicationNOC', event.sessionToken));
      if (Initializer.nocForwardedListModel.status == true) {
        emit(NocForwardedListLoaded());
      } else {
        emit(NOClistForwardedFailed());
      }
    } catch (e) {
      log('Error fetching NOC forwarded application list: $e');
      emit(NOClistForwardedFailed());
    }
  }

  FutureOr<void> _nocListIndividualView(
      NocListIndividualView event, Emitter<MainState> emit) async {
    try {
      Map<String, dynamic> userData = {
        'id': event.Ids,
      };

      emit(NocListIndividualViewLoading());
      var response = await Initializer.post(
          'auth/NocApplication', userData, event.sessionToken);

      if (response != null && response is Map<String, dynamic>) {
        Initializer.nocListViewModel = NOCListViewModel.fromJson(response);
        if (Initializer.nocListViewModel.status == "true") {
          emit(NocListIndividualViewLoaded());
        } else {
          emit(NocListIndividualViewFailed());
        }
      } else {
        log('Invalid response format: $response');
        emit(NocListIndividualViewFailed());
      }
    } catch (e) {
      log('Error fetching NOC individual view: $e');
      emit(NocListIndividualViewFailed());
    }
  }

  FutureOr<void> _siteInspection(
      SiteInspection event, Emitter<MainState> emit) async {
    try {
      emit(SiteInspectionLoading());
      final String sessionToken = ServerHelper.token.toString();
      log('Uploading site inspection data: $sessionToken');
      final String ids = event.data['app_id'].toString();
      final String base64ImagePic1 = event.data['location_img1'];
      final String base64ImagePic2 = event.data['location_img2'];
      final String base64ImagePic3 = event.data['location_img3'];
      final String base64ImagePic4 = event.data['location_img4'];
      final String latImage1 = event.data['image1_lat'];
      final String latImage2 = event.data['image2_lat'];
      final String latImage3 = event.data['image3_lat'];
      final String latImage4 = event.data['image4_lat'];
      final String longImage1 = event.data['image1_log'];
      final String longImage2 = event.data['image2_log'];
      final String longImage3 = event.data['image3_log'];
      final String longImage4 = event.data['image4_log'];

      const String url = '${ServerHelper.baseUrl}auth/noc_site_inception/';
      Map data = {
        "app_id": ids,
        "location_img1": {"mime": "image/jpeg", "data": base64ImagePic1},
        "location_img2": {"mime": "image/jpeg", "data": base64ImagePic2},
        "location_img3": {"mime": "image/jpeg", "data": base64ImagePic3},
        "location_img4": {"mime": "image/jpeg", "data": base64ImagePic4},
        "image1_lat": latImage1,
        "image2_lat": latImage2,
        "image3_lat": latImage3,
        "image4_lat": latImage4,
        "image1_log": longImage1,
        "image2_log": longImage2,
        "image3_log": longImage3,
        "image4_log": longImage4,
      };
      log(data.toString());
      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      log(body.toString());
      log('Response: ${responseJson.toString()}');

      if (response.statusCode == 200) {
        emit(SiteInspectionLoaded());

        // Show a toast using Flutter's ScaffoldMessenger if context is available
        final context = event.data['context'];
        if (context != null && context is BuildContext) {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Upload Successful'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      } else {
        emit(SiteInspectionFailed());
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(event.data['context']).showSnackBar(
            const SnackBar(content: Text('Upload Failed')),
          );
        });
      }
    } catch (e) {
      emit(SiteInspectionFailed());
    }
  }

  FutureOr<void> _siteInspectionByRFO(
      SiteInspectionByRFO event, Emitter<MainState> emit) async {
    try {
      emit(SiteInspectionByRFOLoading());
      final String sessionToken = ServerHelper.token.toString();
      log('Uploading site inspection data: $sessionToken');
      final String ids = event.data['app_id'].toString();
      final String base64ImagePic1 = event.data['location_img1'];
      final String base64ImagePic2 = event.data['location_img2'];
      final String base64ImagePic3 = event.data['location_img3'];
      final String base64ImagePic4 = event.data['location_img4'];
      final String latImage1 = event.data['image1_lat'];
      final String latImage2 = event.data['image2_lat'];
      final String latImage3 = event.data['image3_lat'];
      final String latImage4 = event.data['image4_lat'];
      final String longImage1 = event.data['image1_log'];
      final String longImage2 = event.data['image2_log'];
      final String longImage3 = event.data['image3_log'];
      final String longImage4 = event.data['image4_log'];

      const String url = '${ServerHelper.baseUrl}auth/noc_site_inception_rfo/';
      Map data = {
        "app_id": ids,
        "location_img1": {"mime": "image/jpeg", "data": base64ImagePic1},
        "location_img2": {"mime": "image/jpeg", "data": base64ImagePic2},
        "location_img3": {"mime": "image/jpeg", "data": base64ImagePic3},
        "location_img4": {"mime": "image/jpeg", "data": base64ImagePic4},
        "image1_lat": latImage1,
        "image2_lat": latImage2,
        "image3_lat": latImage3,
        "image4_lat": latImage4,
        "image1_log": longImage1,
        "image2_log": longImage2,
        "image3_log": longImage3,
        "image4_log": longImage4,
      };
      log(data.toString());
      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      log(body.toString());
      log('Response: ${responseJson.toString()}');

      if (response.statusCode == 200) {
        emit(SiteInspectionByRFOLoaded());

        final context = event.data['context'];
        if (context != null && context is BuildContext) {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Upload Successful'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      } else {
        emit(SiteInspectionByRFOFailed());
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(event.data['context']).showSnackBar(
            const SnackBar(content: Text('Upload Failed')),
          );
        });
      }
    } catch (e) {
      emit(SiteInspectionByRFOFailed());
    }
  }

  FutureOr<void> _deputyFileUpload(
      DeputyFileUpload event, Emitter<MainState> emit) async {
    try {
      emit(DeputyFileUploadLoading());
      final String sessionToken = ServerHelper.token.toString();
      log('Uploading deputy file data: $sessionToken');
      final String ids = event.data['app_id'].toString();
      final file = event.data['inspection_report']['data'];
      final String base64ImagePic1 = base64Encode(await file.readAsBytes());

      const String url = '${ServerHelper.baseUrl}auth/noc_inception_report/';
      Map data = {
        "app_id": ids,
        "inspection_report": {"mime": "image/jpeg", "data": base64ImagePic1},
      };
      log(data.toString());
      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      log(body.toString());
      log('Response: ${responseJson.toString()}');

      if (response.statusCode == 200) {
        emit(DeputyFileUploadLoaded());

        // Show a toast using Flutter's ScaffoldMessenger if context is available
        final context = event.data['context'];
        if (context != null && context is BuildContext) {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Upload Successful'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      } else {
        emit(DeputyFileUploadFailed());
        // Future.delayed(Duration.zero, () {
        //   ScaffoldMessenger.of(event.data['context']).showSnackBar(
        //     const SnackBar(content: Text('Upload Failed')),
        //   );
        // });
      }
    } catch (e) {}
  }
}
// Define the events

class MainEvent {}

// Define the states

class MainState {}

class FieldVerifyDataSavedState extends MainState {
  final bool success;
  final String? error;

  FieldVerifyDataSavedState({required this.success, this.error});
}

// Save Locally Field verify Data
class SaveLocallyFieldVerifyData extends MainEvent {
  final String sessionToken;
  final String userGroup;
  final String userId;
  final String Ids;
  final String Range;
  final String userName;
  final String userEmail;

  SaveLocallyFieldVerifyData({
    required this.sessionToken,
    required this.userGroup,
    required this.userId,
    required this.Ids,
    required this.Range,
    required this.userName,
    required this.userEmail,
  });
}

//Fetch Species List
class FetchSpeciesList extends MainEvent {
  final String sessionToken;

  final String Ids;

  FetchSpeciesList({
    required this.sessionToken,
    required this.Ids,
  });
}

class UploadData extends MainEvent {
  final Map<String, dynamic> data;

  UploadData({required this.data});
}

//login
class login extends MainEvent {
  final String sessionToken;
  final String password;
  final String userEmail;

  login({
    required this.sessionToken,
    required this.password,
    required this.userEmail,
  });
}

//Noc Fresh Application List

class NocFreshApplicationList extends MainEvent {
  final String sessionToken;

  NocFreshApplicationList({
    required this.sessionToken,
  });
}

class NocFreshLIstloading extends MainState {}

class NocFreshListLoaded extends MainState {}

class NOClistfreshFailed extends MainState {}

//fresh application list
class NocPendingApplicationList extends MainEvent {
  final String sessionToken;

  NocPendingApplicationList({
    required this.sessionToken,
  });
}

class NocPendingLIstloading extends MainState {}

class NocPendingListLoaded extends MainState {}

class NOClistPendingFailed extends MainState {}

// Noc Approved Rejected List

class NocApprovedRejectedList extends MainEvent {
  final String sessionToken;

  NocApprovedRejectedList({
    required this.sessionToken,
  });
}

class NocApprovedRejectedLIstloading extends MainState {}

class NocApprovedRejectedListLoaded extends MainState {}

class NOClistApprovedRejectedFailed extends MainState {}

// Noc Forwarded List

class NocForwardedList extends MainEvent {
  final String sessionToken;

  NocForwardedList({
    required this.sessionToken,
  });
}

class NocForwardedLIstloading extends MainState {}

class NocForwardedListLoaded extends MainState {}

class NOClistForwardedFailed extends MainState {}

//Noc List Individual View
class NocListIndividualView extends MainEvent {
  final String sessionToken;
  final String Ids;

  NocListIndividualView({
    required this.sessionToken,
    required this.Ids,
  });
}

class NocListIndividualViewLoading extends MainState {}

class NocListIndividualViewLoaded extends MainState {}

class NocListIndividualViewFailed extends MainState {}

//Site Inspection
class SiteInspection extends MainEvent {
  final Map<String, dynamic> data;
  SiteInspection({
    required this.data,
  });
}

class SiteInspectionLoading extends MainState {}

class SiteInspectionLoaded extends MainState {}

class SiteInspectionFailed extends MainState {}

// Site Inspection BY RFO
class SiteInspectionByRFO extends MainEvent {
  final Map<String, dynamic> data;
  SiteInspectionByRFO({
    required this.data,
  });
}

class SiteInspectionByRFOLoading extends MainState {}

class SiteInspectionByRFOLoaded extends MainState {}

class SiteInspectionByRFOFailed extends MainState {}

//deputy file upload
class DeputyFileUpload extends MainEvent {
  final Map<String, dynamic> data;

  DeputyFileUpload({required this.data});
}

class DeputyFileUploadLoading extends MainState {}

class DeputyFileUploadLoaded extends MainState {}

class DeputyFileUploadFailed extends MainState {}
