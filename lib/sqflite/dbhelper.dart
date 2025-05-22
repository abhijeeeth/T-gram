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
        version: 2, // Increment version number
        onCreate: _onCreate,
        onUpgrade: _onUpgrade, // Add upgrade handler
        onOpen: (db) {
          print("Database opened successfully!");
        },
      );
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
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
        declaration_signed INTEGER,
        depty_range_officer INTEGER,
        reason_depty_ranger_office TEXT,
        deputy_officer_date TEXT,
        verify_range_officer INTEGER,
        reason_range_officer TEXT,
        range_officer_date TEXT,
        division_officer INTEGER,
        reason_division_officer TEXT,
        division_officer_date TEXT,
        payment TEXT,
        appsecond_one_date TEXT,
        appsecond_two_date TEXT,
        transit_pass_created_date TEXT,
        transit_pass_created INTEGER
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

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      print("Upgrading database from version $oldVersion to $newVersion");
      try {
        // Add missing columns to applications table
        List<String> columnsToAdd = [
          'depty_range_officer INTEGER',
          'reason_depty_ranger_office TEXT',
          'deputy_officer_date TEXT',
          'verify_range_officer INTEGER',
          'reason_range_officer TEXT',
          'range_officer_date TEXT',
          'division_officer INTEGER',
          'reason_division_officer TEXT',
          'division_officer_date TEXT',
          'payment TEXT',
          'appsecond_one_date TEXT',
          'appsecond_two_date TEXT',
          'transit_pass_created_date TEXT',
          'transit_pass_created INTEGER'
        ];

        for (var column in columnsToAdd) {
          try {
            var parts = column.split(' ');
            await db.execute(
                'ALTER TABLE applications ADD COLUMN ${parts[0]} ${parts[1]}');
            print("Added column ${parts[0]} to applications table");
          } catch (e) {
            print("Error adding column to applications table: $e");
            // Continue with next column even if one fails
          }
        }
      } catch (e) {
        print("Error during database upgrade: $e");
      }
    }
  }

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

  Future<Database> ensureDatabaseCreated() async {
    if (_database != null) {
      return _database!;
    }

    try {
      if (_database != null) {
        await _database!.close();
        _database = null;
      }

      _database = await _initDatabase();

      await _database!
          .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
      print("Database verified and ready for use");

      return _database!;
    } catch (e) {
      print("Error ensuring database creation: $e");
      rethrow;
    }
  }

  Future<String> getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, 'tigram_database.db');
  }

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

  Future<bool> initializeDatabase() async {
    try {
      final db = await ensureDatabaseCreated();

      final tables = await _getTables(db);
      print("Database tables: $tables");

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

  Future<List<Map<String, dynamic>>> _getTables(Database db) async {
    return await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'android_%'");
  }

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

  Future<int> insertApplication(Map<String, dynamic> application) async {
    Database db = await database;
    try {
      var tableInfo = await db.rawQuery("PRAGMA table_info(applications)");
      var existingColumns =
          tableInfo.map((col) => col['name'].toString()).toSet();

      var filteredData = Map<String, dynamic>.from(application);
      for (var key in application.keys) {
        if (!existingColumns.contains(key)) {
          filteredData.remove(key);
          print("Removed non-existent column from data: $key");
        }
      }

      // Use replace strategy to handle primary key conflicts
      return await db.insert('applications', filteredData,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("Error inserting application: $e");
      return -1;
    }
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

  Future<int> insertImageDocument(Map<String, dynamic> document) async {
    Database db = await database;
    return await db.insert('image_documents', document,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getImageDocuments(int appFormId) async {
    Database db = await database;
    return await db.query(
      'image_documents',
      where: 'app_form_id = ?',
      whereArgs: [appFormId],
    );
  }

  Future<int> insertTimberLog(Map<String, dynamic> log) async {
    Database db = await database;
    return await db.insert('timber_logs', log,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getTimberLogs(int appFormId) async {
    Database db = await database;
    return await db.query(
      'timber_logs',
      where: 'appform_id = ?',
      whereArgs: [appFormId],
    );
  }

  Future<int> insertSpecies(String name) async {
    Database db = await database;
    return await db.insert('species', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getAllSpecies() async {
    Database db = await database;
    return await db.query('species');
  }

  Future<int> insertAdditionalDocument(Map<String, dynamic> document) async {
    Database db = await database;
    return await db.insert('additional_documents', document,
        conflictAlgorithm: ConflictAlgorithm.replace);
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

  Future<void> saveCompleteData(Map<String, dynamic> data) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var app in data['data']['applications']) {
        await txn.insert('applications', app,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      for (var doc in data['data']['image_documents']) {
        await txn.insert('image_documents', doc,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      for (var log in data['data']['timber_log']) {
        await txn.insert('timber_logs', log,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      for (var species in data['data']['trees_species_list']) {
        await txn.insert('species', {'name': species['name']},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      for (var doc in data['data']['additional_documents']) {
        await txn.insert('additional_documents', doc,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

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
