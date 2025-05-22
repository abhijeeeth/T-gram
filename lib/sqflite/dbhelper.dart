import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Modified database initialization with better error handling
  Future<Database> _initDatabase() async {
    try {
      // Get the proper directory for storing the database
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'tigram_database.db');

      // Ensure the directory exists
      await Directory(dirname(path)).create(recursive: true);

      print("Database path: $path");

      // Open the database with explicit onCreate callback
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onOpen: (db) {
          print("Database opened successfully!");
        },
      );
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
    }
  }

  // Check if database exists and is accessible
  Future<bool> isDatabaseCreated() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'tigram_database.db');
      return await databaseExists(path);
    } catch (e) {
      print("Error checking database existence: $e");
      return false;
    }
  }

  // Force database creation
  Future<Database> ensureDatabaseCreated() async {
    if (_database != null) {
      return _database!;
    }

    try {
      // Close any existing instance
      if (_database != null) {
        await _database!.close();
        _database = null;
      }

      // Initialize fresh
      _database = await _initDatabase();

      // Verify tables exist by trying a simple query
      await _database!
          .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
      print("Database verified and ready for use");

      return _database!;
    } catch (e) {
      print("Error ensuring database creation: $e");
      rethrow;
    }
  }

  // Get database path for debugging
  Future<String> getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, 'tigram_database.db');
  }

  // Helper to delete the database (for troubleshooting)
  Future<void> deleteDatabase() async {
    try {
      String path = await getDatabasePath();
      await databaseFactory.deleteDatabase(path);
      _database = null;
      print("Database deleted successfully");
    } catch (e) {
      print("Error deleting database: $e");
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    // Applications table
    await db.execute('''
      CREATE TABLE applications (
        id INTEGER PRIMARY KEY,
        application_no TEXT,
        by_user_id INTEGER,
        name TEXT,
        address TEXT,
        id_type TEXT,
        id_card_number TEXT,
        survey_no TEXT,
        state TEXT,
        other_state INTEGER,
        district TEXT,
        taluka TEXT,
        block TEXT,
        extend REAL,
        division TEXT,
        area_range TEXT,
        pincode TEXT,
        approved_by_id INTEGER,
        proof_of_ownership_of_tree TEXT,
        village TEXT,
        species_of_trees TEXT,
        location_lat TEXT,
        location_log TEXT,
        purpose TEXT,
        trees_proposed_to_cut TEXT,
        trees_cutted INTEGER,
        total_trees INTEGER,
        destination_details TEXT,
        destination_state TEXT,
        signature_img INTEGER,
        revenue_application INTEGER,
        location_sktech INTEGER,
        tree_ownership_detail INTEGER,
        aadhar_detail INTEGER,
        application_status TEXT,
        disapproved_reason TEXT,
        verify_office INTEGER,
        reason_office TEXT,
        verify_office_date TEXT,
        current_app_status TEXT,
        created_date TEXT,
        declaration_signed INTEGER
      )
    ''');

    // Image documents table
    await db.execute('''
      CREATE TABLE image_documents (
        id INTEGER PRIMARY KEY,
        app_form_id INTEGER,
        signature_img TEXT,
        revenue_approval TEXT,
        declaration TEXT,
        revenue_application TEXT,
        location_sktech TEXT,
        tree_ownership_detail TEXT,
        aadhar_detail TEXT,
        location_img1 TEXT,
        location_img2 TEXT,
        location_img3 TEXT,
        location_img4 TEXT,
        image1_lat TEXT,
        image2_lat TEXT,
        image3_lat TEXT,
        image4_lat TEXT,
        image1_log TEXT,
        image2_log TEXT,
        image3_log TEXT,
        image4_log TEXT,
        additional_doc1 TEXT,
        additional_doc2 TEXT,
        additional_doc3 TEXT,
        additional_doc4 TEXT,
        additional_doc5 TEXT,
        FOREIGN KEY (app_form_id) REFERENCES applications (id)
      )
    ''');

    // Timber log table
    await db.execute('''
      CREATE TABLE timber_logs (
        id INTEGER PRIMARY KEY,
        appform_id INTEGER,
        transit_id INTEGER,
        species_of_tree TEXT,
        length REAL,
        breadth REAL,
        volume REAL,
        latitude TEXT,
        longitude TEXT,
        log_qr_code TEXT,
        log_qr_code_img TEXT,
        is_transited INTEGER,
        FOREIGN KEY (appform_id) REFERENCES applications (id)
      )
    ''');

    // Species table
    await db.execute('''
      CREATE TABLE species (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');

    // Additional documents table
    await db.execute('''
      CREATE TABLE additional_documents (
        id INTEGER PRIMARY KEY,
        app_form_id INTEGER,
        category TEXT,
        document TEXT,
        name TEXT,
        uploaded_at TEXT,
        FOREIGN KEY (app_form_id) REFERENCES applications (id)
      )
    ''');
  }

  // Initialize and validate database - call this early in your app startup
  Future<bool> initializeDatabase() async {
    try {
      // Force database creation
      final db = await ensureDatabaseCreated();

      // Verify all tables exist
      final tables = await _getTables(db);
      print("Database tables: $tables");

      // Check for required tables
      final requiredTables = [
        'applications',
        'image_documents',
        'timber_logs',
        'species',
        'additional_documents'
      ];

      final allTablesExist = requiredTables
          .every((table) => tables.any((t) => t['name'] == table));

      if (!allTablesExist) {
        print("WARNING: Some required tables are missing!");
        // Force recreation
        await deleteDatabase();
        await ensureDatabaseCreated();
        return false;
      }

      print("Database initialized successfully with all required tables");
      return true;
    } catch (e) {
      print("Error initializing database: $e");
      return false;
    }
  }

  // Get list of all tables in the database
  Future<List<Map<String, dynamic>>> _getTables(Database db) async {
    return await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'android_%'");
  }

  // Check if a table exists
  Future<bool> tableExists(String tableName) async {
    try {
      final db = await database;
      final tables = await _getTables(db);
      return tables.any((t) => t['name'] == tableName);
    } catch (e) {
      print("Error checking if table exists: $e");
      return false;
    }
  }

  // Helper method to recreate database from scratch
  Future<bool> resetDatabase() async {
    try {
      await deleteDatabase();
      await ensureDatabaseCreated();
      return true;
    } catch (e) {
      print("Error resetting database: $e");
      return false;
    }
  }

  // Get database statistics for debugging
  Future<Map<String, dynamic>> getDatabaseStats() async {
    try {
      final db = await database;
      final tables = await _getTables(db);

      Map<String, dynamic> stats = {
        'dbPath': await getDatabasePath(),
        'tables': tables.length,
        'tableNames': tables.map((t) => t['name']).toList(),
        'counts': <String, int>{},
      };

      // Get count of records in each table
      for (var table in tables) {
        final tableName = table['name'] as String;
        final countResult =
            await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
        stats['counts'][tableName] = Sqflite.firstIntValue(countResult) ?? 0;
      }

      return stats;
    } catch (e) {
      print("Error getting database stats: $e");
      return {'error': e.toString()};
    }
  }

  // CRUD operations for Applications
  Future<int> insertApplication(Map<String, dynamic> application) async {
    Database db = await database;
    return await db.insert('applications', application);
  }

  Future<List<Map<String, dynamic>>> getApplications() async {
    Database db = await database;
    return await db.query('applications');
  }

  Future<Map<String, dynamic>?> getApplication(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'applications',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateApplication(Map<String, dynamic> application) async {
    Database db = await database;
    return await db.update(
      'applications',
      application,
      where: 'id = ?',
      whereArgs: [application['id']],
    );
  }

  Future<int> deleteApplication(int id) async {
    Database db = await database;
    await db
        .delete('image_documents', where: 'app_form_id = ?', whereArgs: [id]);
    await db.delete('timber_logs', where: 'appform_id = ?', whereArgs: [id]);
    await db.delete('additional_documents',
        where: 'app_form_id = ?', whereArgs: [id]);
    return await db.delete('applications', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for Image Documents
  Future<int> insertImageDocument(Map<String, dynamic> document) async {
    Database db = await database;
    return await db.insert('image_documents', document);
  }

  Future<List<Map<String, dynamic>>> getImageDocuments(int appFormId) async {
    Database db = await database;
    return await db.query(
      'image_documents',
      where: 'app_form_id = ?',
      whereArgs: [appFormId],
    );
  }

  // CRUD operations for Timber Logs
  Future<int> insertTimberLog(Map<String, dynamic> log) async {
    Database db = await database;
    return await db.insert('timber_logs', log);
  }

  Future<List<Map<String, dynamic>>> getTimberLogs(int appFormId) async {
    Database db = await database;
    return await db.query(
      'timber_logs',
      where: 'appform_id = ?',
      whereArgs: [appFormId],
    );
  }

  // CRUD operations for Species
  Future<int> insertSpecies(String name) async {
    Database db = await database;
    return await db.insert('species', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getAllSpecies() async {
    Database db = await database;
    return await db.query('species');
  }

  // CRUD operations for Additional Documents
  Future<int> insertAdditionalDocument(Map<String, dynamic> document) async {
    Database db = await database;
    return await db.insert('additional_documents', document);
  }

  Future<List<Map<String, dynamic>>> getAdditionalDocuments(
      int appFormId) async {
    Database db = await database;
    return await db.query(
      'additional_documents',
      where: 'app_form_id = ?',
      whereArgs: [appFormId],
    );
  }

  // Save complete data from API response
  Future<void> saveCompleteData(Map<String, dynamic> data) async {
    // Begin transaction
    final db = await database;
    await db.transaction((txn) async {
      // Save applications
      for (var app in data['data']['applications']) {
        await txn.insert('applications', app,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Save image documents
      for (var doc in data['data']['image_documents']) {
        await txn.insert('image_documents', doc,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Save timber logs
      for (var log in data['data']['timber_log']) {
        await txn.insert('timber_logs', log,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Save species list
      for (var species in data['data']['trees_species_list']) {
        await txn.insert('species', {'name': species['name']},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // Save additional documents
      for (var doc in data['data']['additional_documents']) {
        await txn.insert('additional_documents', doc,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  // Get complete data for an application
  Future<Map<String, dynamic>> getCompleteApplicationData(
      int applicationId) async {
    final db = await database;

    final application = await getApplication(applicationId);
    if (application == null) {
      return {'status': 'Error', 'message': 'Application not found'};
    }

    final imageDocuments = await getImageDocuments(applicationId);
    final timberLogs = await getTimberLogs(applicationId);
    final additionalDocuments = await getAdditionalDocuments(applicationId);
    final species = await getAllSpecies();

    return {
      'status': 'Success',
      'message': 'Data Fetched Successfully.',
      'data': {
        'applications': [application],
        'image_documents': imageDocuments,
        'timber_log': timberLogs,
        'additional_documents': additionalDocuments,
        'trees_species_list': species.map((s) => {'name': s['name']}).toList(),
      }
    };
  }
}
