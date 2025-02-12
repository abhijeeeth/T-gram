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
      {this.sessionToken,
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
      this.logData});
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
  String maintenance;
  bool isShow = false;
  var _imageSignature;
  var _imageLisence;

  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
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

  List log_details;
  String imgLIC;
  String IMGsig;
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
        appBar: NewGradientAppBar(
          title: Text("FORM - I"),
          gradient: LinearGradient(
              colors: [HexColor("#26f596"), HexColor("#0499f2")]),
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
                  decoration: new BoxDecoration(
                      border: new Border.all(
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
                    onChanged: (String data) {
                      setState(() {
                        selectedState = data;
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(14.0)),
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
                        Expanded(
                          child: new Text(
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
                              decoration: new BoxDecoration(
                                  border: new Border.all(
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
                                    Spacer(),
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
                      }),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15, right: 15),
                        decoration: new BoxDecoration(
                            border: new Border.all(
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
                                color: _sigFunction() == "FALSE"
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
                                if (logData != null) {
                                  log_details = json.decode(logData);
                                  print("PPPPPPP$log_details");
                                }
                                print(imageA);
                                setState(() {
                                  isShow = true;
                                });

                                const String url =
                                    'http://13.234.208.246/api/auth/InsertRecord';
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
                                            Duration(milliseconds: 250),
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
                                              userId: userId);
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
                                if (logData != null) {
                                  log_details = json.decode(logData);
                                  print("PPPPPPP$log_details");
                                }
                                print(imageA);
                                setState(() {
                                  isShow = true;
                                });

                                const String url =
                                    'http://13.234.208.246/api/auth/Formtwophaseone';
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
                                            Duration(milliseconds: 250),
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
                                              userId: userId);
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
              padding: EdgeInsets.only(left: 19, right: 15, top: 15),
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
                  String image1_lat = image1lat;
                  String image2_lat = image2lat;
                  String image3_lat = image3lat;
                  String image4_lat = image4lat;
                  String image1_log = image1log;
                  String image2_log = image2log;
                  String image3_log = image3log;
                  String image4_log = image4log;
                  String tree_species = treespecies;
                  String purpose_cut = purposecut;
                  String driver_nameLoc = driver_name.text;
                  String vehicel_reg = vehical_reg_no.text;
                  String phone = driver_phone.text;
                  String mode = mode_transport.text;
                  String destination_address = destination_add.text;
                  String destination_state = selectedState;
                  String LicenceImg = licenceImg;
                  String ownership_proof_img = ownerProof;
                  String revenue_application_img = revenApplication;
                  String revenue_approval_img = revenApprove;
                  String declaration_img = declaration;
                  String location_sketch_img = locationSkch;
                  String tree_ownership_img = treeOwnership;
                  String aadhar_card_img = aadarcard;
                  String signature_img = signatureImg;
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
                      (image1_lat == null) ? "" : image1_lat,
                      (image2_lat == null) ? "" : image2_lat,
                      (image3_lat == null) ? "" : image3_lat,
                      (image4_lat == null) ? "" : image4_lat,
                      (image1_log == null) ? "" : image1_log,
                      (image2_log == null) ? "" : image2_log,
                      (image3_log == null) ? "" : image3_log,
                      (image4_log == null) ? "" : image4_log,
                      (tree_species == null) ? "" : tree_species,
                      (purpose_cut == null) ? "" : purpose_cut,
                      (driver_nameLoc == null) ? "" : driver_nameLoc,
                      (vehicel_reg == null) ? "" : vehicel_reg,
                      (phone == null) ? "" : phone,
                      (mode == null) ? "" : mode,
                      (destination_address == null) ? "" : destination_address,
                      (destination_state == null) ? "" : destination_state,
                      (LicenceImg == null) ? "" : LicenceImg,
                      (ownership_proof_img == null) ? "" : ownership_proof_img,
                      (revenue_application_img == null)
                          ? ""
                          : revenue_application_img,
                      (revenue_approval_img == null)
                          ? ""
                          : revenue_approval_img,
                      (declaration_img == null) ? "" : declaration_img,
                      (location_sketch_img == null) ? "" : location_sketch_img,
                      (tree_ownership_img == null) ? "" : tree_ownership_img,
                      (aadhar_card_img == null) ? "" : aadhar_card_img,
                      (signature_img == null) ? "" : signature_img,
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
