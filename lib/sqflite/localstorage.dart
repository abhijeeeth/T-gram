// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class LocalStorage {
//   // Generic methods to reduce code duplication
//   static Future<void> saveData(String key, dynamic data) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     if (data is String) {
//       preferences.setString(key, data);
//     } else {
//       preferences.setString(key, jsonEncode(data));
//     }
//   }

//   static Future<T?> getData<T>(String key,
//       {T Function(dynamic)? fromJson}) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     final String? jsonData = preferences.getString(key);
//     if (jsonData == null) return null;

//     if (T == String) return jsonData as T?;

//     final dynamic decodedData = jsonDecode(jsonData);
//     if (fromJson != null) return fromJson(decodedData);
//     return decodedData as T?;
//   }

//   static Future<void> removeData(String key) async {
//     final SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.remove(key);
//   }

//   // Token methods
//   static Future<void> saveToken(String? token) async {
//     if (token != null) {
//       await saveData('token', token);
//     }
//   }

//   static Future<String?> getToken() async {
//     return await getData<String>('token');
//   }

//   static Future<void> removeToken() async {
//     await removeData('token');
//   }

//   // Applications data methods
//   static Future<void> saveApplications(List applications) async {
//     await saveData('applications', applications);
//   }

//   static Future<List?> getApplications() async {
//     return await getData<List>('applications');
//   }

//   static Future<void> removeApplications() async {
//     await removeData('applications');
//   }

//   // Application-specific data methods (for ApplicationDetailsPage)
//   static Future<void> saveApplicationData(
//       String applicationId, String data) async {
//     await saveData('app_data_$applicationId', data);
//   }

//   static Future<String?> getApplicationData(String applicationId) async {
//     return await getData<String>('app_data_$applicationId');
//   }

//   static Future<void> saveApplicationDetails(
//       String applicationId, Map<String, dynamic> details) async {
//     await saveData('app_details_$applicationId', details);
//   }

//   static Future<Map<String, dynamic>?> getApplicationDetails(
//       String applicationId) async {
//     return await getData<Map<String, dynamic>>('app_details_$applicationId');
//   }

//   static Future<void> saveTimberLog(
//       String applicationId, dynamic timberLog) async {
//     await saveData('timber_log_$applicationId', timberLog);
//   }

//   static Future<List?> getTimberLog(String applicationId) async {
//     return await getData<List>('timber_log_$applicationId');
//   }

//   static Future<void> saveSpeciesLocation(
//       String applicationId, dynamic speciesLocation) async {
//     await saveData('species_location_$applicationId', speciesLocation);
//   }

//   static Future<List?> getSpeciesLocation(String applicationId) async {
//     return await getData<List>('species_location_$applicationId');
//   }

//   static Future<void> saveImageDocuments(
//       String applicationId, dynamic imageDocuments) async {
//     await saveData('image_documents_$applicationId', imageDocuments);
//   }

//   static Future<List?> getImageDocuments(String applicationId) async {
//     return await getData<List>('image_documents_$applicationId');
//   }

//   // Image documents methods
//   static Future<void> saveAllImageDocuments(List imageDocuments) async {
//     await saveData('image_documents', imageDocuments);
//   }

//   static Future<List?> getAllImageDocuments() async {
//     return await getData<List>('image_documents');
//   }

//   static Future<void> removeAllImageDocuments() async {
//     await removeData('image_documents');
//   }

//   // Timber log methods
//   static Future<void> saveTimberLogs(List timberLogs) async {
//     await saveData('timber_logs', timberLogs);
//   }

//   static Future<List?> getTimberLogs() async {
//     return await getData<List>('timber_logs');
//   }

//   static Future<void> removeTimberLogs() async {
//     await removeData('timber_logs');
//   }

//   // Tree species list methods
//   static Future<void> saveTreeSpeciesList(List treeSpeciesList) async {
//     await saveData('trees_species_list', treeSpeciesList);
//   }

//   static Future<List?> getTreeSpeciesList() async {
//     return await getData<List>('trees_species_list');
//   }

//   static Future<void> removeTreeSpeciesList() async {
//     await removeData('trees_species_list');
//   }

//   // Additional documents methods
//   static Future<void> saveAdditionalDocuments(List additionalDocs) async {
//     await saveData('additional_documents', additionalDocs);
//   }

//   static Future<List?> getAdditionalDocuments() async {
//     return await getData<List>('additional_documents');
//   }

//   static Future<void> removeAdditionalDocuments() async {
//     await removeData('additional_documents');
//   }

//   // Store complete API response
//   static Future<void> saveApiResponse(Map<String, dynamic> response) async {
//     await saveData('api_response', response);
//   }

//   static Future<Map<String, dynamic>?> getApiResponse() async {
//     return await getData<Map<String, dynamic>>('api_response');
//   }

//   static Future<void> removeApiResponse() async {
//     await removeData('api_response');
//   }

//   static Future<void> savEmail(String email) async {
//     await saveData('email', email);
//   }

//   static Future<String?> getEmail() async {
//     return await getData<String>('email');
//   }

//   static Future<void> removeEmail() async {
//     await removeData('email');
//   }

//   static Future<void> userGroup(String group) async {
//     await saveData('user_group', group);
//   }

//   static Future<String?> getUserGroup() async {
//     return await getData<String>('user_group');
//   }

//   static Future<void> removeUserGroup() async {
//     await removeData('user_group');
//   }
// }
