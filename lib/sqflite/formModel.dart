import 'DatabaseHelper.dart';

class Car {
  int id;
  String formtype;
  String name;
  String selDivision;
  String selRange;
  String selDistrict;
  String selTaluk;
  String selVillage;
  String survay;
  String address;
  String treePCut;
  String blockL;
  String pin;
  String locImageA;
  String locImageB;
  String locImageC;
  String locImageD;
  String image1lat;
  String image2lat;
  String image3lat;
  String image4lat;
  String image1log;
  String image2log;
  String image3log;
  String image4log;
  String treespecies;
  String purposecut;
  String drivernameLoc;
  String vehicelreg;
  String phone;
  String mode;
  String destinationaddress;
  String destinationstate;
  String licenceImg;
  String ownershipproofimg;
  String revenueapplicationimg;
  String revenueapprovalimg;
  String declarationimg;
  String locationsketchimg;
  String treeownershipimg;
  String aadharcardimg;
  String signatureimg;
  String selectProof;
  String logData;

  Car(
      this.id,
      this.formtype,
      this.name,
      this.selDivision,
      this.selRange,
      this.selDistrict,
      this.selTaluk,
      this.selVillage,
      this.survay,
      this.address,
      this.treePCut,
      this.blockL,
      this.pin,
      this.locImageA,
      this.locImageB,
      this.locImageC,
      this.locImageD,
      this.image1lat,
      this.image2lat,
      this.image3lat,
      this.image4lat,
      this.image1log,
      this.image2log,
      this.image3log,
      this.image4log,
      this.treespecies,
      this.purposecut,
      this.drivernameLoc,
      this.vehicelreg,
      this.phone,
      this.mode,
      this.destinationaddress,
      this.destinationstate,
      this.licenceImg,
      this.ownershipproofimg,
      this.revenueapplicationimg,
      this.revenueapprovalimg,
      this.declarationimg,
      this.locationsketchimg,
      this.treeownershipimg,
      this.aadharcardimg,
      this.signatureimg,
      this.selectProof,
      this.logData);

  Car.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    formtype = map['formtype'];
    name = map['name'];

    selDivision = map['selDivision'];
    selRange = map['selRange'];
    selDistrict = map['selDistict'];
    selTaluk = map['selTaluke'];
    selVillage = map['selVillage'];
    survay = map['survay'];
    address = map['address'];
    treePCut = map['treePCut'];
    blockL = map['block'];
    pin = map['pin'];
    locImageA = map['imageA'];
    locImageB = map['imageB'];
    locImageC = map['imageC'];
    locImageD = map['imageD'];
    image1lat = map['image1_lat'];
    image2lat = map['image2_lat'];
    image3lat = map['image3_lat'];
    image4lat = map['image4_lat'];
    image1log = map['image1_long'];
    image2log = map['image2_long'];
    image3log = map['image3_long'];
    image4log = map['image4_long'];
    treespecies = map['tree_species'];
    purposecut = map['purpose_cut'];
    drivernameLoc = map['driver_nameLoc'];
    vehicelreg = map['vehicel_reg'];
    phone = map['phone'];
    mode = map['mode'];
    destinationaddress = map['destination_address'];
    destinationstate = map['destination_state'];
    licenceImg = map["licenceImg"];
    ownershipproofimg = map["ownership_proof_img"];
    revenueapplicationimg = map["revenue_application_img"];
    revenueapprovalimg = map["revenue_approval_img"];
    declarationimg = map["declaration_img"];
    locationsketchimg = map["location_sketch_img"];
    treeownershipimg = map["tree_ownership_img"];
    aadharcardimg = map["aadhar_card_img"];
    signatureimg = map["signature_img"];
    selectProof = map["selectProof"];
    logData = map["logData"];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnFormtype: formtype,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnDivision: selDivision,
      DatabaseHelper.columnRange: selRange,
      DatabaseHelper.columnDistrict: selDistrict,
      DatabaseHelper.columnTaluke: selTaluk,
      DatabaseHelper.columnVillage: selVillage,
      DatabaseHelper.columnsurvay: survay,
      DatabaseHelper.columnaddress: address,
      DatabaseHelper.columntreePCut: treePCut,
      DatabaseHelper.columnblockL: blockL,
      DatabaseHelper.columnpin: pin,
      DatabaseHelper.columnlocImageA: locImageA,
      DatabaseHelper.columnlocImageB: locImageB,
      DatabaseHelper.columnlocImageC: locImageC,
      DatabaseHelper.columnlocImageD: locImageD,
      DatabaseHelper.columnimage1_lat: image1lat,
      DatabaseHelper.columnimage2_lat: image2lat,
      DatabaseHelper.columnimage3_lat: image3lat,
      DatabaseHelper.columnimage4_lat: image4lat,
      DatabaseHelper.columnimage1_long: image1log,
      DatabaseHelper.columnimage2_long: image2log,
      DatabaseHelper.columnimage3_long: image3log,
      DatabaseHelper.columnimage4_long: image4log,
      DatabaseHelper.columntree_species: treespecies,
      DatabaseHelper.columnpurpose_cut: purposecut,
      DatabaseHelper.columndriver_nameLoc: drivernameLoc,
      DatabaseHelper.columnvehicel_reg: vehicelreg,
      DatabaseHelper.columnphone: phone,
      DatabaseHelper.columnmode: mode,
      DatabaseHelper.columndestination_address: destinationaddress,
      DatabaseHelper.columndestination_state: destinationstate,
      DatabaseHelper.columnlicenceImg: licenceImg,
      DatabaseHelper.columnownership_proof_img: ownershipproofimg,
      DatabaseHelper.columnrevenue_application_img: revenueapplicationimg,
      DatabaseHelper.columnrevenue_approval_img: revenueapprovalimg,
      DatabaseHelper.columndeclaration_img: declarationimg,
      DatabaseHelper.columnlocation_sketch_img: locationsketchimg,
      DatabaseHelper.columntree_ownership_img: treeownershipimg,
      DatabaseHelper.columnaadhar_card_img: aadharcardimg,
      DatabaseHelper.columnsignature_img: signatureimg,
      DatabaseHelper.columnselectProof: selectProof,
      DatabaseHelper.columnlogData: logData,
    };
  }
}
