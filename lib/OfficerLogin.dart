import 'package:flutter/material.dart';

import "package:flutter/cupertino.dart";

import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/OfficerDashboard.dart';

import 'main.dart';

class OfficerLogin extends StatefulWidget {
  const OfficerLogin({super.key});

  @override
  _OfficerLoginState createState() => _OfficerLoginState();
}

class _OfficerLoginState extends State<OfficerLogin> {
  bool isHiddenPassword = true;

  String sessionToken = '';
  String userName = '';
  String userEmail = '';

  TextEditingController loginMobile = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(" Officer Login"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/Logo.jpg')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: loginEmail,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Officer ID',
                    hintText: 'Enter valid ID'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: isHiddenPassword,
                controller: loginPassword,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isHiddenPassword = !isHiddenPassword;
                          });
                        },
                        child: const Icon(Icons.visibility,
                            color: Colors.black54)),
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.only(top: 20.0),
              child: TextButton(
                onPressed: () {
                  if ((loginEmail.text.isEmpty) ||
                      (loginPassword.text.isEmpty)) {
                    Fluttertoast.showToast(
                        msg: "Either email or password field is empty",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (!validateEmail(loginEmail.text)) {
                    Fluttertoast.showToast(
                        msg: "Invalid email address",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OfficerDashboard(
                                    userId: 123, // example integer value
                                    userName: userName,
                                    userEmail: userEmail,
                                    sessionToken: sessionToken,
                                    userGroup: 'someUserGroup',
                                    dropdownValue: 'someDropdownValue',
                                    Range: const [
                                      'someRange'
                                    ] // example list of dynamic values
                                    )));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
