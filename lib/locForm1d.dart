import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/blocks/formOneblock.dart';
import 'package:tigramnks/events/addFormOne.dart';
import 'dart:io' as Io;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/homePage.dart';
import 'package:tigramnks/model/formOneModel.dart';
import 'package:tigramnks/sqflite/DatabaseHelper.dart';
import 'package:tigramnks/sqflite/dataBase.dart';
import 'package:tigramnks/sqflite/formModel.dart';

class locForm1d extends StatefulWidget {
  String sessionToken;
  int userId;
  int id;
  String Type;
  String userName;
  String userEmail;
  String App_no;
  String Division;
  String Range;
  String District;
  String Taluke;
  String Village;
  String address;
  String survay;
  String treePCut;
  String blockL;
  String pin;
  String imageA;
  String imageB;
  String imageC;
  String imageD;
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
  String drivername;
  String vechclereg;
  String mode;
  String phone;
  String destAddress;
  String destState;
  String licenceImg;
  String ownerProof;
  String revenApplication;
  String revenApprove;
  String declaration;
  String locationSkch;
  String treeOwnership;
  String aadarcard;
  String signatureImg;
  String selectProof;
  String logData;
  locForm1d(
      {super.key,
      required this.sessionToken,
      required this.userId,
      required this.id,
      required this.Type,
      required this.userName,
      required this.userEmail,
      required this.App_no,
      required this.Division,
      required this.Range,
      required this.District,
      required this.Taluke,
      required this.Village,
      required this.address,
      required this.survay,
      required this.treePCut,
      required this.blockL,
      required this.pin,
      required this.imageA,
      required this.imageB,
      required this.imageC,
      required this.imageD,
      required this.image1lat,
      required this.image2lat,
      required this.image3lat,
      required this.image4lat,
      required this.image1log,
      required this.image2log,
      required this.image3log,
      required this.image4log,
      required this.treespecies,
      required this.purposecut,
      required this.drivername,
      required this.vechclereg,
      required this.mode,
      required this.phone,
      required this.destAddress,
      required this.destState,
      required this.licenceImg,
      required this.ownerProof,
      required this.revenApplication,
      required this.revenApprove,
      required this.declaration,
      required this.locationSkch,
      required this.treeOwnership,
      required this.aadarcard,
      required this.signatureImg,
      required this.selectProof,
      required this.logData});
  @override
  State<locForm1d> createState() => _locForm1dState(
      sessionToken,
      userId,
      id,
      Type,
      userName,
      userEmail,
      App_no,
      Division,
      Range,
      District,
      Taluke,
      Village,
      address,
      survay,
      treePCut,
      blockL,
      pin,
      imageA,
      imageB,
      imageC,
      imageD,
      image1lat,
      image2lat,
      image3lat,
      image4lat,
      image1log,
      image2log,
      image3log,
      image4log,
      treespecies,
      purposecut,
      drivername,
      vechclereg,
      mode,
      phone,
      destAddress,
      destState,
      licenceImg,
      ownerProof,
      revenApplication,
      revenApprove,
      declaration,
      locationSkch,
      treeOwnership,
      aadarcard,
      signatureImg,
      selectProof,
      logData);
}

class _locForm1dState extends State<locForm1d> {
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();

    viewData();
  }

  String sessionToken;
  int userId;
  int id;
  String Type;
  String userName;
  String userEmail;
  String App_no;
  String Division;
  String Range;
  String District;
  String Taluke;
  String Village;
  String address;
  String survay;
  String treePCut;
  String blockL;
  String pin;
  String imageA;
  String imageB;
  String imageC;
  String imageD;
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
  String drivername;
  String vechclereg;
  String mode;
  String phone;
  String destAddress;
  String destState;
  String licenceImg;
  String ownerProof;
  String revenApplication;
  String revenApprove;
  String declaration;
  String locationSkch;
  String treeOwnership;
  String aadarcard;
  String signatureImg;
  String selectProof;
  String logData;
  _locForm1dState(
      this.sessionToken,
      this.userId,
      this.id,
      this.Type,
      this.userName,
      this.userEmail,
      this.App_no,
      this.Division,
      this.Range,
      this.District,
      this.Taluke,
      this.Village,
      this.address,
      this.survay,
      this.treePCut,
      this.blockL,
      this.pin,
      this.imageA,
      this.imageB,
      this.imageC,
      this.imageD,
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
      this.drivername,
      this.vechclereg,
      this.mode,
      this.phone,
      this.destAddress,
      this.destState,
      this.licenceImg,
      this.ownerProof,
      this.revenApplication,
      this.revenApprove,
      this.declaration,
      this.locationSkch,
      this.treeOwnership,
      this.aadarcard,
      this.signatureImg,
      this.selectProof,
      this.logData);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController destination_add = TextEditingController();
  TextEditingController vehical_reg_no = TextEditingController();
  TextEditingController driver_name = TextEditingController();
  TextEditingController driver_phone = TextEditingController();
  TextEditingController mode_transport = TextEditingController();
  bool flag = false;
  int _radioValue = 0;
  late String maintenance;
  bool isShow = false;
  var _imageSignature;
  var _imageLisence;
  late List log_details;
  late String imgLIC;
  late String IMGsig;
  late String selectedState;

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

  void viewData() async {
    print(Type);

    if (destState != "") {
      selectedState = destState.toString();
    }
    if (destAddress != "") {
      destination_add.text = destAddress.toString();
    }
    if (vechclereg != "") {
      vehical_reg_no.text = vechclereg.toString();
    }
    if (drivername != "") {
      driver_name.text = drivername.toString();
    }
    if (drivername != "") {
      driver_phone.text = drivername.toString();
    }
    if (mode != "") {
      mode_transport.text = mode.toString();
    }
    if (licenceImg == "") {
      imgLIC = "fill";
    }
    if (signatureImg == "") {
      IMGsig = "fill";
    }
  }

  // String selectedState; // Removed duplicate declaration
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
                      child: const Row(
                        children: [
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
                      child: const Row(
                        children: [
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

  final picker = ImagePicker();
  Future<void> setSignaturepicgallery() async {
    signatureImg = "";
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageSignature = File(pickedFile.path);

        signatureImg = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setLisencepicgallery() async {
    licenceImg = "";
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageLisence = File(pickedFile.path);

        licenceImg = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("FORM - I"),

          //backgroundColor: Colors.blueGrey,
          elevation: 0,
          //automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(key: _formKey, children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10, bottom: 0),
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: const TextSpan(children: <TextSpan>[
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
                  margin: const EdgeInsets.only(top: 7, left: 15, right: 15),
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
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
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
                    /*underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),*/
                    onChanged: (String? data) {
                      setState(() {
                        selectedState = data!;
                      });

                      print(selectedState);
                    },
                    items: State.map<DropdownMenuItem<String>>((String value) {
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
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: destination_add,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      labelText: 'Destination Address',
                      hintText: 'Destination Address',
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 15),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Enter Vehicle Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text(
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
                            title: const Text(
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
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14.0)),
                                    ),
                                    labelText: "Vehicle Registration Number",
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0, top: 15, bottom: 0),
                              //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: driver_name,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14.0)),
                                  ),
                                  labelText: 'Name of the driver',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0, top: 15, bottom: 0),
                              //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: driver_phone,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14.0)),
                                  ),
                                  labelText: 'Phone Number of the Driver',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0,
                                  top: 15,
                                  bottom:
                                      0), //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: mode_transport,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14.0)),
                                  ),
                                  labelText: 'Vehicle Used',
                                ),
                              ),
                            ),
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
                                      icon: const Icon(Icons.image),
                                      onPressed: () {
                                        setState(() {
                                          _showpickoptiondialogLisence(context);
                                        });
                                        // License(ImageSource.gallery);
                                      },
                                      label: const Text("Driver License"),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.check_circle,
                                      color: _licFunction() == "FALSE"
                                          ? Colors.red
                                          : Colors.green,
                                      size: 28.0,
                                    ),
                                  ]),
                            ),
                          ]));
                        } else if (flag == false) {
                          return Container(
                            color: Colors.white,
                          );
                        }
                        return Container(); // Default empty container
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
                                icon: const Icon(Icons.image),
                                onPressed: () {
                                  setState(() {
                                    _showpickoptiondialogSignature(context);
                                  });
                                },
                                label: const Text("Digital Signature"),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.check_circle,
                                color: _sigFunction() == "FALSE"
                                    ? Colors.red
                                    : Colors.green,
                                size: 28.0,
                              ),
                            ]),
                      ),
                      Visibility(
                        visible: isShow,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 8,
                        ),
                      ),
                      Visibility(
                        visible: Type == "form1",
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            onPressed: () async {
                              if (1 > 12) {
                                Fluttertoast.showToast(
                                    msg: "Please select and fill all Field",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                log_details = json.decode(logData);
                                print("PPPPPPP$log_details");
                                print(imageA);
                                setState(() {
                                  isShow = true;
                                });

                                const String url =
                                    'http://192.168.54.114:8000/api/auth/InsertRecord';
                                Map data = {
                                  "name": App_no,
                                  "address": address,
                                  "survey_no": survay,
                                  "tree_proposed": treePCut,
                                  "village": Village,
                                  "district": District,
                                  "block": blockL,
                                  "taluka": Taluke,
                                  "division": Division,
                                  "area_range": Range,
                                  "pincode": pin,
                                  "tree_species": treespecies,
                                  "purpose_cut": purposecut,
                                  "driver_name": driver_name.text,
                                  "vehicel_reg": vehical_reg_no.text,
                                  "phone": driver_phone.text,
                                  "mode": mode_transport.text,
                                  "destination_address": destination_add.text,
                                  "destination_state": selectedState,

                                  "licence_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": licenceImg
                                  },
                                  "ownership_proof_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": ownerProof
                                  },
                                  "revenue_application_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": revenApplication
                                  },
                                  "revenue_approval_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": revenApprove
                                  },
                                  "declaration_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": declaration
                                  },
                                  "location_sketch_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": locationSkch
                                  },
                                  "tree_ownership_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": treeOwnership
                                  },
                                  "aadhar_card_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": aadarcard
                                  },
                                  "signature_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": signatureImg
                                  },

                                  "location_img1": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageA
                                  },
                                  "location_img2": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageB
                                  },
                                  "location_img3": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageC
                                  },
                                  "location_img4": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageD
                                  },
                                  "image1_lat": image1lat,
                                  "image2_lat": image2lat,
                                  "image3_lat": image3lat,
                                  "image4_lat": image4lat,
                                  "image1_log": image1log,
                                  "image2_log": image2log,
                                  "image3_log": image3log,
                                  "image4_log": image4log,

                                  "trees_cutted": "2",

                                  // "log_details": log_details ?? """
                                  "log_details": log_details ?? ""

                                  //[{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"},{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"}]
                                };
                                print(data);
                                var body = json.encode(data);
                                print(body);
                                final response = await http.post(Uri.parse(url),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Authorization': "token $sessionToken"
                                    },
                                    body: body);
                                print(response.body);

                                Map<String, dynamic> responseJson =
                                    json.decode(response.body);

                                print(
                                    "----------------From Submit-----------------------");

                                print(responseJson);
                                if (responseJson['message'] !=
                                    "Data Saved Successfully.") {
                                  isShow = false;
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }
                                await loginAction();
                                Fluttertoast.showToast(
                                    msg: responseJson['message'].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                                setState(() {
                                  isShow = false;
                                });
                                destination_add.clear();
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 250),
                                        transitionsBuilder: (context, animation,
                                            animationTime, child) {
                                          return ScaleTransition(
                                            alignment: Alignment.topCenter,
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
                                              userMobile: '',
                                              userAddress: '',
                                              userProfile: '',
                                              userGroup: '',
                                              userCato: '');
                                        }));
                              }
                            },
                            child: const Text(
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
                      ),
                      Visibility(
                        visible: Type == "form2",
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            onPressed: () async {
                              if (1 > 12) {
                                Fluttertoast.showToast(
                                    msg: "Please select and fill all Field",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                log_details = json.decode(logData);
                                print("PPPPPPP$log_details");
                                print(imageA);
                                setState(() {
                                  isShow = true;
                                });

                                const String url =
                                    'http://192.168.54.114:8000/api/auth/Formtwophaseone';
                                Map data = {
                                  "name": App_no,
                                  "address": address,
                                  "survey_no": survay,
                                  "tree_proposed": treePCut,
                                  "village": Village,
                                  "district": District,
                                  "block": blockL,
                                  "taluka": Taluke,
                                  "division": Division,
                                  "area_range": Range,
                                  "pincode": pin,
                                  "tree_species": treespecies,
                                  "purpose_cut": purposecut,
                                  "driver_name": driver_name.text,
                                  "vehicel_reg": vehical_reg_no.text,
                                  "phone": driver_phone.text,
                                  "mode": mode_transport.text,
                                  "destination_address": destination_add.text,
                                  "destination_state": selectedState,

                                  "licence_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": licenceImg
                                  },
                                  "ownership_proof_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": ownerProof
                                  },
                                  "revenue_application_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": revenApplication
                                  },
                                  "revenue_approval_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": revenApprove
                                  },
                                  "declaration_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": declaration
                                  },
                                  "location_sketch_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": locationSkch
                                  },
                                  "tree_ownership_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": treeOwnership
                                  },
                                  "aadhar_card_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": aadarcard
                                  },
                                  "signature_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": signatureImg
                                  },

                                  "location_img1": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageA
                                  },
                                  "location_img2": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageB
                                  },
                                  "location_img3": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageC
                                  },
                                  "location_img4": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageD
                                  },
                                  "image1_lat": image1lat,
                                  "image2_lat": image2lat,
                                  "image3_lat": image3lat,
                                  "image4_lat": image4lat,
                                  "image1_log": image1log,
                                  "image2_log": image2log,
                                  "image3_log": image3log,
                                  "image4_log": image4log,

                                  "trees_cutted": "2",

                                  // "log_details": log_details ?? """
                                  "spec_details": log_details ?? ""

                                  //[{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"},{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"}]
                                };
                                print(data);
                                var body = json.encode(data);
                                print(body);
                                final response = await http.post(Uri.parse(url),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Authorization': "token $sessionToken"
                                    },
                                    body: body);
                                print(response.body);

                                Map<String, dynamic> responseJson =
                                    json.decode(response.body);

                                print(
                                    "----------------From Submit-----------------------");

                                print(responseJson);
                                if (responseJson['message'] !=
                                    "Data Saved Successfully.") {
                                  isShow = false;
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }
                                await loginAction();
                                Fluttertoast.showToast(
                                    msg: responseJson['message'].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                                setState(() {
                                  isShow = false;
                                });
                                destination_add.clear();
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 250),
                                        transitionsBuilder: (context, animation,
                                            animationTime, child) {
                                          return ScaleTransition(
                                            alignment: Alignment.topCenter,
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
                                              userMobile: '',
                                              userAddress: '',
                                              userProfile: '',
                                              userGroup: '',
                                              userCato: '');
                                        }));
                              }
                            },
                            child: const Text(
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
                      )
                    ]))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19, right: 15, top: 15),
              child: ElevatedButton(
                child: const Text(
                  'Update form',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () {
                  int ID = id;
                  String formtype = Type;
                  String name = App_no;
                  String selDivision = Division;
                  String selRange = Range;
                  String selDistrict = District;
                  String selTaluk = Taluke;
                  String selVillage = Village;
                  String Survay = survay;
                  String Address = address;
                  String TreePCut = treePCut;
                  String BlockL = blockL;
                  String Pin = pin;
                  String locImageA = imageA;
                  String locImageB = imageB;
                  String locImageC = imageC;
                  String locImageD = imageD;
                  String image1Lat = image1lat;
                  String image2Lat = image2lat;
                  String image3Lat = image3lat;
                  String image4Lat = image4lat;
                  String image1Log = image1log;
                  String image2Log = image2log;
                  String image3Log = image3log;
                  String image4Log = image4log;
                  String treeSpecies = treespecies;
                  String purposeCut = purposecut;
                  String driverNameloc = driver_name.text;
                  String vehicelReg = vehical_reg_no.text;
                  String phone = driver_phone.text;
                  String mode = mode_transport.text;
                  String destinationAddress = destination_add.text;
                  String destinationState = selectedState;
                  String LicenceImg = licenceImg;
                  String ownershipProofImg = ownerProof;
                  String revenueApplicationImg = revenApplication;
                  String revenueApprovalImg = revenApprove;
                  String declarationImg = declaration;
                  String locationSketchImg = locationSkch;
                  String treeOwnershipImg = treeOwnership;
                  String aadharCardImg = aadarcard;
                  String signatureImgLocal = signatureImg;
                  String SelectProof = selectProof;
                  String LogData = logData;
                  _update(
                      ID,
                      (formtype == null) ? "" : formtype,
                      (name == null) ? "" : name,
                      (selDivision == null) ? "" : selDivision,
                      (selRange == null) ? "" : selRange,
                      (selDistrict == null) ? "" : selDistrict,
                      (selTaluk == null) ? "" : selTaluk,
                      (selVillage == null) ? "" : selVillage,
                      (Survay == null) ? "" : Survay,
                      (Address == null) ? "" : Address,
                      (TreePCut == null) ? "" : TreePCut,
                      (BlockL == null) ? "" : BlockL,
                      (Pin == null) ? "" : Pin,
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
                      (driverNameloc == null) ? "" : driverNameloc,
                      (vehicelReg == null) ? "" : vehicelReg,
                      (phone == null) ? "" : phone,
                      (mode == null) ? "" : mode,
                      (destinationAddress == null) ? "" : destinationAddress,
                      (destinationState == null) ? "" : destinationState,
                      (LicenceImg == null) ? "" : LicenceImg,
                      (ownershipProofImg == null) ? "" : ownershipProofImg,
                      (revenueApplicationImg == null)
                          ? ""
                          : revenueApplicationImg,
                      (revenueApprovalImg == null) ? "" : revenueApprovalImg,
                      (declarationImg == null) ? "" : declarationImg,
                      (locationSketchImg == null) ? "" : locationSketchImg,
                      (treeOwnershipImg == null) ? "" : treeOwnershipImg,
                      (aadharCardImg == null) ? "" : aadharCardImg,
                      (signatureImg == null) ? "" : signatureImg,
                      (SelectProof == null) ? "" : SelectProof,
                      (LogData == null) ? "" : LogData);
                },
              ),
            ),
          ]),
        ));
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void _update(
      id,
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
      blockL,
      pin,
      locImageA,
      locImageB,
      locImageC,
      locImageD,
      image1lat,
      image2lat,
      image3lat,
      image4lat,
      image1log,
      image2log,
      image3log,
      image4log,
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
    // row to update
    Car car = Car(
        id,
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
        blockL,
        pin,
        locImageA,
        locImageB,
        locImageC,
        locImageD,
        image1lat,
        image2lat,
        image3lat,
        image4lat,
        image1log,
        image2log,
        image3log,
        image4log,
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
        logData);
    final rowsAffected = await dbHelper.update(car);
    Fluttertoast.showToast(
        msg: "Data updated ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 18.0);
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 250),
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
                userMobile: '',
                userAddress: '',
                userProfile: '',
                userGroup: '',
                userCato: '',
              );
            }));
  }

  Object _licFunction() {
    if (_imageLisence != null || imgLIC != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _sigFunction() {
    if (_imageSignature != null || IMGsig != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }
}
