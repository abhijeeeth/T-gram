import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/login.dart';

class newPassword extends StatefulWidget {
  String userId;
  newPassword({super.key, required this.userId});
  @override
  _newPasswordState createState() => _newPasswordState(userId);
}

class _newPasswordState extends State<newPassword> {
  String userId;
  TextEditingController Password = TextEditingController();
  TextEditingController Re_Password = TextEditingController();
  _newPasswordState(this.userId);
  bool isHiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                  image: AssetImage('assets/images/Logo.png'),
                  fit: BoxFit.cover)),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            border: Border.all(color: Colors.lightGreenAccent, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),
          margin:
              const EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 15),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 10),
          child: Column(
            children: <Widget>[
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: Password,
                  obscureText: isHiddenPassword,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: const Icon(Icons.visibility,
                              color: Colors.black54)),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: Re_Password,
                  obscureText: isHiddenPassword,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              print("hi...");
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: const Icon(Icons.visibility,
                              color: Colors.black54)),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      labelText: 'Re-Password',
                      hintText: 'Repeat Password'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    // color: Colors.amber,
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if ((Password.text.isEmpty) ||
                          (Re_Password.text.isEmpty)) {
                        Fluttertoast.showToast(
                            msg: 'Password Feild is Empty',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      } else if ((Password.text) != (Re_Password.text)) {
                        Fluttertoast.showToast(
                            msg: 'Please Enter Password & Re-password Same',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      } else {
                        const String url =
                            'https://f4020lwv-8000.inc1.devtunnels.ms//api/auth/changepassword';
                        Map data = {
                          "phone": userId,
                          "passwd": Password.text,
                          "passwd1": Re_Password.text,
                        };
                        print(data);
                        var body = json.encode(data);
                        print(body);
                        final response = await http.post(Uri.parse(url),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: body);
                        print(response);
                        Map<String, dynamic> responseJson =
                            json.decode(response.body);
                        print(
                            "----------------------New Password----------------");
                        print(responseJson);
                        if (responseJson['status'] == 'Success') {
                          Fluttertoast.showToast(
                              msg: responseJson['message'].toString(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => newPassword(
                                        userId: userId,
                                      )));
                        }
                      }
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => login()));
                    }),
              ),
            ],
          ),
        )
      ])),
    );
  }
}
