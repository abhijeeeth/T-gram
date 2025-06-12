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
        version: 6, // Increment version number to 6
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

    // Transit passes table
    await db.execute('''
      CREATE TABLE transit_passes (
        id INTEGER PRIMARY KEY,
        species_of_tree TEXT,
        length REAL,
        breadth REAL,
        volume REAL,
        latitude TEXT,
        longitude TEXT,
        log_qr_code TEXT,
        log_qr_code_img TEXT,
        is_transited INTEGER,
        appform INTEGER,
        transit INTEGER,
        FOREIGN KEY (appform) REFERENCES applications (id)
      )
    ''');

    // Application locations table
    await db.execute('''
      CREATE TABLE application_locations (
        id INTEGER PRIMARY KEY,
        app_form_id INTEGER,
        location_img1 TEXT,
        location_img2 TEXT,
        location_img3 TEXT,
        location_img4 TEXT,
        summary TEXT,
        log_details TEXT,
        image1_lat TEXT,
        image2_lat TEXT,
        image3_lat TEXT,
        image4_lat TEXT,
        image1_log TEXT,
        image2_log TEXT,
        image3_log TEXT,
        image4_log TEXT,
        created_at TEXT,
        FOREIGN KEY (app_form_id) REFERENCES applications (id)
      )
    ''');

    // NOC Applications table
    await db.execute('''
      CREATE TABLE noc_applications (
        id INTEGER PRIMARY KEY,
        noc_of_land_application_id TEXT,
        by_user_id INTEGER,
        previous_noc_id TEXT,
        division TEXT,
        range TEXT,
        has_applied_before INTEGER,
        previous_noc TEXT,
        name TEXT,
        noc_issued_name TEXT,
        other_name TEXT,
        is_institute INTEGER,
        designation TEXT,
        institute_name TEXT,
        address TEXT,
        survey_number TEXT,
        district TEXT,
        taluka TEXT,
        with_forest INTEGER,
        approximate_distance TEXT,
        village TEXT,
        panchayat TEXT,
        legislative_assembly TEXT,
        block TEXT,
        pin_code TEXT,
        purpose TEXT,
        selected_id_proof TEXT,
        photo_id_proof TEXT,
        ownership_pattyam TEXT,
        registration_deed TEXT,
        possession_certificate TEXT,
        land_tax_receipt TEXT,
        noc_created_at TEXT,
        clerk_division_id INTEGER,
        clerk_division_comment_step_one TEXT,
        clerk_division_file_step_one TEXT,
        clerk_division_step_one_comment_date TEXT,
        clerk_division_step_one_application_status TEXT,
        clerk_division_comment_step_two TEXT,
        clerk_division_file_step_two TEXT,
        clerk_division_step_two_comment_date TEXT,
        clerk_division_step_two_application_status TEXT,
        assigned_dyrfo_user_id INTEGER,
        ministerial_head_id INTEGER,
        ministerial_head_comment_step_one TEXT,
        ministerial_head_file_step_one TEXT,
        ministerial_head_step_one_comment_date TEXT,
        ministerial_head_step_one_application_status TEXT,
        ministerial_head_comment_step_two TEXT,
        ministerial_head_file_step_two TEXT,
        ministerial_head_step_two_comment_date TEXT,
        ministerial_head_step_two_application_status TEXT,
        dfo_id INTEGER,
        dfo_comment_step_one TEXT,
        dfo_file_step_one TEXT,
        dfo_step_one_comment_date TEXT,
        dfo_step_one_application_status TEXT,
        dfo_comment_step_two TEXT,
        dfo_file_step_two TEXT,
        dfo_step_two_comment_date TEXT,
        dfo_step_two_application_status TEXT,
        clerk_range_id INTEGER,
        clerk_range_comment TEXT,
        clerk_range_file TEXT,
        clerk_range_comment_date TEXT,
        clerk_range_application_status TEXT,
        rfo_id INTEGER,
        rfo_comment_step_one TEXT,
        rfo_file_step_one TEXT,
        rfo_step_one_comment_date TEXT,
        rfo_step_one_application_status TEXT,
        rfo_comment_step_two TEXT,
        rfo_file_step_two TEXT,
        rfo_step_two_comment_date TEXT,
        rfo_step_two_application_status TEXT,
        dyrfo_id INTEGER,
        dyrfo_comment TEXT,
        dyrfo_file TEXT,
        dyrfo_comment_date TEXT,
        dyrfo_application_status TEXT,
        inspection_report TEXT,
        survey_report TEXT,
        survey_sketches TEXT,
        dfo_digital_signature TEXT,
        clarification_sought TEXT,
        returned_on TEXT,
        clarification_response TEXT,
        site_inception INTEGER,
        step_status TEXT,
        rfo_site_inception INTEGER,
        site_inception_rfo INTEGER
      )
    ''');

    // Division Comments and Files table
    await db.execute('''
      CREATE TABLE division_comments_and_files (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        noc_application_id INTEGER,
        officer TEXT,
        comment TEXT,
        file TEXT,
        date TEXT,
        FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
      )
    ''');

    // Clerk Comments and Files table
    await db.execute('''
      CREATE TABLE clerk_comments_and_files (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        noc_application_id INTEGER,
        officer TEXT,
        comment TEXT,
        file TEXT,
        date TEXT,
        FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
      )
    ''');

    // Deputy RFOs table
    await db.execute('''
      CREATE TABLE deputy_rfos (
        id INTEGER PRIMARY KEY,
        noc_application_id INTEGER,
        name TEXT,
        address TEXT,
        FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
      )
    ''');

    // Image Documents NOC table
    await db.execute('''
      CREATE TABLE image_documents_noc (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        noc_application_id INTEGER,
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
        FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
      )
    ''');

    // Additional Documents NOC table
    await db.execute('''
      CREATE TABLE additional_documents_noc (
        id INTEGER PRIMARY KEY,
        noc_application_id INTEGER,
        category TEXT,
        document TEXT,
        name TEXT,
        uploaded_at TEXT,
        FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
      )
    ''');

    // Application Location Images table
    await db.execute('''
      CREATE TABLE application_location_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        app_id INTEGER,
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
        image4_log TEXT
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

        // Create transit_passes table if it doesn't exist
        try {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS transit_passes (
              id INTEGER PRIMARY KEY,
              species_of_tree TEXT,
              length REAL,
              breadth REAL,
              volume REAL,
              latitude TEXT,
              longitude TEXT,
              log_qr_code TEXT,
              log_qr_code_img TEXT,
              is_transited INTEGER,
              appform INTEGER,
              transit INTEGER,
              FOREIGN KEY (appform) REFERENCES applications (id)
            )
          ''');
          print("Created transit_passes table");
        } catch (e) {
          print("Error creating transit_passes table: $e");
        }
      } catch (e) {
        print("Error during database upgrade: $e");
      }
    }

    if (oldVersion < 3) {
      print("Upgrading database from version $oldVersion to $newVersion");
      try {
        // Create application_locations table if it doesn't exist
        await db.execute('''
          CREATE TABLE IF NOT EXISTS application_locations (
            id INTEGER PRIMARY KEY,
            app_form_id INTEGER,
            location_img1 TEXT,
            location_img2 TEXT,
            location_img3 TEXT,
            location_img4 TEXT,
            summary TEXT,
            log_details TEXT,
            image1_lat TEXT,
            image2_lat TEXT,
            image3_lat TEXT,
            image4_lat TEXT,
            image1_log TEXT,
            image2_log TEXT,
            image3_log TEXT,
            image4_log TEXT,
            created_at TEXT,
            FOREIGN KEY (app_form_id) REFERENCES applications (id)
          )
        ''');
        print("Created application_locations table");
      } catch (e) {
        print("Error creating application_locations table: $e");
      }
    }

    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS noc_applications (
          id INTEGER PRIMARY KEY,
          noc_of_land_application_id TEXT,
          by_user_id INTEGER,
          previous_noc_id TEXT,
          division TEXT,
          range TEXT,
          has_applied_before INTEGER,
          previous_noc TEXT,
          name TEXT,
          noc_issued_name TEXT,
          other_name TEXT,
          is_institute INTEGER,
          designation TEXT,
          institute_name TEXT,
          address TEXT,
          survey_number TEXT,
          district TEXT,
          taluka TEXT,
          with_forest INTEGER,
          approximate_distance TEXT,
          village TEXT,
          panchayat TEXT,
          legislative_assembly TEXT,
          block TEXT,
          pin_code TEXT,
          purpose TEXT,
          selected_id_proof TEXT,
          photo_id_proof TEXT,
          ownership_pattyam TEXT,
          registration_deed TEXT,
          possession_certificate TEXT,
          land_tax_receipt TEXT,
          noc_created_at TEXT,
          clerk_division_id INTEGER,
          clerk_division_comment_step_one TEXT,
          clerk_division_file_step_one TEXT,
          clerk_division_step_one_comment_date TEXT,
          clerk_division_step_one_application_status TEXT,
          clerk_division_comment_step_two TEXT,
          clerk_division_file_step_two TEXT,
          clerk_division_step_two_comment_date TEXT,
          clerk_division_step_two_application_status TEXT,
          assigned_dyrfo_user_id INTEGER,
          ministerial_head_id INTEGER,
          ministerial_head_comment_step_one TEXT,
          ministerial_head_file_step_one TEXT,
          ministerial_head_step_one_comment_date TEXT,
          ministerial_head_step_one_application_status TEXT,
          ministerial_head_comment_step_two TEXT,
          ministerial_head_file_step_two TEXT,
          ministerial_head_step_two_comment_date TEXT,
          ministerial_head_step_two_application_status TEXT,
          dfo_id INTEGER,
          dfo_comment_step_one TEXT,
          dfo_file_step_one TEXT,
          dfo_step_one_comment_date TEXT,
          dfo_step_one_application_status TEXT,
          dfo_comment_step_two TEXT,
          dfo_file_step_two TEXT,
          dfo_step_two_comment_date TEXT,
          dfo_step_two_application_status TEXT,
          clerk_range_id INTEGER,
          clerk_range_comment TEXT,
          clerk_range_file TEXT,
          clerk_range_comment_date TEXT,
          clerk_range_application_status TEXT,
          rfo_id INTEGER,
          rfo_comment_step_one TEXT,
          rfo_file_step_one TEXT,
          rfo_step_one_comment_date TEXT,
          rfo_step_one_application_status TEXT,
          rfo_comment_step_two TEXT,
          rfo_file_step_two TEXT,
          rfo_step_two_comment_date TEXT,
          rfo_step_two_application_status TEXT,
          dyrfo_id INTEGER,
          dyrfo_comment TEXT,
          dyrfo_file TEXT,
          dyrfo_comment_date TEXT,
          dyrfo_application_status TEXT,
          inspection_report TEXT,
          survey_report TEXT,
          survey_sketches TEXT,
          dfo_digital_signature TEXT,
          clarification_sought TEXT,
          returned_on TEXT,
          clarification_response TEXT,
          site_inception INTEGER,
          step_status TEXT,
          rfo_site_inception INTEGER,
          site_inception_rfo INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS division_comments_and_files (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          noc_application_id INTEGER,
          officer TEXT,
          comment TEXT,
          file TEXT,
          date TEXT,
          FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS clerk_comments_and_files (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          noc_application_id INTEGER,
          officer TEXT,
          comment TEXT,
          file TEXT,
          date TEXT,
          FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS deputy_rfos (
          id INTEGER PRIMARY KEY,
          noc_application_id INTEGER,
          name TEXT,
          address TEXT,
          FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS image_documents_noc (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          noc_application_id INTEGER,
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
          FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS additional_documents_noc (
          id INTEGER PRIMARY KEY,
          noc_application_id INTEGER,
          category TEXT,
          document TEXT,
          name TEXT,
          uploaded_at TEXT,
          FOREIGN KEY (noc_application_id) REFERENCES noc_applications (id)
        )
      ''');
    }

    // Add this for upgrades from version 4 to 5 (or higher)
    if (oldVersion < 5) {
      try {
        await db.execute(
            "ALTER TABLE noc_applications ADD COLUMN rfo_site_inception INTEGER");
      } catch (e) {
        print("Column rfo_site_inception may already exist: $e");
      }
      try {
        await db.execute(
            "ALTER TABLE noc_applications ADD COLUMN site_inception_rfo INTEGER");
      } catch (e) {
        print("Column site_inception_rfo may already exist: $e");
      }
    }
    // Ensure columns exist for any upgrade (defensive)
    try {
      var tableInfo = await db.rawQuery("PRAGMA table_info(noc_applications)");
      var columns = tableInfo.map((col) => col['name']).toSet();
      if (!columns.contains('rfo_site_inception')) {
        await db.execute(
            "ALTER TABLE noc_applications ADD COLUMN rfo_site_inception INTEGER");
        print("Added missing column rfo_site_inception to noc_applications");
      }
      if (!columns.contains('site_inception_rfo')) {
        await db.execute(
            "ALTER TABLE noc_applications ADD COLUMN site_inception_rfo INTEGER");
        print("Added missing column site_inception_rfo to noc_applications");
      }
    } catch (e) {
      print("Error ensuring columns in noc_applications: $e");
    }

    // Defensive: create application_location_images table if not exists
    try {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS application_location_images (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          app_id INTEGER,
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
          image4_log TEXT
        )
      ''');
      print("Ensured application_location_images table exists");
    } catch (e) {
      print("Error creating application_location_images table: $e");
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
        'additional_documents',
        'transit_passes',
        'application_locations',
        'noc_applications',
        'division_comments_and_files',
        'clerk_comments_and_files',
        'deputy_rfos',
        'image_documents_noc',
        'additional_documents_noc'
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

      return await db.insert('applications', filteredData);
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
    await db.delete('transit_passes', where: 'appform = ?', whereArgs: [id]);
    await db.delete('application_locations',
        where: 'app_form_id = ?', whereArgs: [id]);
    return await db.delete('applications', where: 'id = ?', whereArgs: [id]);
  }

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

  Future<int> insertTransitPass(Map<String, dynamic> transitPass) async {
    Database db = await database;
    return await db.insert('transit_passes', transitPass);
  }

  Future<List<Map<String, dynamic>>> getTransitPasses(int appFormId) async {
    Database db = await database;
    return await db.query(
      'transit_passes',
      where: 'appform = ?',
      whereArgs: [appFormId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllTransitPasses() async {
    Database db = await database;
    return await db.query('transit_passes');
  }

  Future<int> updateTransitPass(Map<String, dynamic> transitPass) async {
    Database db = await database;
    return await db.update(
      'transit_passes',
      transitPass,
      where: 'id = ?',
      whereArgs: [transitPass['id']],
    );
  }

  Future<int> deleteTransitPass(int id) async {
    Database db = await database;
    return await db.delete('transit_passes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertApplicationLocation(
      Map<String, dynamic> locationData) async {
    Database db = await database;
    try {
      // Create a copy of the data to avoid modifying the original
      var data = Map<String, dynamic>.from(locationData);

      // Check if app_id is used instead of app_form_id
      if (data.containsKey('app_id') && !data.containsKey('app_form_id')) {
        print("Mapping 'app_id' to 'app_form_id' for compatibility");
        data['app_form_id'] = data['app_id'];
        data.remove('app_id');
      }

      // Add timestamp if not provided
      if (!data.containsKey('created_at')) {
        data['created_at'] = DateTime.now().toIso8601String();
      }

      // Verify all required columns exist
      var tableInfo =
          await db.rawQuery("PRAGMA table_info(application_locations)");
      var existingColumns =
          tableInfo.map((col) => col['name'].toString()).toSet();
      var invalidColumns =
          data.keys.where((key) => !existingColumns.contains(key)).toList();

      if (invalidColumns.isNotEmpty) {
        print("Warning: Removing invalid columns: $invalidColumns");
        for (var key in invalidColumns) {
          data.remove(key);
        }
      }

      return await db.insert('application_locations', data);
    } catch (e) {
      print("Error inserting application location: $e");
      print("Data tried to insert: ${locationData.keys}");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getApplicationLocations(
      int appFormId) async {
    Database db = await database;
    try {
      print("Fetching application locations for app_form_id: $appFormId");
      final result = await db.query(
        'application_locations',
        where: 'app_form_id = ?',
        whereArgs: [appFormId],
      );
      print(
          "Found ${result.length} location records for app_form_id: $appFormId");
      return result;
    } catch (e) {
      print("Error fetching application locations: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getApplicationLocation(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'application_locations',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateApplicationLocation(
      Map<String, dynamic> locationData) async {
    Database db = await database;
    return await db.update(
      'application_locations',
      locationData,
      where: 'id = ?',
      whereArgs: [locationData['id']],
    );
  }

  Future<int> deleteApplicationLocation(int id) async {
    Database db = await database;
    try {
      print("Deleting application location with id: $id");
      final result = await db
          .delete('application_locations', where: 'id = ?', whereArgs: [id]);
      print("Delete result: $result rows affected");
      return result;
    } catch (e) {
      print("Error deleting application location: $e");
      return 0;
    }
  }

  Future<bool> applicationExistsByNo(String applicationNo) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'applications',
      where: 'application_no = ?',
      whereArgs: [applicationNo],
    );
    return result.isNotEmpty;
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

      // Handle transit passes if they exist in the data
      if (data['data']['transit_passes'] != null) {
        for (var transitPass in data['data']['transit_passes']) {
          await txn.insert('transit_passes', transitPass,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }

      // Handle application locations if they exist in the data
      if (data['data']['application_locations'] != null) {
        for (var location in data['data']['application_locations']) {
          await txn.insert('application_locations', location,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
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
    final transitPasses = await getTransitPasses(applicationId);
    final species = await getAllSpecies();
    final locationData = await getApplicationLocations(applicationId);

    return {
      'status': 'Success',
      'message': 'Data Fetched Successfully.',
      'data': {
        'applications': [application],
        'image_documents': imageDocuments,
        'timber_log': timberLogs,
        'additional_documents': additionalDocuments,
        'transit_passes': transitPasses,
        'trees_species_list': species.map((s) => {'name': s['name']}).toList(),
        'application_locations': locationData,
      }
    };
  }

  // CRUD for noc_applications
  Future<int> insertNocApplication(Map<String, dynamic> data) async {
    final db = await database;
    // Convert boolean values to integers
    var sanitizedData = Map<String, dynamic>.from(data);
    sanitizedData.forEach((key, value) {
      if (value is bool) {
        sanitizedData[key] = value ? 1 : 0;
      }
    });
    return await db.insert(
      'noc_applications',
      sanitizedData,
      conflictAlgorithm: ConflictAlgorithm.replace, // <-- Add this line
    );
  }

  Future<List<Map<String, dynamic>>> getNocApplications() async {
    final db = await database;
    return await db.query('noc_applications');
  }

  Future<Map<String, dynamic>?> getNocApplication(int id) async {
    final db = await database;
    final result =
        await db.query('noc_applications', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateNocApplication(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('noc_applications', data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> deleteNocApplication(int id) async {
    final db = await database;
    return await db
        .delete('noc_applications', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for division_comments_and_files
  Future<int> insertDivisionComment(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('division_comments_and_files', data);
  }

  Future<List<Map<String, dynamic>>> getDivisionComments(
      int nocApplicationId) async {
    final db = await database;
    return await db.query('division_comments_and_files',
        where: 'noc_application_id = ?', whereArgs: [nocApplicationId]);
  }

  Future<int> updateDivisionComment(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('division_comments_and_files', data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> deleteDivisionComment(int id) async {
    final db = await database;
    return await db.delete('division_comments_and_files',
        where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for clerk_comments_and_files
  Future<int> insertClerkComment(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('clerk_comments_and_files', data);
  }

  Future<List<Map<String, dynamic>>> getClerkComments(
      int nocApplicationId) async {
    final db = await database;
    return await db.query('clerk_comments_and_files',
        where: 'noc_application_id = ?', whereArgs: [nocApplicationId]);
  }

  Future<int> updateClerkComment(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('clerk_comments_and_files', data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> deleteClerkComment(int id) async {
    final db = await database;
    return await db
        .delete('clerk_comments_and_files', where: 'id = ?', whereArgs: [id]);
  }

  // Delete all NOC applications
  Future<int> deleteAllNocApplications() async {
    final db = await database;
    return await db.delete('noc_applications');
  }

  // CRUD for deputy_rfos
  Future<int> insertDeputyRfo(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('deputy_rfos', data);
  }

  Future<List<Map<String, dynamic>>> getDeputyRfos(int nocApplicationId) async {
    final db = await database;
    return await db.query('deputy_rfos',
        where: 'noc_application_id = ?', whereArgs: [nocApplicationId]);
  }

  Future<int> updateDeputyRfo(Map<String, dynamic> data) async {
    final db = await database;
    return await db
        .update('deputy_rfos', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> deleteDeputyRfo(int id) async {
    final db = await database;
    return await db.delete('deputy_rfos', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for image_documents_noc
  Future<int> insertImageDocumentNoc(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('image_documents_noc', data);
  }

  Future<List<Map<String, dynamic>>> getImageDocumentsNoc(
      int nocApplicationId) async {
    final db = await database;
    return await db.query('image_documents_noc',
        where: 'noc_application_id = ?', whereArgs: [nocApplicationId]);
  }

  Future<int> updateImageDocumentNoc(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('image_documents_noc', data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> deleteImageDocumentNoc(int id) async {
    final db = await database;
    return await db
        .delete('image_documents_noc', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for additional_documents_noc
  Future<int> insertAdditionalDocumentNoc(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('additional_documents_noc', data);
  }

  Future<List<Map<String, dynamic>>> getAdditionalDocumentsNoc(
      int nocApplicationId) async {
    final db = await database;
    return await db.query('additional_documents_noc',
        where: 'noc_application_id = ?', whereArgs: [nocApplicationId]);
  }

  Future<int> updateAdditionalDocumentNoc(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('additional_documents_noc', data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int> deleteAdditionalDocumentNoc(int id) async {
    final db = await database;
    return await db
        .delete('additional_documents_noc', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD for application_location_images
  Future<int> insertApplicationLocationImages(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('application_location_images', data);
  }

  Future<List<Map<String, dynamic>>> getApplicationLocationImages(
      int appId) async {
    final db = await database;
    return await db.query(
      'application_location_images',
      where: 'app_id = ?',
      whereArgs: [appId],
    );
  }

  Future<List<Map<String, dynamic>>> getAllApplicationLocationImages() async {
    final db = await database;
    return await db.query('application_location_images');
  }

  Future<List<Map<String, dynamic>>> listAllApplicationLocationImages() async {
    final db = await database;
    return await db.query('application_location_images');
  }
}
