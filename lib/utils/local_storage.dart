import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static saveToken(String? token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token!);
  }

  static getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  static removeToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
  }

  // User data methods
  static saveUserData(String id, Map<String, dynamic> userData) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_field_data_$id', jsonEncode(userData));
  }

  static getUserData(String id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userDataJson = preferences.getString('user_field_data_$id');
    return userDataJson != null ? jsonDecode(userDataJson) : null;
  }

  // Application data methods
  static saveApplicationData(String id, String responseBody) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('application_data_$id', responseBody);
  }

  static saveApplicationDetails(String id, Map<String, dynamic> details) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('application_details_$id', jsonEncode(details));
  }

  static saveTimberLog(String id, dynamic timberLog) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('timber_log_$id', jsonEncode(timberLog));
  }

  static saveSpeciesLocation(String id, dynamic speciesLocation) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('species_location_$id', jsonEncode(speciesLocation));
  }

  static saveImageDocuments(String id, dynamic imageDocuments) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('image_documents_$id', jsonEncode(imageDocuments));
  }

  // Applications data methods
  static saveApplications(List applications) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('applications', jsonEncode(applications));
  }

  static getApplications() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? applicationsJson = preferences.getString('applications');
    return applicationsJson != null ? jsonDecode(applicationsJson) : null;
  }

  static removeApplications() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('applications');
  }

  // Image documents methods
  static saveAllImageDocuments(List imageDocuments) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('image_documents', jsonEncode(imageDocuments));
  }

  static getAllImageDocuments() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? imageDocsJson = preferences.getString('image_documents');
    return imageDocsJson != null ? jsonDecode(imageDocsJson) : null;
  }

  // Timber log methods
  static saveAllTimberLogs(List timberLogs) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('timber_logs', jsonEncode(timberLogs));
  }

  static getAllTimberLogs() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? timberLogsJson = preferences.getString('timber_logs');
    return timberLogsJson != null ? jsonDecode(timberLogsJson) : null;
  }

  // Tree species list methods
  static saveTreeSpeciesList(List treeSpeciesList) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('trees_species_list', jsonEncode(treeSpeciesList));
  }

  static getTreeSpeciesList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? speciesJson = preferences.getString('trees_species_list');
    return speciesJson != null ? jsonDecode(speciesJson) : null;
  }

  // Store complete API response
  static saveApiResponse(Map<String, dynamic> response) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('api_response', jsonEncode(response));
  }

  static getApiResponse() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? responseJson = preferences.getString('api_response');
    return responseJson != null ? jsonDecode(responseJson) : null;
  }

  // Clear all data
  static clearAll() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
