import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Generic methods to reduce code duplication
  static Future<void> saveData(String key, dynamic data) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (data is String) {
      preferences.setString(key, data);
    } else {
      preferences.setString(key, jsonEncode(data));
    }
  }

  static Future<T?> getData<T>(String key,
      {T Function(dynamic)? fromJson}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? jsonData = preferences.getString(key);
    if (jsonData == null) return null;

    if (T == String) return jsonData as T?;

    final dynamic decodedData = jsonDecode(jsonData);
    if (fromJson != null) return fromJson(decodedData);
    return decodedData as T?;
  }

  static Future<void> removeData(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  // Token methods
  static Future<void> saveToken(String? token) async {
    if (token != null) {
      await saveData('token', token);
    }
  }

  static Future<String?> getToken() async {
    return await getData<String>('token');
  }

  static Future<void> removeToken() async {
    await removeData('token');
  }

  // UserGroup methods
  static Future<void> saveUserGroup(String? userGroup) async {
    if (userGroup != null) {
      await saveData('userGroup', userGroup);
    }
  }

  static Future<String?> getUserGroup() async {
    return await getData<String>('userGroup');
  }

  static Future<void> removeUserGroup() async {
    await removeData('userGroup');
  }

  // userId methods
  static Future<void> saveUserId(String? userId) async {
    if (userId != null) {
      await saveData('userId', userId);
    }
  }

  static Future<String?> getUserId() async {
    return await getData<String>('userId');
  }

  static Future<void> removeUserId() async {
    await removeData('userId');
  }

  // Range methods
  static Future<void> saveRange(String? range) async {
    if (range != null) {
      await saveData('Range', range);
    }
  }

  static Future<String?> getRange() async {
    return await getData<String>('Range');
  }

  static Future<void> removeRange() async {
    await removeData('Range');
  }

  // userEmail methods
  static Future<void> saveUserEmail(String? userEmail) async {
    if (userEmail != null) {
      await saveData('userEmail', userEmail);
    }
  }

  static Future<String?> getUserEmail() async {
    return await getData<String>('userEmail');
  }

  static Future<void> removeUserEmail() async {
    await removeData('userEmail');
  }

  // userName methods
  static Future<void> saveUserName(String? userName) async {
    if (userName != null) {
      await saveData('userName', userName);
    }
  }

  static Future<String?> getUserName() async {
    return await getData<String>('userName');
  }

  static Future<void> removeUserName() async {
    await removeData('userName');
  }

  // userMobile methods
  static Future<void> saveUserMobile(String? userMobile) async {
    if (userMobile != null) {
      await saveData('userMobile', userMobile);
    }
  }

  static Future<String?> getUserMobile() async {
    return await getData<String>('userMobile');
  }

  static Future<void> removeUserMobile() async {
    await removeData('userMobile');
  }

  // userAddress methods
  static Future<void> saveUserAddress(String? userAddress) async {
    if (userAddress != null) {
      await saveData('userAddress', userAddress);
    }
  }

  static Future<String?> getUserAddress() async {
    return await getData<String>('userAddress');
  }

  static Future<void> removeUserAddress() async {
    await removeData('userAddress');
  }
}
