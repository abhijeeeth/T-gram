// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/DivisionViewReport.dart';

class DivisionReport extends StatefulWidget {
  final String? sessionToken;
  final List<String>? userRange;
  const DivisionReport({super.key, this.sessionToken, this.userRange});
  @override
  _DivisionReportState createState() =>
      _DivisionReportState(sessionToken, userRange);
}

class _DivisionReportState extends State<DivisionReport> {
  String? sessionToken;
  List<String>? userRange;
  _DivisionReportState(this.sessionToken, this.userRange);

  String? SelectedRange; // Change to nullable String and initialize as null

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List of Reports'),

          // backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [
            DropdownButton<String>(
              value: SelectedRange,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 18),
              hint: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: "Select Range",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
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
                  SelectedRange = data!;
                });
                print(SelectedRange);
              },
              items: userRange
                  ?.toSet()
                  .toList()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
          // automaticallyImplyLeading: false,
        ),
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 1), //<---- Insert Gradient Here
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
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                      title:
                          const Text('Application Received/Approved/Rejected'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R1 = 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R1: R1,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Reason For Rejection'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R2 = 2;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R2: R2,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Species-wise Volume & Tree Transport'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R3 = 3;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R3: R3,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Volume & No. of tree Transported'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R4 = 4;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R4: R4,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text(
                          'Species wise Total volume transported & Total  No of trees transported to each destination'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R5 = 5;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R5: R5,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text(
                          'Total volume transported to each destination'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R6 = 6;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R6: R6,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Time takes for application'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R7 = 7;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R7: R7,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Reason for cutting'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R8 = 8;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R8: R8,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text(
                          'Number of Application received before & after cutting the tree'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R9 = 9;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R9: R9,
                                    )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('NOC Report'),
                      onTap: () {
                        if (SelectedRange == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a range first'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        int R10 = 10;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DivisionViewReport(
                                      sessionToken: sessionToken ?? "",
                                      SelectedRange: SelectedRange,
                                      R10: R10,
                                    )));
                      }),
                  elevation: 3,
                ),
              ],
            )));
  }
}
