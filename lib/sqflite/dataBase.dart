import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tigramnks/Form1.dart';

import '../model/formOneModel.dart';


// class dataBaseSqf {
//   static final dataBaseSqf _databaseHelper = dataBaseSqf._();

//   dataBaseSqf._();

//   Database db;

//   Future<void> initDB() async {
//     String path = await getDatabasesPath();
//     db = await openDatabase(
//       join(path, 'formOne.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//           """
//             CREATE TABLE formOneTable (
//               id INTEGER PRIMARY KEY AUTOINCREMENT, 
//               name TEXT ,
//               address INTEGER , 
//               survayno TEXT 
             
//             )
//           """,
//               // treeProposed TEXT,
//               // village TEXT,
//               // district TEXT,
//               // block TEXT,
//               // taluka TEXT,
//               // division TEXT,
//               // pincode TEXT,
//               // Purpose TEXT,
//               // driver_name TEXT,
//               // vehicel_reg TEXT,
//               // phone TEXT,
//               // mode  TEXT,
//               // destination_address TEXT,
//               // destination_state TEXT,
//               // licence_img  TEXT,
//               // ownership_proof_img TEXT,
//               // revenue_application_img  TEXT,
//               // revenue_approval_img TEXT,
//               // declaration_img  TEXT,
//               // location_sketch_img TEXT,
//               // tree_ownership_img TEXT,
//               // aadhar_card_img TEXT,
//               // signature_img TEXT,
//               // location_img1 TEXT,
//               // location_img2 TEXT,
//               // location_img3 TEXT,
//               // location_img4 TEXT,
//               // image1_lat TEXT,
//               // image2_lat TEXT,
//               // image3_lat TEXT,
//               // image1_log TEXT,
//               // image2_log TEXT,
//               // image3_log TEXT,
//               // image4_log TEXT,
//               // trees_cutted TEXT
//         );
//       },
//       version: 1,
//     );
//   }

//   factory dataBaseSqf() {
//     return _databaseHelper;
//   }
//   Future<int> insertForm1(formOneFields formone) async {
//     int result = await db.insert('formOneTable', formone.toMap());
//     return result;
//   }
//    Future<int> updateForm1(formOneFields formone) async {
//     int result = await db.update(
//       'formOneTable',
//       formone.toMap(),
//       where: "id = ?",
//       whereArgs: [formone.id],
//     );
//     return result;
//   }
//    Future<List<formOneFields>> retrieveForm1() async {
//     final List<Map<String, Object>> queryResult = await db.query('formOneTable');
//     return queryResult.map((e) => formOneFields.fromMap(e)).toList();
//   }

//   Future<void> deleteForm1(int id) async {
//     await db.delete(
//       'formOneTable',
//       where: "id = ?",
//       whereArgs: [id],
//     );
//   }

// }


// }

// class dataBaseSqf{

// static final dataBaseSqf instance =dataBaseSqf._init();
// static Database _database;

// dataBaseSqf._init();

// Future<Database> get database async{
//   if(_database != null )return _database;
//    _database= await _initDB('forms.db');
//    return _database;
// }
// Future<Database>_initDB(String filePath)async{
//   final dbPath =await getDatabasesPath();
//   final path = join(dbPath,filePath);
//   return await openDatabase(path, version: 1,onCreate: _createDB);
// }
// Future _createDB(Database db, int version)async{
//   const idType = ' INTEGER PRIMARY KEY ';
//   const textType =' TEXT ';
  
//   await db.execute('''
// CREATE TABLE $tableFormone(
//     ${formOneFields.id} $idType,
//     ${formOneFields.name} $textType,
//     ${formOneFields.address} $textType,
//     ${formOneFields.survayno} $textType,
//     ${formOneFields.treeProposed} $textType,
//     ${formOneFields.village} $textType,
//     ${formOneFields.district} $textType,
//     ${formOneFields.block} $textType,
//     ${formOneFields.taluka} $textType,
//     ${formOneFields.division} $textType,
//     ${formOneFields.pincode} $textType,
//     ${formOneFields.Purpose} $textType,
//     ${formOneFields.driver_name} $textType,
//     ${formOneFields.vehicel_reg } $textType,
//     ${formOneFields.phone} $textType,
//     ${formOneFields.mode} $textType,
//     ${formOneFields.destination_address} $textType,
//     ${formOneFields.destination_state} $textType,
//     ${formOneFields.licence_img} $textType,
//     ${formOneFields.ownership_proof_img} $textType,
//     ${formOneFields.revenue_application_img} $textType,
//     ${formOneFields.revenue_approval_img} $textType,
//     ${formOneFields.declaration_img} $textType,
//     ${formOneFields.location_sketch_img} $textType,
//     ${formOneFields.tree_ownership_img} $textType,
//     ${formOneFields.aadhar_card_img} $textType,
//     ${formOneFields.signature_img} $textType,
//     ${formOneFields.location_img1} $textType,
//     ${formOneFields.location_img2} $textType,
//     ${formOneFields.location_img3} $textType,
//     ${formOneFields.location_img4} $textType,
//     ${formOneFields.image1_lat} $textType,
//     ${formOneFields.image2_lat} $textType,
//     ${formOneFields.image3_lat} $textType,
//     ${formOneFields.image1_log} $textType,
//     ${formOneFields.image2_log} $textType,
//     ${formOneFields.image3_log} $textType,
//     ${formOneFields.image4_log} $textType,
//     ${formOneFields.trees_cutted} $textType
//     )''');


//  }

 
//   Future<formOneModel> create(formOneModel note) async {
//     final db = await instance.database;

//     // final json = note.toJson();
//     // final columns =
//     //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//     // final values =
//     //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
//     // final id = await db
//     //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

//     final id = await db.insert(tableFormone, note.toJson());
//     return note.copy(id: id);
//   }
   
//   Future <formOneModel> readnote(int id) async{
//     final db = await instance.database;
//     final maps =await db.query(tableFormone,columns:formOneFields.values,
//     where: '${formOneFields.id} =   ?',whereArgs: [id], );
//     if(maps.isNotEmpty ){
//        return formOneModel.fromJson(maps.first);
//     }else{
//       throw Exception('ID $id not found0');
//     }
//   }

//   // Future <List<formOneModel>>readAllNotes()async{
//   //   final db = await instance.database;
//   //   final result = await db.query(tableFormone);
//   //   return result.map((json)=>formOneModel.fromJson(json)).toList();
//   // }
 

//   Future close()async{
//     final db =await instance.database;
//     db.close();
//   }


//     Future<List<formOneModel>> readAllNotes() async {
//     final db = await instance.database;

//     final orderBy = '${formOneFields.id} ASC';
//     // final result =
//     //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

//     final result = await db.query(tableFormone, orderBy: orderBy);

//     return result.map((json) => formOneModel.fromJson(json)).toList();
//   }
//   Future <int> update(formOneModel note) async{
//     final db =await instance.database;

//     return db.update(
//       tableFormone , 
//       note.toJson(),
//      where: '${formOneFields.id} = ?',whereArgs: [note.id],);
     
//   }
//   Future <int> delete(int id )async{
//     final db =await instance.database;
//     return await db.delete(tableFormone,
//     where: '${formOneFields.id} = ?',whereArgs: [id],);
//   }
// }
class dataBaseSqf {
  static const String TABLE_FORMONE = "formOne";
  static const String COLUMN_id = "id";
  static const String COLUMN_name = "name";
  static const String COLUMN_address = "address";
  static const String COLUMN_survayno = "survayno";
  // static const String COLUMN_treeProposed = "treeProposed";
  // static const String COLUMN_village= "village";
  // static const String COLUMN_district = "district";
  // static const String COLUMN_block= "block";
  // static const String COLUMN_taluka = "taluka";
  // static const String COLUMN_division = "division";
  // static const String COLUMN_arearange = "arearange";
  // static const String COLUMN_pincode = "pincode";
  // static const String COLUMN_Purpose = "Purpose";
  // static const String COLUMN_driver_name = "driver_name";
  // static const String COLUMN_vehicel_reg = "vehicel_reg";
  
  // static const String COLUMN_phone= "phone";
  // static const String COLUMN_mode= "mode";
  // static const String COLUMN_destination_address = "destination_address";
  // static const String COLUMN_destination_state = "destination_state";
  // static const String COLUMN_licence_img = "licence_img";
  // static const String COLUMN_ownership_proof_img = "ownership_proof_img";
  // static const String COLUMN_revenue_application_img= "revenue_application_img";
  // static const String COLUMN_revenue_approval_img = "revenue_approval_img";
  // static const String COLUMN_declaration_img = "declaration_img";
  // static const String COLUMN_location_sketch_img = "location_sketch_img";
  // static const String COLUMN_tree_ownership_img= "tree_ownership_img";
  // static const String COLUMN_aadhar_card_img = "aadhar_card_img";
  // static const String COLUMN_signature_img = "signature_img";
  // static const String COLUMN_location_img1 = "location_img1";
  // static const String COLUMN_location_img2 = "location_img2";
  // static const String COLUMN_location_img3= "location_img3";
  // static const String COLUMN_location_img4 = "location_img4";
  // static const String COLUMN_image1_lat= "image1_lat";
  // static const String COLUMN_image2_lat = "image2_lat";
  // static const String COLUMN_image3_lat= "image3_lat";
  // static const String COLUMN_image4_lat = "image4_lat";
  // static const String COLUMN_image1_log= "image1_log";
  // static const String COLUMN_image2_log = "image2_log";
  // static const String COLUMN_image3_log= "image3_log";
  // static const String COLUMN_image4_log = "image4_log";
  // static const String COLUMN_trees_cutted = "trees_cutted";
  
////////////////////////////////

      // "$COLUMN_treeProposed  TEXT,"
    // "$COLUMN_village  TEXT,"
    // "$COLUMN_district  TEXT,"
    // "$COLUMN_block  TEXT,"
    // "$COLUMN_taluka  TEXT,"
    // "$COLUMN_division  TEXT,"
    // "$COLUMN_pincode  TEXT,"
    // "$COLUMN_Purpose  TEXT,"
    // "$COLUMN_driver_name  TEXT,"
    // "$COLUMN_vehicel_reg   TEXT,"
    // "$COLUMN_phone  TEXT,"
    // "$COLUMN_mode  TEXT,"
    // "$COLUMN_destination_address  TEXT,"
    // "$COLUMN_destination_state  TEXT,"
    // "$COLUMN_licence_img  TEXT,"
    // "$COLUMN_ownership_proof_img  TEXT,"
    // "$COLUMN_revenue_application_img  TEXT,"
    // "$COLUMN_revenue_approval_img  TEXT,"
    // "$COLUMN_declaration_img  TEXT,"
    // "$COLUMN_location_sketch_img  TEXT,"
    // "$COLUMN_tree_ownership_img  TEXT,"
    // "$COLUMN_aadhar_card_img  TEXT,"
    // "$COLUMN_signature_img  TEXT,"
    // "$COLUMN_location_img1  TEXT,"
    // "$COLUMN_location_img2  TEXT,"
    // "$COLUMN_location_img3  TEXT,"
    // "$COLUMN_location_img4  TEXT,"
    // "$COLUMN_image1_lat  TEXT,"
    // "$COLUMN_image2_lat  TEXT,"
    // "$COLUMN_image3_lat  TEXT,"
    // "$COLUMN_image1_log  TEXT,"
    // "$COLUMN_image2_log  TEXT,"
    // "$COLUMN_image3_log  TEXT,"
    // "$COLUMN_image4_log  TEXT,"
    // "$COLUMN_trees_cutted TEXT"

  dataBaseSqf._();
  static final dataBaseSqf db = dataBaseSqf._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'foodDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating formonefields table");

          await database.execute('''
CREATE TABLE $TABLE_FORMONE(
    "$COLUMN_id INTEGER PRIMARY KEY,"
    "$COLUMN_name  TEXT,"
    "$COLUMN_address  TEXT,"
    "$COLUMN_survayno  TEXT"

    )''');
      },
    );
  }

  Future<List<formOneFields>> getFormOnes() async {
    final db = await database;

    var foods = await db
        .query(TABLE_FORMONE, columns: [
          COLUMN_id,
          COLUMN_name,
          COLUMN_address,
          COLUMN_survayno,
          // COLUMN_treeProposed,
          // COLUMN_village,
          // COLUMN_district,
          // COLUMN_block ,
          // COLUMN_taluka,
          // COLUMN_division,
          // COLUMN_pincode,
          // COLUMN_Purpose ,
          // COLUMN_driver_name,
          // COLUMN_vehicel_reg,
          // COLUMN_phone,
          // COLUMN_mode,
          // COLUMN_destination_address,
          // COLUMN_destination_state,
          // COLUMN_licence_img,
          // COLUMN_ownership_proof_img,
          // COLUMN_revenue_application_img,          
          // COLUMN_revenue_application_img, 
          // COLUMN_revenue_approval_img ,
          // COLUMN_declaration_img ,
          // COLUMN_location_sketch_img ,
          // COLUMN_tree_ownership_img,
          // COLUMN_aadhar_card_img ,
          // COLUMN_signature_img,
          // COLUMN_location_img1,
          // COLUMN_location_img2, 
          // COLUMN_location_img3 ,
          // COLUMN_location_img4,
          // COLUMN_image1_lat,
          // COLUMN_image2_lat,
          // COLUMN_image3_lat,
          // COLUMN_image1_log,
          // COLUMN_image3_log,
          // COLUMN_image4_log ,
          // COLUMN_trees_cutted 

          
          ]);

    List<formOneFields> foodList = <formOneFields>[];

    foods.forEach((currentFood) {
      formOneFields formonefields = formOneFields.fromMap(currentFood);

      foodList.add(formonefields);
    });

    return foodList;
  }

  Future<formOneFields> insert(formOneFields formonefields) async {
    final db = await database;
    formonefields.id = await db.insert(TABLE_FORMONE, formonefields.toMap());
    return formonefields;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_FORMONE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(formOneFields formonefields) async {
    final db = await database;

    return await db.update(
      TABLE_FORMONE,
      formonefields.toMap(),
      where: "id = ?",
      whereArgs: [formonefields.id],
    );
  }
}