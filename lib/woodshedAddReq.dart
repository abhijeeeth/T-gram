import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' show File, HttpHeaders;
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/Form.dart';
import 'package:tigramnks/homePage.dart';
import 'package:tigramnks/itgramWoodBuy.dart';
import 'package:tigramnks/sqflite/dataBase.dart';
import 'package:tigramnks/tigramWoodShed.dart';
import 'dart:developer' as logNK;

import 'model/formOneModel.dart';

class woodshedAddReq extends StatefulWidget {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  woodshedAddReq({
    super.key,
    required this.userId,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
  });
  @override
  State<woodshedAddReq> createState() =>
      _woodshedAddReqState(userId, sessionToken, userName, userEmail);
}

class _woodshedAddReqState extends State<woodshedAddReq> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  _woodshedAddReqState(
      this.userId, this.sessionToken, this.userName, this.userEmail);
  String? dropdownValue;
  String? selectedDistrict;
  String? DD;
  List<String> Rname = [];
  int RL = 0;
  List<String> Dname = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      ListRange();
      //ListDivision();
      LoadDistric();
    });
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  String? selectedPRoof;
  String? dropdownValue2;
  String holder = '';
  List<String> IdProof = [
    " Rosewood (Dalbergia latifolia)",
    "Teak (Tectona grandis)",
    "Thempavu (Terminalia tomantosa)",
    "Chadachi (Grewia tiliaefolia)",
    "Chandana vempu(Cedrela toona)",
    "Vellakil (Dysoxylum malabaricum)",
    "Irul (Xylia xylocarpa)",
    "Ebony (Diospyrus sp.)",
    "Kampakam (Hopea Parviflora)"
  ];

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController quntity = TextEditingController();

  List<String> district = [];
  LoadDistric() async {
    int RL = 0;

    String url = 'https://timber.forest.kerala.gov.in/api/auth/ListDistrict';

    //  Map<String, String> headers = {
    //  'Content-Type': 'application/json',
    //  'Authorization': 'token $sessionToken'
    //  };
    var response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'token $sessionToken',
        'Content-Type': 'application/json'
      },
    );
    print(response.body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
      for (int i = 0; i < RL; i++) {
        district.add(responseJSON["data"][i]['district_name']);
      }
    });
  }

  ListRange() async {
    const String url = 'https://timber.forest.kerala.gov.in/api/auth/ListRange';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    print(response.body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
    });
    for (int i = 0; i < RL; i++) {
      Rname.add(responseJSON["data"][i]['name']);
    }
    print(Rname);
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Add Requirements",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          //backgroundColor: ColorLinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),

          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: RichText(
                textAlign: TextAlign.right,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Division                                District",
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
              margin: const EdgeInsets.only(top: 8, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child: Row(children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Division",
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
                      dropdownValue = data!;
                    });
                    print(dropdownValue);
                  },
                  items: Rname.toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: selectedDistrict,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select District",
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
                      selectedDistrict = data!;
                    });
                    print(selectedDistrict);
                  },
                  items: district.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: Name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Address,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    labelText: 'Address',
                    hintText: 'Enter Your Address'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 0),
              child: DropdownButton<String>(
                value: dropdownValue2,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                hint: const Text("Select Timber "),
                /*underline: Container(
                           height: 2,
                           color: Colors.grey,
                         ),*/
                onChanged: (String? data) {
                  setState(() {
                    dropdownValue2 = data!;
                    selectedPRoof = dropdownValue2;
                  });
                  print(selectedPRoof);
                },
                items: IdProof.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: quntity,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    labelText: 'Quantity',
                    hintText: 'Enter Required Number of timber'),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Visibility(
              visible: isShow,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                strokeWidth: 8,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                onPressed: () async {
                  if ((Name.text == null)) {
                    Fluttertoast.showToast(
                        msg: "Please select and fill all Field",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 4,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else {
                    setState(() {
                      isShow = true;
                    });
                    const String url =
                        'https://timber.forest.kerala.gov.in/api/auth/Add_Requirement';
                    Map data = {
                      "id": userId,
                      "name": Name.text,
                      "address": Address.text,
                      "phone": number.text,
                      "timber_name": dropdownValue2.toString(),
                      "division": dropdownValue.toString(),
                      "dist": selectedDistrict.toString(),
                      "quantity": quntity.text
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
                    print("----------------From Submit-----------------------");
                    print(responseJson);
                    if (responseJson['message'] != "Data Saved Successfully.") {
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

                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 250),
                            transitionsBuilder:
                                (context, animation, animationTime, child) {
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
            )
          ]),
        ));
  }
}
