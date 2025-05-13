// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/ViewReports.dart';

class Reports extends StatefulWidget {
  String? sessionToken; // Made nullable
  Reports({super.key, this.sessionToken});
  @override
  _ReportsState createState() => _ReportsState(sessionToken);
}

class _ReportsState extends State<Reports> {
  String? sessionToken; // Made nullable
  _ReportsState(this.sessionToken);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Reports'),

          // backgroundColor: Colors.blueGrey,
          elevation: 0,
          //automaticallyImplyLeading: false,
        ),
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 1), //<---- Insert Gradient Here
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            margin:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
            child: ListView(
              children: <Widget>[
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Application Received/Approved/Rejected'),
                      onTap: () {
                        int R1 = 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: R1,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Reason For Rejection'),
                      onTap: () {
                        int R2 = 2;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: R2,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Species-wise Volume & Tree Transport'),
                      onTap: () {
                        int R3 = 3;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: R3,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Volume & No. of tree Transported'),
                      onTap: () {
                        int R4 = 4;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: R4,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text(
                          'Species wise Total volume transported & Total  No of trees transported to each destination'),
                      onTap: () {
                        int R5 = 5;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: R5,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title:
                          Text('Total volume transported to each destination'),
                      onTap: () {
                        int R6 = 6;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: R6,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Time takes for application'),
                      onTap: () {
                        int R7 = 7;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: R7,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Reason for cutting'),
                      onTap: () {
                        int R8 = 8;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: R8,
                                      R9: 0,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text(
                          'Number of Application received before & after cutting the tree'),
                      onTap: () {
                        int R9 = 9;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: R9,
                                      R10: 0,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('NOC Report'),
                      onTap: () {
                        int R10 = 10;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: R10,
                                      R11: 0,
                                    )));
                      }),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                      title: Text('Timber Tracking'),
                      onTap: () {
                        int R11 = 11;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ViewReports(
                                      sessionToken: sessionToken ?? '',
                                      R1: 0,
                                      R2: 0,
                                      R3: 0,
                                      R4: 0,
                                      R5: 0,
                                      R6: 0,
                                      R7: 0,
                                      R8: 0,
                                      R9: 0,
                                      R10: 0,
                                      R11: R11,
                                    )));
                      }),
                ),
              ],
            )));
  }
}
