// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'package:tigramnks/homePage.dart';
import 'package:tigramnks/sqflite/DatabaseHelper.dart';
import 'package:tigramnks/sqflite/formModel.dart';

class Form2Page4 extends StatefulWidget {
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;
  String Ownership;
  String imageone;
  String imagetwo;
  String imagethree;
  String imagefour;
  String imagelatone;
  String imagelattwo;
  String imagelatthree;
  String imagelatfour;
  String imagelongone;
  String imagelongtwo;
  String imagelongthree;
  String imagelongfour;
  String Purpose;
  List holder_1;
  String Application;
  String Approval;
  String Declaration;
  String Location;
  String TreeOwnership;
  String IdProof;
  List log_details;
  String selectedPRoof;
  Form2Page4(
      {super.key,
      required this.sessionToken,
      required this.dropdownValue,
      required this.dropdownValue1,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.Name,
      required this.Address,
      required this.survey_no,
      required this.village,
      required this.Taluka,
      required this.block,
      required this.District,
      required this.Pincode,
      required this.Ownership,
      required this.imageone,
      required this.imagetwo,
      required this.imagethree,
      required this.imagefour,
      required this.imagelatone,
      required this.imagelattwo,
      required this.imagelatthree,
      required this.imagelatfour,
      required this.imagelongone,
      required this.imagelongtwo,
      required this.imagelongthree,
      required this.imagelongfour,
      required this.Purpose,
      required this.holder_1,
      required this.Application,
      required this.Approval,
      required this.Declaration,
      required this.Location,
      required this.TreeOwnership,
      required this.IdProof,
      required this.log_details,
      required this.selectedPRoof});
  @override
  _Form2Page4State createState() => _Form2Page4State(
      sessionToken,
      dropdownValue,
      dropdownValue1,
      userName,
      userEmail,
      userId,
      Name,
      Address,
      survey_no,
      village,
      Taluka,
      block,
      District,
      Pincode,
      Ownership,
      imageone,
      imagetwo,
      imagethree,
      imagefour,
      imagelatone,
      imagelattwo,
      imagelatthree,
      imagelatfour,
      imagelongone,
      imagelongtwo,
      imagelongthree,
      imagelongfour,
      Purpose,
      holder_1,
      Application,
      Approval,
      Declaration,
      Location,
      TreeOwnership,
      IdProof,
      log_details,
      selectedPRoof);
}

class _Form2Page4State extends State<Form2Page4> {
  final dbHelper = DatabaseHelper.instance;
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;
  String Ownership;
  String imageone;
  String imagetwo;
  String imagethree;
  String imagefour;
  String imagelatone;
  String imagelattwo;
  String imagelatthree;
  String imagelatfour;
  String imagelongone;
  String imagelongtwo;
  String imagelongthree;
  String imagelongfour;
  String Purpose;
  List holder_1;
  String Application;
  String Approval;
  String Declaration;
  String Location;
  String TreeOwnership;
  String IdProof;
  List log_details;
  String selectedPRoof;
  var _imageLisence;
  String base64ImageLisence = '';
  var _imageSignature;
  String base64ImageSignature = '';

  _Form2Page4State(
      this.sessionToken,
      this.dropdownValue,
      this.dropdownValue1,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name,
      this.Address,
      this.survey_no,
      this.village,
      this.Taluka,
      this.block,
      this.District,
      this.Pincode,
      this.Ownership,
      this.imageone,
      this.imagetwo,
      this.imagethree,
      this.imagefour,
      this.imagelatone,
      this.imagelattwo,
      this.imagelatthree,
      this.imagelatfour,
      this.imagelongone,
      this.imagelongtwo,
      this.imagelongthree,
      this.imagelongfour,
      this.Purpose,
      this.holder_1,
      this.Application,
      this.Approval,
      this.Declaration,
      this.Location,
      this.TreeOwnership,
      this.IdProof,
      this.log_details,
      this.selectedPRoof)
      : logDataF = [],
        log = '',
        maintenance = '',
        maintenance_cost = 0,
        estimatedMaintenanceCost = 0,
        isEnabled = false,
        selectedState = '';

  List logDataF;
  final picker = ImagePicker();
  String log;
  Future<void> setLisencepicgallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageLisence = File(pickedFile.path);

        base64ImageLisence = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setSignaturepicgallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile != null) {
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageSignature = File(pickedFile.path);

        base64ImageSignature = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showpickoptiondialogSignature(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setSignaturepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  int valk = 1;
  String keys = 'Id';

  void logupdate() {
    int index = 0;
    for (int i = 0; i < log_details.length; i++) {
      if (log_details[i]["species_of_tree"] ==
          "Rosewood (Dalbergia latifolia)") {
        dynamic value = 1;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Teak (Tectona grandis) ") {
        dynamic value = 2;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] ==
          "Thempavu (Terminalia tomantosa)") {
        dynamic value = 3;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] ==
          "Chadachi (Grewia tiliaefolia)") {
        dynamic value = 4;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] ==
          "Chandana vempu(Cedrela toona)") {
        dynamic value = 5;
        log_details[i][keys] = value;
      }

      if (log_details[i]["species_of_tree"] ==
          "Vellakil (Dysoxylum malabaricum)") {
        dynamic value = 6;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Irul (Xylia xylocarpa)") {
        dynamic value = 7;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Ebony (Diospyrus sp.)") {
        dynamic value = 8;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Kampakam(Hopea Parviflora)") {
        dynamic value = 9;
        log_details[i][keys] = value;
      }
    }
    logDataF = log_details;
  }

  void _showpickoptiondialogLisence(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setLisencepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  TextEditingController destination_add = TextEditingController();
  TextEditingController vehical_reg_no = TextEditingController();
  TextEditingController driver_name = TextEditingController();
  TextEditingController driver_phone = TextEditingController();
  TextEditingController mode_transport = TextEditingController();
  int _radioValue = 0;
  String maintenance;
  int maintenance_cost;
  int estimatedMaintenanceCost;
  bool isEnabled;
  bool flag = false;
  @override
  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      if (_radioValue == 1) {
        maintenance = 'YES';
        setState(() {
          flag = true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'NO';
        setState(() {
          flag = false;
        });
      }
    });
  }

  String selectedState;
  List<String> State = [
    "Andhra Pradesh",
    "Andaman and Nicobar Islands",
    "Arunachal Pradesh",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadar and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu & Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttar Pradesh",
    "West Bengal"
  ];

  bool isShow = false;
  Future<bool> _onBackPressed() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to go previous page'),
        content: Text('Changes you made may not be saved.'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  String? get _errorText {
    final text = driver_phone.value.text;

    if (text.length < 10) {
      return 'Please add valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("FORM - II"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10, bottom: 0),
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(children: const <TextSpan>[
                          TextSpan(
                              text: "Destination State",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              )),
                        ]),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 10, bottom: 0),
                      child: DropdownButton<String>(
                        value: selectedState,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Select State",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " * ",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 16,
                                )),
                          ]),
                        ),
                        onChanged: (String? data) {
                          setState(() {
                            selectedState = data!;
                          });

                          print(selectedState);
                        },
                        items:
                            State.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15.0, top: 15, bottom: 0),
                      child: TextField(
                        controller: destination_add,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14.0)),
                          ),
                          labelText: 'Destination',
                          hintText: 'Destination Details',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(
                              child: Text(
                                'Enter Vehicle Details',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text(
                                  'Yes',
                                  style: TextStyle(fontFamily: 'Lato'),
                                ),
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text(
                                  'No',
                                  style: TextStyle(fontFamily: 'Lato'),
                                ),
                                value: 2,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                          ]),
                          LayoutBuilder(builder: (context, constraints) {
                            if (flag == true) {
                              return Container(
                                  child: Column(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15.0, top: 10, bottom: 0),
                                    child: TextField(
                                      controller: vehical_reg_no,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(14.0)),
                                        ),
                                        labelText:
                                            "Vehicle Registration Number",
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 15, bottom: 0),
                                  child: TextField(
                                    controller: driver_name,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(14.0)),
                                      ),
                                      labelText: 'Name of the driver',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 15, bottom: 0),
                                  child: TextField(
                                    controller: driver_phone,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(14.0)),
                                        ),
                                        labelText: 'Phone Number of the Driver',
                                        errorText: _errorText),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 15, bottom: 0),
                                  child: TextField(
                                    controller: mode_transport,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(14.0)),
                                      ),
                                      labelText: 'Vehicle Used',
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.only(top: 15, right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(14)),
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 0, top: 10, bottom: 0),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        TextButton.icon(
                                          icon: Icon(Icons.image),
                                          onPressed: () {
                                            setState(() {
                                              _showpickoptiondialogLisence(
                                                  context);
                                            });
                                          },
                                          label: Text("Driver License"),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.check_circle,
                                          color: (_imageLisence) == null
                                              ? Colors.red
                                              : Colors.green,
                                          size: 28.0,
                                        ),
                                      ]),
                                ),
                              ]));
                            } else {
                              return Container(
                                color: Colors.white,
                              );
                            }
                          }),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14)),
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 0, top: 10, bottom: 0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  TextButton.icon(
                                    icon: Icon(Icons.image),
                                    onPressed: () {
                                      setState(() {
                                        _showpickoptiondialogSignature(context);
                                      });
                                    },
                                    label: Text("Digital Signature"),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imageSignature) == null
                                        ? Colors.red
                                        : Colors.green,
                                    size: 28.0,
                                  ),
                                ]),
                          ),
                          Visibility(
                            visible: isShow,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                              strokeWidth: 8,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, bottom: 0.0),
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                              onPressed: () {
                                if (log_details.isNotEmpty) {
                                  logupdate();
                                }
                                String formtype = "form2";
                                String name = Name;
                                String selDivision = dropdownValue1;
                                String selRange = dropdownValue;
                                String selDistrict = District;
                                String selTaluk = Taluka;
                                String selVillage = village;
                                String survay = survey_no;
                                String address = Address;
                                String treePCut = "";
                                String blockL = block;
                                String pin = Pincode;
                                String locImageA = imageone;
                                String locImageB = imagetwo;
                                String locImageC = imagethree;
                                String locImageD = imagefour;
                                String image1Lat = imagelatone;
                                String image2Lat = imagelattwo;
                                String image3Lat = imagelatthree;
                                String image4Lat = imagelatfour;
                                String image1Log = imagelongone;
                                String image2Log = imagelongtwo;
                                String image3Log = imagelongthree;
                                String image4Log = imagelongfour;
                                String treeSpecies = holder_1.toString();
                                String purposeCut = Purpose;
                                String driverNameloc = driver_name.text;
                                String vehicelReg = vehical_reg_no.text;
                                String phone = driver_phone.text;
                                String mode = mode_transport.text;
                                String destinationAddress =
                                    destination_add.text;
                                String destinationState = selectedState;
                                String licenceImg = base64ImageLisence;
                                String ownershipProofImg = Ownership;
                                String revenueApplicationImg = Application;
                                String revenueApprovalImg = Approval;
                                String declarationImg = Declaration;
                                String locationSketchImg = Location;
                                String treeOwnershipImg = TreeOwnership;
                                String aadharCardImg = IdProof;
                                String signatureImg = base64ImageSignature;
                                String selectProof = selectedPRoof;
                                if (logDataF.isNotEmpty) {
                                  log = json.encode(logDataF);
                                }
                                String logData = log;
                                isShow = true;
                                _insert(
                                    (formtype == null) ? "" : formtype,
                                    (name == null) ? "" : name,
                                    (selDivision == null) ? "" : selDivision,
                                    (selRange == null) ? "" : selRange,
                                    (selDistrict == null) ? "" : selDistrict,
                                    (selTaluk == null) ? "" : selTaluk,
                                    (selVillage == null) ? "" : selVillage,
                                    (survay == null) ? "" : survay,
                                    (address == null) ? "" : address,
                                    (treePCut == null) ? "" : treePCut,
                                    (blockL == null) ? "" : blockL,
                                    (pin == null) ? "" : pin,
                                    (locImageA == null) ? "" : locImageA,
                                    (locImageB == null) ? "" : locImageB,
                                    (locImageC == null) ? "" : locImageC,
                                    (locImageD == null) ? "" : locImageD,
                                    (image1Lat == null) ? "" : image1Lat,
                                    (image2Lat == null) ? "" : image2Lat,
                                    (image3Lat == null) ? "" : image3Lat,
                                    (image4Lat == null) ? "" : image4Lat,
                                    (image1Log == null) ? "" : image1Log,
                                    (image2Log == null) ? "" : image2Log,
                                    (image3Log == null) ? "" : image3Log,
                                    (image4Log == null) ? "" : image4Log,
                                    (treeSpecies == null) ? "" : treeSpecies,
                                    (purposeCut == null) ? "" : purposeCut,
                                    (driverNameloc == null)
                                        ? ""
                                        : driverNameloc,
                                    (vehicelReg == null) ? "" : vehicelReg,
                                    (phone == null) ? "" : phone,
                                    (mode == null) ? "" : mode,
                                    (destinationAddress == null)
                                        ? ""
                                        : destinationAddress,
                                    (destinationState == null)
                                        ? ""
                                        : destinationState,
                                    (licenceImg == null) ? "" : licenceImg,
                                    (ownershipProofImg == null)
                                        ? ""
                                        : ownershipProofImg,
                                    (revenueApplicationImg == null)
                                        ? ""
                                        : revenueApplicationImg,
                                    (revenueApprovalImg == null)
                                        ? ""
                                        : revenueApprovalImg,
                                    (declarationImg == null)
                                        ? ""
                                        : declarationImg,
                                    (locationSketchImg == null)
                                        ? ""
                                        : locationSketchImg,
                                    (treeOwnershipImg == null)
                                        ? ""
                                        : treeOwnershipImg,
                                    (aadharCardImg == null)
                                        ? ""
                                        : aadharCardImg,
                                    (signatureImg == null) ? "" : signatureImg,
                                    (selectProof == null) ? "" : selectProof,
                                    (logData == null) ? "" : logData);
                              },
                              child: Text('Insert Details'),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, bottom: 0.0),
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                              onPressed: () async {
                                if (Name.isEmpty ||
                                    dropdownValue1 == null ||
                                    Address.isEmpty ||
                                    base64ImageSignature.isEmpty ||
                                    survey_no.isEmpty ||
                                    destination_add.text.isEmpty ||
                                    Ownership.isEmpty ||
                                    IdProof.isEmpty ||
                                    Application.isEmpty ||
                                    TreeOwnership.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please select and fill all Field \n or You can save form for future submission",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                } else if ((vehical_reg_no.text.isEmpty) ||
                                    (driver_name.text.isEmpty) ||
                                    (driver_phone.text.isEmpty) ||
                                    (mode_transport.text.isEmpty) ||
                                    (base64ImageLisence == "")) {
                                  Fluttertoast.showToast(
                                      msg: "Please add all vechicle details ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                } else {
                                  setState(() {
                                    isShow = true;
                                    if (log_details.isNotEmpty) {
                                      logupdate();
                                    }
                                  });
                                  const String url =
                                      'https://f4020lwv-8000.inc1.devtunnels.ms//api/auth/Formtwophaseone';
                                  Map data = {
                                    "name": Name ?? "",
                                    "address": Address ?? "",
                                    "survey_no": survey_no ?? "",
                                    "tree_proposed": log_details.length,
                                    "village": village ?? "",
                                    "district": District ?? "",
                                    "area_range": dropdownValue ?? "",
                                    "division": dropdownValue1 ?? "",
                                    "destination_address": destination_add.text,
                                    "destination_state": selectedState ?? "",
                                    "pincode": Pincode ?? "",
                                    "block": block ?? "",
                                    "taluka": Taluka ?? "",
                                    "licence_img": base64ImageLisence.isEmpty
                                        ? ""
                                        : {
                                            "type": ".png",
                                            "image": base64ImageLisence
                                          },
                                    "ownership_proof_img": {
                                      "type": ".png",
                                      "image": Ownership
                                    },
                                    "revenue_application_img": {
                                      "type": ".png",
                                      "image": Application
                                    },
                                    "revenue_approval_img": {
                                      "type": ".png",
                                      "image": Approval
                                    },
                                    "declaration_img": {
                                      "type": ".png",
                                      "image": Declaration
                                    },
                                    "location_sketch_img": {
                                      "type": ".png",
                                      "image": Location
                                    },
                                    "tree_ownership_img": {
                                      "type": ".png",
                                      "image": TreeOwnership
                                    },
                                    "aadhar_card_img": {
                                      "type": ".png",
                                      "image": IdProof
                                    },
                                    "signature_img": {
                                      "type": ".png",
                                      "image": base64ImageSignature
                                    },
                                    "location_img1": {
                                      "type": ".png",
                                      "image": imageone
                                    },
                                    "location_img2": {
                                      "type": ".png",
                                      "image": imagetwo
                                    },
                                    "location_img3": {
                                      "type": ".png",
                                      "image": imagethree
                                    },
                                    "location_img4": {
                                      "type": ".png",
                                      "image": imagefour
                                    },
                                    "image1_lat": "11.815342",
                                    "image1_log": "76.083107",
                                    "image2_lat": "11.815132",
                                    "image2_log": "76.083268",
                                    "image3_lat": "11.815363",
                                    "image3_log": "76.083943",
                                    "image4_lat": "11.815899",
                                    "image4_log": "76.083697",
                                    "tree_species": holder_1.toString(),
                                    "purpose_cut": Purpose ?? "",
                                    "vehicle_detail": flag,
                                    "vehicel_reg": vehical_reg_no.text,
                                    "driver_name": driver_name.text,
                                    "phone": driver_phone.text,
                                    "mode": mode_transport.text,
                                    "trees_cutted": "2",
                                    "spec_details": logDataF ?? ""
                                  };
                                  var body = json.encode(data);
                                  try {
                                    final response = await http.post(
                                        Uri.parse(url),
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization': "token $sessionToken"
                                        },
                                        body: body);

                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> responseJson =
                                          json.decode(response.body);
                                      Fluttertoast.showToast(
                                          msg: responseJson['message']
                                              .toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 8,
                                          backgroundColor: Colors.blue,
                                          textColor: Colors.white,
                                          fontSize: 18.0);
                                      destination_add.clear();
                                      setState(() {
                                        isShow = false;
                                      });
                                      Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                              transitionDuration:
                                                  Duration(milliseconds: 250),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  animationTime,
                                                  child) {
                                                return ScaleTransition(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  scale: animation,
                                                  child: child,
                                                );
                                              },
                                              pageBuilder: (context, animation,
                                                  animationTime) {
                                                return HomePage(
                                                  sessionToken: sessionToken,
                                                  userName: userName,
                                                  userEmail: userEmail,
                                                  userId: userId,
                                                  userMobile:
                                                      '', // Add appropriate value
                                                  userAddress:
                                                      '', // Add appropriate value
                                                  userProfile:
                                                      '', // Add appropriate value
                                                  userGroup:
                                                      '', // Add appropriate value
                                                  userCato:
                                                      '', // Add appropriate value
                                                );
                                              }));
                                    } else {
                                      throw Exception('Failed to submit form');
                                    }
                                  } catch (e) {
                                    print(e);
                                    Fluttertoast.showToast(
                                        msg: "Error submitting form",
                                        backgroundColor: Colors.red);
                                  }
                                }
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Cairo',
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void _insert(
      formtype,
      name,
      selDivision,
      selRange,
      selDistrict,
      selTaluk,
      selVillage,
      survay,
      address,
      treePCut,
      block,
      pin,
      imageA,
      imageB,
      imageC,
      imageD,
      image1lat,
      image2lat,
      image3lat,
      image4lat,
      image1long,
      image2long,
      image3long,
      image4long,
      treespecies,
      purposecut,
      drivernameLoc,
      vehicelreg,
      phone,
      mode,
      destinationaddress,
      destinationstate,
      licenceImg,
      ownershipproofimg,
      revenueapplicationimg,
      revenueapprovalimg,
      declarationimg,
      locationsketchimg,
      treeownershipimg,
      aadharcardimg,
      signatureimg,
      selectProof,
      logData) async {
    Map<String, dynamic> row = {
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
      DatabaseHelper.columnblockL: block,
      DatabaseHelper.columnpin: pin,
      DatabaseHelper.columnlocImageA: imageA,
      DatabaseHelper.columnlocImageB: imageB,
      DatabaseHelper.columnlocImageC: imageC,
      DatabaseHelper.columnlocImageD: imageD,
      DatabaseHelper.columnimage1_lat: image1lat,
      DatabaseHelper.columnimage2_lat: image2lat,
      DatabaseHelper.columnimage3_lat: image3lat,
      DatabaseHelper.columnimage4_lat: image4lat,
      DatabaseHelper.columnimage1_long: image1long,
      DatabaseHelper.columnimage2_long: image2long,
      DatabaseHelper.columnimage3_long: image3long,
      DatabaseHelper.columnimage4_long: image4long,
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

    Car car = Car.fromMap(row);
    final id = await dbHelper.insert(car);
    isShow = false;
    Fluttertoast.showToast(
        msg: "Data uploded locally",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0);

    await loginAction();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (context, animation, animationTime, child) {
              return ScaleTransition(
                alignment: Alignment.topCenter,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              return HomePage(
                sessionToken: sessionToken,
                userName: userName,
                userEmail: userEmail,
                userId: userId,
                userMobile: '', // Add appropriate value
                userAddress: '', // Add appropriate value
                userProfile: '', // Add appropriate value
                userGroup: '', // Add appropriate value
                userCato: '', // Add appropriate value
              );
            }));
  }
}
