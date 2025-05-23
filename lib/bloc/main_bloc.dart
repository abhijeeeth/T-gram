import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/sqflite/dbhelper.dart'; // Add this import
import 'package:tigramnks/utils/local_storage.dart';

// Define the Bloc
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<SaveLocallyFieldVerifyData>(_savbeLocallyFieldVerifyData);
    on<FetchSpeciesList>(_fetchSpeciesList);
    on<UploadData>(_uploadData);
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
      log('Uploading data: ${event.data}');
      // Extract required fields from event.data
      final String sessionToken = event.data['sessionToken'];
      final String Ids = event.data['app_id'];
      final String base64ImagePic1 = event.data['base64ImagePic1'];
      final String base64ImagePic2 = event.data['base64ImagePic2'];
      final String base64ImagePic3 = event.data['base64ImagePic3'];
      final String base64ImagePic4 = event.data['base64ImagePic4'];
      final String summary = event.data['summary'];
      final dynamic logDetails = event.data['log_details'];
      final dynamic latImage1 = event.data['image1_lat'];
      final dynamic latImage2 = event.data['image2_lat'];
      final dynamic latImage3 = event.data['image3_lat'];
      final dynamic latImage4 = event.data['image4_lat'];
      final dynamic longImage1 = event.data['image1_log'];
      final dynamic longImage2 = event.data['image2_log'];
      final dynamic longImage3 = event.data['image3_log'];
      final dynamic longImage4 = event.data['image4_log'];

      const String url = '${ServerHelper.baseUrl}auth/field_verify/';
      Map<String, dynamic> data = {
        "app_id": Ids,
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
      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      print(body.toString());

      if (responseJson['message'] !=
          "Successfully uploaded images and location details.") {
        emit(FieldVerifyDataSavedState(
            success: false, error: "Something went wrong"));
      } else {
        emit(FieldVerifyDataSavedState(success: true));
      }
    } catch (e) {
      emit(FieldVerifyDataSavedState(success: false, error: e.toString()));
    }
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
