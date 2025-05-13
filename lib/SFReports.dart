// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class SFReports extends StatefulWidget {
  String sessionToken;
  List<String> Dist;
  List<String> Range;
  SFReports(
      {super.key,
      required this.sessionToken,
      required this.Dist,
      required this.Range});
  @override
  _SFReportsState createState() => _SFReportsState(sessionToken, Dist, Range);
}

class _SFReportsState extends State<SFReports> {
  String sessionToken;
  List<String> Dist;
  List<String> Range;
  _SFReportsState(this.sessionToken, this.Dist, this.Range);

  String? SelectedRange;
  String? SelectedRange1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List of Reports'),
          elevation: 0,
        ),
        body: Container(
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,//<---- Insert Gradient Here
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),*/
            margin: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            padding:
                const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
            child: ListView(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      top: 0, left: 10, right: 10, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: SelectedRange,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hint: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text: "Select Range",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: " * ",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14,
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
                        },
                        items: Range.toSet()
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: SelectedRange1,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hint: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text: "Selected Division",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " * ",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14,
                                )),
                          ]),
                        ),
                        /*underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),*/
                        onChanged: (String? data) {
                          setState(() {
                            SelectedRange1 = data!;
                          });
                        },
                        items: Dist.toSet()
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: ListTile(
                      title:
                          const Text('Application Received/Approved/Rejected'),
                      onTap: () {
                        int R1 = 1;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: R1,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Pending Application'),
                      onTap: () {
                        int R2 = 2;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: R2,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Approved Application'),
                      onTap: () {
                        int R3 = 3;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: R3,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Rejected Application'),
                      onTap: () {
                        int R4 = 4;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: R4,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Forward Application'),
                      onTap: () {
                        int R5 = 5;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: R5,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Cutting Permission'),
                      onTap: () {
                        int R6 = 6;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: R6,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Time takes for application'),
                      onTap: () {
                        int R7 = 7;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: R7,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('Reason for cutting'),
                      onTap: () {
                        int R8 = 8;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: R8,
                        //               R9: 0,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text(
                          'Number of Application received before & after cutting the tree'),
                      onTap: () {
                        int R9 = 9;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: R9,
                        //               R10: 0,
                        //             )));
                      }),
                  elevation: 3,
                ),
                Card(
                  child: ListTile(
                      title: const Text('NOC Report'),
                      onTap: () {
                        int R10 = 10;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => SFViewReports(
                        //               sessionToken: sessionToken,
                        //               SelectedRange: SelectedRange!,
                        //               SelectedRange1: SelectedRange1!,
                        //               R1: 0,
                        //               R2: 0,
                        //               R3: 0,
                        //               R4: 0,
                        //               R5: 0,
                        //               R6: 0,
                        //               R7: 0,
                        //               R8: 0,
                        //               R9: 0,
                        //               R10: R10,
                        //             )));
                      }),
                  elevation: 3,
                ),
              ],
            )));
  }
}
