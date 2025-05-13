import 'package:tigramnks/sqflite/dataBase.dart';

class formOneFields {
  int id;
  String name;
  String address;
  String survayno;
  //  String treeProposed;
  //  String village;
  //  String district;
  //  String block;
  //  String taluka;
  //  String division;
  //  String arearange;
  //  String pincode;
  //  String Purpose;
  //  String driver_name;
  //  String vehicel_reg;
  //  String phone;
  //  String mode;
  //  String destination_address;
  //  String destination_state;
  //  String licence_img;
  //  String ownership_proof_img;
  //  String revenue_application_img;
  //  String revenue_approval_img;
  //  String declaration_img;
  //  String location_sketch_img;
  //  String tree_ownership_img;
  //  String aadhar_card_img;
  //  String signature_img;
  //  String location_img1;
  //  String location_img2;
  //  String location_img3;
  //  String location_img4;
  //  String image1_lat;
  //  String image2_lat;
  //  String image3_lat;
  //  String image4_lat;
  //  String image1_log;
  //  String image2_log;
  //  String image3_log;
  //  String image4_log;
  //  String trees_cutted;

  formOneFields({
    required this.id,
    required this.name,
    required this.address,
    required this.survayno,
    //  this. treeProposed,
    //  this. village,
    //  this. district,
    //  this. block,
    //  this. taluka,
    //  this. division,
    //  this. arearange,
    //  this. pincode,
    //  this. Purpose,
    //  this. driver_name,
    //  this. vehicel_reg,
    //  this. phone,
    //  this. mode,
    //  this. destination_address,
    //  this. destination_state,
    //  this. licence_img,
    //  this. ownership_proof_img,
    //  this. revenue_application_img,
    //  this. revenue_approval_img,
    //  this. declaration_img,
    //  this. location_sketch_img,
    //  this. tree_ownership_img,
    //  this. aadhar_card_img,
    //  this. signature_img,
    //  this. location_img1,
    //  this. location_img2,
    //  this. location_img3,
    //  this. location_img4,
    //  this. image1_lat,
    //  this. image2_lat,
    //  this. image3_lat,
    //  this. image4_lat,
    //  this. image1_log,
    //  this. image2_log,
    //  this. image3_log,
    //  this. image4_log,
    //  this. trees_cutted,
  });

//  formOneFields.fromMap(Map<String, dynamic> res)

//         : id = res["id"],
//         name = res["name"],
//         address = res["address"],
//         survayno = res["survayno"];
  // treeProposed : map["treeProposed"],
  // village : map["village"],
  // district : map["district"],
  // block : map["block"],
  // taluka: map["taluka"],
  // division : map["division"],
  // arearange : map["arearange"],
  // pincode: map["pincode"],
  // Purpose : map["Purpose"],
  // driver_name : map["driver_name"],
  // vehicel_reg : map["vechcle_reg"],
  // phone : map["phone"],
  // mode : map["mode"],
  // destination_address: map["destination_address"],
  // destination_state : map["destination_state"],
  // licence_img : map["licence_img"],
  // ownership_proof_img : map["ownership_proof_img"],
  // revenue_application_img : map["revenue_application_img"],
  // revenue_approval_img : map["revenue_approval_img"],
  // declaration_img : map["declaration_img"],
  // location_sketch_img : map["location_sketch_img"],
  // tree_ownership_img : map["tree_ownership_img"],
  // aadhar_card_img : map["aadhar_card_img"],
  // signature_img: map["signature_img"],
  // location_img1 : map["location_img1"],
  // location_img2 : map["location_img2"],
  // location_img3 : map["location_img3"],
  // location_img4 : map["location_img4"],
  // image1_lat : map["image1_lat"],
  // image2_lat : map["image2_lat"],
  // image3_lat : map["image3_lat"],
  // image4_lat : map["image4_lat"],
  // image1_log: map["image1_log"],
  // image2_log : map["image2_log"],
  // image3_log: map["image3_log"],
  // image4_log : map["image4_log"],
  // trees_cutted : map["tress_cutted"],

  // Map<String, Object> toMap() {
  //   return{

  //   'id': id,
  //   'name' : name,
  //   'address' : address,
  //   'survayno' :survayno,
  // 'treeProposed' :treeProposed,
  // 'village' : village,
  // 'district' : district,
  // 'block' : block,
  // 'taluka': taluka,
  // 'division' : division,
  // 'arearange' : arearange,
  // 'pincode': pincode,
  // 'Purpose' : Purpose,
  // 'driver_name' : driver_name,
  // 'vehicel_reg' : vehicel_reg,
  // 'phone' : phone,
  // 'mode' : mode,
  // 'destination_address': destination_address,
  // 'destination_state' : destination_state,
  // 'licence_img' : licence_img,
  // 'ownership_proof_img' : ownership_proof_img,
  // 'revenue_application_img' : revenue_application_img,
  // 'revenue_approval_img' : revenue_approval_img,
  // 'declaration_img' : declaration_img,
  // 'location_sketch_img' : location_sketch_img,
  // 'tree_ownership_img' : tree_ownership_img,
  // 'aadhar_card_img' : aadhar_card_img ,
  // 'signature_img': signature_img,
  // 'location_img1' : location_img1,
  // 'location_img2' : location_img2,
  // 'location_img3' : location_img3,
  // 'location_img4' : location_img4,
  // 'image1_lat' : image1_lat,
  // 'image2_lat' : image2_lat,
  // 'image3_lat' : image3_lat,
  // 'image4_lat' : image4_lat,
  // 'image1_log': image1_log,
  // 'image2_log' : image2_log,
  // 'image3_log': image3_log,
  // 'image4_log' : image4_log,
  // 'trees_cutted' : trees_cutted,
//     };

//  }
// }
//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = {
//       'id': id,
//       'name' : name,
//       'address' : address,
//       'survayno' :survayno,
//         'treeProposed' :treeProposed,
//         'village' : village,
//         'district' : district,
//         'block' : block,
//         'taluka': taluka,
//         'division' : division,
//         'arearange' : arearange,
//         'pincode': pincode,
//         'Purpose' : Purpose,
//         'driver_name' : driver_name,
//         'vehicel_reg' : vehicel_reg,
//         'phone' : phone,
//         'mode' : mode,
//         'destination_address': destination_address,
//         'destination_state' : destination_state,
//         'licence_img' : licence_img,
//         'ownership_proof_img' : ownership_proof_img,
//         'revenue_application_img' : revenue_application_img,
//         'revenue_approval_img' : revenue_approval_img,
//         'declaration_img' : declaration_img,
//         'location_sketch_img' : location_sketch_img,
//         'tree_ownership_img' : tree_ownership_img,
//         'aadhar_card_img' : aadhar_card_img ,
//         'signature_img': signature_img,
//         'location_img1' : location_img1,
//         'location_img2' : location_img2,
//         'location_img3' : location_img3,
//         'location_img4' : location_img4,
//         'image1_lat' : image1_lat,
//         'image2_lat' : image2_lat,
//         'image3_lat' : image3_lat,
//         'image4_lat' : image4_lat,
//         'image1_log': image1_log,
//         'image2_log' : image2_log,
//         'image3_log': image3_log,
//         'image4_log' : image4_log,
//         'trees_cutted' : trees_cutted,
//     };

//     if (id != null) {
//       map['id'] = id;
//     }
//     return map;
//   }

// }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      dataBaseSqf.COLUMN_id: id,
      dataBaseSqf.COLUMN_name: name,
      dataBaseSqf.COLUMN_address: address,
      dataBaseSqf.COLUMN_survayno: survayno
      // dataBaseSqf.COLUMN_treeProposed :treeProposed ,
      // dataBaseSqf.COLUMN_village :village,
      // dataBaseSqf.COLUMN_district :district ,
      // dataBaseSqf.COLUMN_block :block ,
      // dataBaseSqf.COLUMN_taluka :taluka,
      // dataBaseSqf.COLUMN_division :division ,
      // dataBaseSqf.COLUMN_arearange :arearange,
      // dataBaseSqf.COLUMN_pincode :pincode ,
      // dataBaseSqf.COLUMN_Purpose :Purpose ,
      // dataBaseSqf.COLUMN_driver_name :driver_name ,
      // dataBaseSqf.COLUMN_vehicel_reg :vehicel_reg ,
      // dataBaseSqf.COLUMN_phone :phone ,
      // dataBaseSqf.COLUMN_mode :mode,
      // dataBaseSqf.COLUMN_destination_address :destination_address ,
      // dataBaseSqf.COLUMN_destination_state :destination_state ,
      // dataBaseSqf.COLUMN_licence_img :licence_img ,
      // dataBaseSqf.COLUMN_ownership_proof_img :ownership_proof_img ,
      // dataBaseSqf.COLUMN_revenue_application_img :revenue_application_img ,
      // dataBaseSqf.COLUMN_revenue_approval_img :revenue_approval_img,
      // dataBaseSqf.COLUMN_declaration_img :declaration_img ,
      // dataBaseSqf.COLUMN_location_sketch_img :location_sketch_img,
      // dataBaseSqf.COLUMN_tree_ownership_img :tree_ownership_img,
      // dataBaseSqf.COLUMN_aadhar_card_img :aadhar_card_img ,
      // dataBaseSqf.COLUMN_signature_img :signature_img  ,
      // dataBaseSqf.COLUMN_location_img1 :location_img1  ,
      // dataBaseSqf.COLUMN_location_img2 :location_img2  ,
      // dataBaseSqf.COLUMN_location_img3 :location_img3 ,
      // dataBaseSqf.COLUMN_location_img4 :location_img4  ,
      // dataBaseSqf.COLUMN_image1_lat :image1_lat ,
      // dataBaseSqf.COLUMN_image2_lat :image2_lat ,
      // dataBaseSqf.COLUMN_image3_lat :image3_lat ,
      // dataBaseSqf.COLUMN_image4_lat :image4_lat ,
      // dataBaseSqf.COLUMN_image1_log :image1_log ,
      // dataBaseSqf.COLUMN_image2_log :image2_log ,
      // dataBaseSqf.COLUMN_image3_log :image3_log ,
      // dataBaseSqf.COLUMN_image4_log :image4_log ,
      // dataBaseSqf.COLUMN_trees_cutted :trees_cutted
    };
    if (id != null) {
      map[dataBaseSqf.COLUMN_id] = id;
    }

    return map;
  }

  formOneFields.fromMap(Map<String, dynamic> map)
      : id = map[dataBaseSqf.COLUMN_id],
        name = map[dataBaseSqf.COLUMN_name],
        address = map[dataBaseSqf.COLUMN_address],
        survayno = map[dataBaseSqf.COLUMN_survayno] {
    // treeProposed = map[dataBaseSqf.COLUMN_treeProposed];
    // village = map[dataBaseSqf.COLUMN_village];
    // district = map[dataBaseSqf.COLUMN_district];
    // block = map[dataBaseSqf.COLUMN_block];
    // taluka = map[dataBaseSqf.COLUMN_taluka];
    // division = map[dataBaseSqf.COLUMN_division];
    // arearange = map[dataBaseSqf.COLUMN_arearange];
    // pincode = map[dataBaseSqf.COLUMN_pincode];
    // Purpose = map[dataBaseSqf.COLUMN_Purpose];
    // driver_name = map[dataBaseSqf.COLUMN_driver_name];
    // vehicel_reg = map[dataBaseSqf.COLUMN_vehicel_reg];
    // phone = map[dataBaseSqf.COLUMN_phone];
    // mode = map[dataBaseSqf.COLUMN_mode];
    // destination_address = map[dataBaseSqf.COLUMN_destination_address];
    // destination_state = map[dataBaseSqf.COLUMN_destination_state];
    // licence_img = map[dataBaseSqf.COLUMN_licence_img];
    // ownership_proof_img = map[dataBaseSqf.COLUMN_ownership_proof_img];
    // revenue_application_img = map[dataBaseSqf.COLUMN_revenue_application_img];
    // revenue_approval_img = map[dataBaseSqf.COLUMN_revenue_approval_img];
    // declaration_img = map[dataBaseSqf.COLUMN_declaration_img];
    // location_sketch_img = map[dataBaseSqf.COLUMN_location_sketch_img];
    // tree_ownership_img = map[dataBaseSqf.COLUMN_tree_ownership_img];
    // aadhar_card_img = map[dataBaseSqf.COLUMN_aadhar_card_img];
    // signature_img = map[dataBaseSqf.COLUMN_signature_img];
    // location_img1 = map[dataBaseSqf.COLUMN_location_img1];
    // location_img2 = map[dataBaseSqf.COLUMN_location_img2];
    // location_img3 = map[dataBaseSqf.COLUMN_location_img3];
    // location_img4 = map[dataBaseSqf.COLUMN_location_img4];
    // image1_lat = map[dataBaseSqf.COLUMN_image1_lat];
    // image2_lat = map[dataBaseSqf.COLUMN_image2_lat];
    // image3_lat = map[dataBaseSqf.COLUMN_image3_lat];
    // image4_lat = map[dataBaseSqf.COLUMN_image4_lat];
    // image1_log = map[dataBaseSqf.COLUMN_image1_log];
    // image2_log = map[dataBaseSqf.COLUMN_image2_log];
    // image3_log = map[dataBaseSqf.COLUMN_image3_log];
    // image4_log = map[dataBaseSqf.COLUMN_image4_log];
    // trees_cutted = map[dataBaseSqf.COLUMN_trees_cutted];
  }
}

// }

//    String tableFormone ='formOne';

// class formOneFields{
//     static final List<String> values = [
//     /// Add all fields
//     id, name, address, survayno, treeProposed, village
//   ];

//   static final String id                       ='_id';
//   static final String name                     ='_name';
//   static final String address                  ='_address';
//   static final String survayno                 ='_survayno';
//   static final String treeProposed             ='_treeProposed';
//   static final String village                  ='_village';
//   static final String district                 ='_district';
//   static final String block                    ='_block';
//   static final String taluka                   ='_taluka';
//   static final String division                 ='_division';
//   static final String arearange                ='_arearange';
//   static final String pincode                  ='_ pincode';
//   static final String Purpose                  ='_Purpose';
//   static final String driver_name              ='_driver_name';
//   static final String vehicel_reg              ='_vehicel_reg';
//   static final String phone                    ='_phone';
//   static final String mode                     ='_mode';
//   static final String destination_address      ='_destination_address';
//   static final String destination_state        ='_destination_state';
//   static final String licence_img              = '_licence_img';
//   static final String ownership_proof_img       ='_ownership_proof_img';
//   static final String revenue_application_img   ='_revenue_application_img';
//   static final String revenue_approval_img      ='_revenue_approval_img';
//   static final String declaration_img           ='_declaration_img';
//   static final String location_sketch_img       ='_location_sketch_img';
//   static final String tree_ownership_img        ='_tree_ownership_img';
//   static final String aadhar_card_img           ='_aadhar_card_img';
//   static final String signature_img              ='_signature_img';
//   static final String location_img1             ='_location_img1';
//   static final String location_img2             ='_location_img2';
//   static final String location_img3             ='_location_img3';
//   static final String location_img4              ='_location_img4';
//   static final String image1_lat                ='_image1_lat';
//   static final String image2_lat                ='_image2_lat';
//   static final String image3_lat                 ='_image3_lat';
//   static final String image4_lat                 ='_image4_lat';
//   static final String image1_log                 ='_image1_log';
//   static final String image2_log                 ='_image2_log';
//   static final String image3_log                 ='_image3_log';
//   static final String image4_log                 ='_image4_log';
//   static final String trees_cutted               ='_trees_cutted';
// }

// class formOneModel{

//   final int id;
//   final String name;
//   final String address;
//   final String survayno;
//   final String treeProposed;
//   final String village;
//   final String district;
//   final String block;
//   final String taluka;
//   final String division;
//   final String arearange;
//   final String pincode;
//   final String Purpose;
//   final String driver_name;
//   final String vehicel_reg;
//   final String phone;
//   final String mode;
//   final String destination_address;
//   final String destination_state;
//   final String licence_img;
//   final String ownership_proof_img;
//   final String revenue_application_img;
//   final String revenue_approval_img;
//   final String declaration_img;
//   final String location_sketch_img;
//   final String tree_ownership_img;
//   final String aadhar_card_img;
//   final String signature_img;
//   final String location_img1;
//   final String location_img2;
//   final String location_img3;
//   final String location_img4;
//   final String image1_lat;
//   final String image2_lat;
//   final String image3_lat;
//   final String image4_lat;
//   final String image1_log;
//   final String image2_log;
//   final String image3_log;
//   final String image4_log;
//   final String trees_cutted;

//   const formOneModel({
//     this.id,
//     this.name,
//     this. address,
//     this. survayno,
//     this. treeProposed,
//     this. village,
//     this. district,
//     this. block,
//     this. taluka,
//     this. division,
//     this. arearange,
//     this. pincode,
//     this. Purpose,
//     this. driver_name,
//     this. vehicel_reg,
//     this. phone,
//     this. mode,
//     this. destination_address,
//     this. destination_state,
//     this. licence_img,
//     this. ownership_proof_img,
//     this. revenue_application_img,
//     this. revenue_approval_img,
//     this. declaration_img,
//     this. location_sketch_img,
//     this. tree_ownership_img,
//     this. aadhar_card_img,
//     this. signature_img,
//     this. location_img1,
//     this. location_img2,
//     this. location_img3,
//     this. location_img4,
//     this. image1_lat,
//     this. image2_lat,
//     this. image3_lat,
//     this. image4_lat,
//     this. image1_log,
//     this. image2_log,
//     this. image3_log,
//     this. image4_log,
//     this. trees_cutted,
//   });

//    formOneModel copy({
//     int id,
//     String name,
//     String address,
//     String survayno,
//     String treeProposed,
//     String village,
//     String district,
//     String block,
//     String taluka,
//     String division,
//     String arearange,
//     String pincode,
//     String Purpose,
//     String driver_name,
//     String vehicel_reg,
//     String phone,
//     String mode,
//     String destination_address,
//     String destination_state,
//     String licence_img,
//     String ownership_proof_img,
//     String revenue_application_img,
//     String revenue_approval_img,
//     String declaration_img,
//     String location_sketch_img,
//     String tree_ownership_img,
//     String aadhar_card_img,
//     String signature_img,
//     String location_img1,
//     String location_img2,
//     String location_img3,
//     String location_img4,
//     String image1_lat,
//     String image2_lat,
//     String image3_lat,
//     String image4_lat,
//     String image1_log,
//     String image2_log,
//     String image3_log,
//     String image4_log,
//     String trees_cutted

//   }) =>
//       formOneModel(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         address: address ?? this.address,
//         survayno: survayno ?? this.survayno,
//         treeProposed: treeProposed ?? this.treeProposed,
//         village: village ?? this.village,
//         district: district ?? this.district,
//         block: block ?? this.block,
//         taluka: taluka ?? this.taluka,
//         division: division ?? this.division,
//         arearange: arearange ?? this.arearange,
//         pincode: pincode ?? this.pincode,
//         Purpose: Purpose ?? this.Purpose,
//         driver_name: driver_name ?? this.driver_name,
//         vehicel_reg: vehicel_reg ?? this.vehicel_reg,
//         phone: phone ?? this.phone,
//         mode: mode ?? this.mode,
//         destination_address: destination_address ?? this.destination_address,
//         destination_state: destination_state ?? this.destination_state,
//         licence_img: licence_img ?? this.licence_img,
//         ownership_proof_img: ownership_proof_img ?? this.ownership_proof_img,
//         revenue_application_img: revenue_application_img ?? this.revenue_application_img,
//         revenue_approval_img: revenue_approval_img ?? this.revenue_approval_img,
//         declaration_img: declaration_img ?? this.declaration_img,
//         location_sketch_img: location_sketch_img ?? this.location_sketch_img,
//         tree_ownership_img: tree_ownership_img ?? this.tree_ownership_img,
//         aadhar_card_img: aadhar_card_img ?? this.aadhar_card_img,
//         signature_img: signature_img ?? this.signature_img,
//         location_img1: location_img1 ?? this.location_img1,
//         location_img2: location_img2 ?? this.location_img2,
//         location_img3: location_img3 ?? this.location_img3,
//         location_img4: location_img4 ?? this.location_img4,
//         image1_lat: image1_lat ?? this.image1_lat,
//         image2_lat: image2_lat ?? this.image2_lat,
//         image3_lat: image3_lat ?? this.image3_lat,
//         image4_lat: image4_lat ?? this.image4_lat,
//         image1_log: image1_log ?? this.image1_log,
//         image2_log: image2_log ?? this.image2_log,
//         image3_log: image3_log ?? this.image3_log,
//         image4_log: image4_log ?? this.image4_log,
//         trees_cutted: trees_cutted ?? this.trees_cutted,

//       );

//   static formOneModel fromJson(Map<String, Object> json) => formOneModel(
//         id: json[formOneFields.id] as int,
//         name: json[formOneFields.name]as String,
//         address: json[formOneFields.address]as String,
//         survayno: json[formOneFields.survayno] as String,
//         treeProposed: json[formOneFields.treeProposed] as String,
//         village: json[formOneFields.village] as String,
//         district: json[formOneFields.district] as String,
//         block: json[formOneFields.block] as String,
//         taluka: json[formOneFields.taluka] as String,
//         division: json[formOneFields.division] as String,
//         arearange: json[formOneFields.arearange] as String,
//         pincode: json[formOneFields.pincode] as String,
//         Purpose: json[formOneFields.Purpose] as String,
//         driver_name: json[formOneFields.driver_name] as String,
//         vehicel_reg: json[formOneFields.vehicel_reg] as String,
//         phone: json[formOneFields.phone] as String,
//         mode: json[formOneFields.mode] as String,
//         destination_address: json[formOneFields.destination_address] as String,
//         destination_state: json[formOneFields.destination_state] as String,
//         licence_img: json[formOneFields.licence_img] as String,
//         ownership_proof_img: json[formOneFields.ownership_proof_img] as String,
//         revenue_application_img: json[formOneFields.revenue_application_img] as String,
//         revenue_approval_img: json[formOneFields.revenue_approval_img] as String,
//         declaration_img: json[formOneFields.declaration_img] as String,
//         location_sketch_img: json[formOneFields.location_sketch_img] as String,
//         tree_ownership_img: json[formOneFields.tree_ownership_img] as String,
//         aadhar_card_img: json[formOneFields.aadhar_card_img] as String,
//         signature_img: json[formOneFields.signature_img] as String,
//         location_img1: json[formOneFields.location_img1] as String,
//         location_img2: json[formOneFields.location_img2] as String,
//         location_img3: json[formOneFields.location_img3] as String,
//         location_img4: json[formOneFields.location_img4] as String,
//         image1_lat: json[formOneFields.image1_lat] as String,
//         image2_lat: json[formOneFields.image2_lat] as String,
//         image3_lat: json[formOneFields.image3_lat] as String,
//         image4_lat: json[formOneFields.image4_lat] as String,
//         image1_log: json[formOneFields.image1_log] as String,
//         image2_log: json[formOneFields.image2_log] as String,
//         image3_log: json[formOneFields.image3_log] as String,
//         image4_log: json[formOneFields.image4_log] as String,
//         trees_cutted: json[formOneFields.trees_cutted] as String,
//       );

//   Map<String, Object> toJson() => {
//         formOneFields.id: id,
//         formOneFields.survayno: survayno,
//         formOneFields.name: name ,
//         formOneFields.address: address,
//         formOneFields.treeProposed: treeProposed,
//         formOneFields.village: village,
//         formOneFields.district: district,
//         formOneFields.block: block,
//         formOneFields.taluka: taluka,
//         formOneFields.division: division,
//         formOneFields.arearange: arearange,
//         formOneFields.pincode: pincode,
//         formOneFields.Purpose: Purpose,
//         formOneFields.driver_name: driver_name,
//         formOneFields.vehicel_reg: vehicel_reg,
//         formOneFields.phone: phone,
//         formOneFields.mode: mode,
//         formOneFields.destination_address: destination_address,
//         formOneFields.destination_state: destination_state,
//         formOneFields.licence_img: licence_img,
//         formOneFields.ownership_proof_img: ownership_proof_img,
//         formOneFields.revenue_application_img: revenue_application_img,
//         formOneFields.revenue_approval_img: revenue_approval_img,
//         formOneFields.declaration_img: declaration_img,
//         formOneFields.location_sketch_img: location_sketch_img,
//         formOneFields.tree_ownership_img: tree_ownership_img,
//         formOneFields.aadhar_card_img: aadhar_card_img,
//         formOneFields.signature_img: signature_img,
//         formOneFields.location_img1: location_img1,
//         formOneFields.location_img2: location_img2,
//         formOneFields.location_img3: location_img3,
//         formOneFields.location_img4: location_img4,
//         formOneFields.image1_lat: image1_lat,
//         formOneFields.image2_lat: image2_lat,
//         formOneFields.image3_lat: image3_lat,
//         formOneFields.image4_lat: image4_lat,
//         formOneFields.image1_log: image1_log,
//         formOneFields.image2_log: image2_log,
//         formOneFields.image3_log: image3_log,
//         formOneFields.image4_log: image4_log,
//         formOneFields.trees_cutted: trees_cutted,

//       };

// }
