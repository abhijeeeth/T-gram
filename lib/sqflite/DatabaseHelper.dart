import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tigramnks/sqflite/formModel.dart';

class DatabaseHelper {
  static final _databaseName = "form1.db";
  static final _databaseVersion = 1;

  static final table = 'cars_table';
  static final columnId = 'id';
  static final columnFormtype = 'formtype';
  static final columnName = 'name';
  static final columnDivision = 'selDivision';
  static final columnRange = 'selRange';
  static final columnDistrict = 'selDistict';
  static final columnTaluke = 'selTaluke';
  static final columnVillage = 'selVillage';
  static final columnsurvay = 'survay';
  static final columnaddress = 'address';
  static final columntreePCut = 'treePCut';
  static final columnblockL = 'block';
  static final columnpin = 'pin';
  static final columnlocImageA = 'imageA';
  static final columnlocImageB = 'imageB';
  static final columnlocImageC = 'imageC';
  static final columnlocImageD = 'imageD';
  static final columnimage1_lat = 'image1_lat';
  static final columnimage2_lat = 'image2_lat';
  static final columnimage3_lat = 'image3_lat';
  static final columnimage4_lat = 'image4_lat';
  static final columnimage1_long = 'image1_long';
  static final columnimage2_long = 'image2_long';
  static final columnimage3_long = 'image3_long';
  static final columnimage4_long = 'image4_long';
  static final columntree_species = 'tree_species';
  static final columnpurpose_cut = 'purpose_cut';
  static final columndriver_nameLoc = 'driver_nameLoc';
  static final columnvehicel_reg = 'vehicel_reg';
  static final columnphone = 'phone';
  static final columnmode = 'mode';
  static final columndestination_address = 'destination_address';
  static final columndestination_state = 'destination_state';
  static final columnlicenceImg = "licenceImg";
  static final columnownership_proof_img = "ownership_proof_img";
  static final columnrevenue_application_img = "revenue_application_img";
  static final columnrevenue_approval_img = "revenue_approval_img";
  static final columndeclaration_img = "declaration_img";
  static final columnlocation_sketch_img = "location_sketch_img";
  static final columntree_ownership_img = "tree_ownership_img";
  static final columnaadhar_card_img = "aadhar_card_img";
  static final columnsignature_img = "signature_img";
  static final columnselectProof = "selectProof";
  static final columnlogData = "logData";
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return Future.value(_database);
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnFormtype TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnDivision TEXT NOT NULL,
            $columnRange TEXT NOT NULL,
            $columnDistrict TEXT NOT NULL,
            $columnTaluke TEXT NOT NULL,
            $columnVillage TEXT NOT NULL,
            $columnsurvay TEXT NOT NULL,
            $columnaddress TEXT NOT NULL,
            $columntreePCut TEXT NOT NULL,
            $columnblockL TEXT NOT NULL,
            $columnpin TEXT NOT NULL,
            $columnlocImageA TEXT NOT NULL,
            $columnlocImageB TEXT NOT NULL,
            $columnlocImageC TEXT NOT NULL,
            $columnlocImageD TEXT NOT NULL,
            $columnimage1_lat TEXT NOT NULL,
            $columnimage2_lat TEXT NOT NULL,
            $columnimage3_lat TEXT NOT NULL,
            $columnimage4_lat TEXT NOT NULL,
            $columnimage1_long TEXT NOT NULL,
            $columnimage2_long TEXT NOT NULL,
            $columnimage3_long TEXT NOT NULL,
            $columnimage4_long TEXT NOT NULL,
            $columntree_species TEXT NOT NULL,
            $columnpurpose_cut TEXT NOT NULL,
            $columndriver_nameLoc TEXT NOT NULL,
     $columnvehicel_reg TEXT NOT NULL,
     $columnphone TEXT NOT NULL,
     $columnmode TEXT NOT NULL,
     $columndestination_address TEXT NOT NULL,
     $columndestination_state TEXT NOT NULL,
     $columnlicenceImg TEXT NOT NULL,
     $columnownership_proof_img TEXT NOT NULL,
     $columnrevenue_application_img TEXT NOT NULL,
     $columnrevenue_approval_img TEXT NOT NULL,
     $columndeclaration_img TEXT NOT NULL,
     $columnlocation_sketch_img TEXT NOT NULL,
     $columntree_ownership_img TEXT NOT NULL,
     $columnaadhar_card_img TEXT NOT NULL,
     $columnsignature_img TEXT NOT NULL,
     $columnselectProof TEXT NOT NULL,
     $columnlogData TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Car car) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'formtype': car.formtype,
      'name': car.name,
      'selDivision': car.selDivision,
      'selRange': car.selRange,
      'selDistict': car.selDistrict,
      'selTaluke': car.selTaluk,
      'selVillage': car.selVillage,
      'survay': car.survay,
      'address': car.address,
      "treePCut": car.treePCut,
      "block": car.blockL,
      "pin": car.pin,
      "imageA": car.locImageA,
      "imageB": car.locImageB,
      'imageC': car.locImageC,
      'imageD': car.locImageD,
      'image1_lat': car.image1lat,
      'image2_lat': car.image2lat,
      'image3_lat': car.image3lat,
      'image4_lat': car.image4lat,
      'image1_long': car.image1log,
      'image2_long': car.image2log,
      'image3_long': car.image3log,
      'image4_long': car.image4log,
      'tree_species': car.treespecies,
      'purpose_cut': car.purposecut,
      'driver_nameLoc': car.drivernameLoc,
      'vehicel_reg': car.vehicelreg,
      'phone': car.phone,
      'mode': car.mode,
      'destination_address': car.destinationaddress,
      'destination_state': car.destinationstate,
      "licenceImg": car.licenceImg,
      "ownership_proof_img": car.ownershipproofimg,
      "revenue_application_img": car.revenueapplicationimg,
      "revenue_approval_img": car.revenueapprovalimg,
      "declaration_img": car.declarationimg,
      "location_sketch_img": car.locationsketchimg,
      "tree_ownership_img": car.treeownershipimg,
      "aadhar_card_img": car.aadharcardimg,
      "signature_img": car.signatureimg,
      "selectProof": car.selectProof,
      "logData": car.logData,
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $table')) ??
        0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Car car) async {
    Database db = await instance.database;
    int id = car.toMap()['id'];
    return await db
        .update(table, car.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
