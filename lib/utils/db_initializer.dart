import 'package:flutter/material.dart';

import '../sqflite/dbhelper.dart';

class DatabaseInitializer {
  static final DbHelper _dbHelper = DbHelper();

  // Call this at application startup
  static Future<bool> initializeDatabase() async {
    try {
      // Try to initialize
      bool success = await _dbHelper.initializeDatabase();

      if (!success) {
        // If initialization failed, try to reset
        print("Database initialization failed, attempting to reset");
        success = await _dbHelper.resetDatabase();
      }

      // Print database statistics
      var stats = await _dbHelper.getDatabaseStats();
      print("Database stats: $stats");

      return success;
    } catch (e) {
      print("Fatal error initializing database: $e");
      return false;
    }
  }

  // Use this in your app's main.dart or startup sequence
  static Widget wrapWithDatabaseInitialization({
    required Widget child,
    required Widget loadingWidget,
    required Widget errorWidget,
  }) {
    return FutureBuilder<bool>(
      future: initializeDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        } else if (snapshot.hasError || snapshot.data == false) {
          return errorWidget;
        } else {
          return child;
        }
      },
    );
  }
}
