import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tigramnks/Form2Page1.dart';
import 'package:tigramnks/TransitPass.dart';
import 'package:tigramnks/sqflite/localdataForms.dart';

class TransitForms extends StatefulWidget {
  String? sessionToken;
  String? userName;
  String? userEmail;
  int? userId;

  TransitForms(
      {super.key,
      this.sessionToken,
      this.userName,
      this.userEmail,
      this.userId});

  @override
  _TransitFormsState createState() =>
      _TransitFormsState(sessionToken, userName, userEmail, userId);
}

class _TransitFormsState extends State<TransitForms> {
  String? sessionToken;
  String? userName;
  String? userEmail;
  int? userId;
  _TransitFormsState(
      this.sessionToken, this.userName, this.userEmail, this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forms'),

        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,MaterialPageRoute(builder: (_) => TransitPass(
                //   sessionToken:sessionToken,
                //   userName:userName,
                //   userEmail:userEmail,
                // ))
                // );
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TransitPass(
                            sessionToken: sessionToken ?? '',
                            userName: userName ?? '',
                            userEmail: userEmail ?? '',
                            userId: userId ?? 0,
                            formOneIndex: 0)));
              },
              child: Container(
                  // width: 310,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(
                      top: 25.0, left: 20, right: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#36d1dc"), HexColor("#5b86e5")]),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/apply_icon.png',
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        'FORM - I',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        '( Transit Pass For  Non-Notified Villages )',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ])),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Form2Page1(
                            sessionToken: sessionToken ?? '',
                            userName: userName ?? '',
                            userEmail: userEmail ?? '',
                            userId: userId ?? 0)));
              },
              child: Container(
                  // width: 310,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(
                      top: 5, left: 20, right: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#4568dc"), HexColor("b06ab3")]),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/apply_icon.png',
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        'FORM - II',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        '( Transit Pass For Notified Villages )',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ])),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => localdataForms(
                            sessionToken: sessionToken ?? '',
                            userName: userName ?? '',
                            userEmail: userEmail ?? '',
                            userId: userId ?? 0)));
              },
              child: Container(
                  // width: 310,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(
                      top: 25.0, left: 20, right: 20, bottom: 20.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#36d1dc"), HexColor("#5b86e5")]),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/apply_icon.png',
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        'local data forms',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        '( update or delete forms )',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
