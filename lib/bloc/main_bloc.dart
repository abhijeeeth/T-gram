import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigramnks/server/serverhelper.dart';

// Define the Bloc
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<SaveLocallyFieldVerifyData>(_savbeLocallyFieldVerifyData);
    // TODO: implement event handler
  }

  FutureOr<void> _savbeLocallyFieldVerifyData(
      SaveLocallyFieldVerifyData event, Emitter<MainState> emit) async {
    try {
      // Store the basic user data
      final prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> userData = {
        'sessionToken': event.sessionToken,
        'userGroup': event.userGroup,
        'userId': event.userId,
        'Ids': event.Ids,
        'Range': event.Range,
        'userName': event.userName,
        'userEmail': event.userEmail,
      };

      await prefs.setString(
          'user_field_data_${event.Ids}', json.encode(userData));

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
        Map<String, dynamic> responseJSON = json.decode(response.body);

        // Store the full response data
        await prefs.setString('application_data_${event.Ids}', response.body);

        // Extract and store specific data categories separately for easier access
        if (responseJSON['data'] != null) {
          if (responseJSON['data']['applications'] != null &&
              responseJSON['data']['applications'].isNotEmpty) {
            await prefs.setString('application_details_${event.Ids}',
                json.encode(responseJSON['data']['applications'][0]));
          }

          if (responseJSON['data']['timber_log'] != null) {
            await prefs.setString('timber_log_${event.Ids}',
                json.encode(responseJSON['data']['timber_log']));
          }

          if (responseJSON['data']['species_location'] != null) {
            await prefs.setString('species_location_${event.Ids}',
                json.encode(responseJSON['data']['species_location']));
          }

          if (responseJSON['data']['image_documents'] != null) {
            await prefs.setString('image_documents_${event.Ids}',
                json.encode(responseJSON['data']['image_documents']));
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
