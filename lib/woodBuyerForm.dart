import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/login.dart';
import 'package:tigramnks/login.dart';
import 'package:tigramnks/tigramWoodShed.dart';

import 'login.dart';

class woodBuyerForm extends StatefulWidget {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  String userCato;
  woodBuyerForm(
      {super.key,
      required this.userId,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userCato});
  @override
  State<woodBuyerForm> createState() =>
      _woodBuyerFormState(userId, sessionToken, userName, userEmail, userCato);
}

class _woodBuyerFormState extends State<woodBuyerForm> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  String userCato;
  _woodBuyerFormState(this.userId, this.sessionToken, this.userName,
      this.userEmail, this.userCato);
  String? dropdownValue2;
  String holder = '';
  List<String> IdProof = [
    'Individual',
    'Firm',
  ];
  TextEditingController orgName = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController gstNo = TextEditingController();
  TextEditingController cinNo = TextEditingController();
  TextEditingController tanNo = TextEditingController();
  TextEditingController serviceTax = TextEditingController();
  TextEditingController webSite = TextEditingController();
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Buyer Form"),

          //backgroundColor: Colors.blueGrey,
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
                        text: "User Type",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ]),
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
                  hint: const Text("Select User Type"),
                  /*underline: Container(
                           height: 2,
                           color: Colors.grey,
                         ),*/
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValue2 = data!;
                    });
                    print(dropdownValue2);
                  },
                  items: IdProof.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: orgName,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'Organization Name',
                          hintText: 'Enter Organization Name'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: panNo,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'PAN',
                          hintText: 'Enter PAN Number'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: gstNo,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'GST No(if any)',
                          hintText: 'GST No(if any)'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: cinNo,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'CIN No(if any)',
                          hintText: 'CIN No(if any)'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: tanNo,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'TAN No(if any)',
                          hintText: 'TAN No(if any)'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: serviceTax,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'Service Tax (if any)',
                          hintText: 'Service Tax(if any)'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: dropdownValue2 == "Firm",
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                      controller: webSite,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'Website (if any)',
                          hintText: 'Website (if any)'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
              ),
              Visibility(
                visible: isShow,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 8,
                ),
              ),
              Row(children: <Widget>[
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 0.0,
                  ),
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: () async {
                      print(orgName.text);
                      print(sessionToken);
                      if ((dropdownValue2 == null)) {
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
                            'https://timber.forest.kerala.gov.in/api/auth/Firm_Registration';
                        Map data = {
                          "id": userId,
                          "organization": orgName.text,
                          "pan_card": panNo.text,
                          "gst": gstNo.text,
                          "cin_number": cinNo.text,
                          "tan_number": tanNo.text,
                          "website": webSite.text,
                          "service_tax": serviceTax.text
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

                        print(userCato);
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
                          userCato = dropdownValue2!;
                          print(userCato);
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
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return tigramWoodShed(
                                      userId: userId,
                                      sessionToken: sessionToken,
                                      userName: userName,
                                      userEmail: userEmail,
                                      userCato: userCato);
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
                const Spacer(),
              ])
            ])));
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
