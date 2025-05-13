// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'QueryPage.dart';
import 'QueryPageCheck.dart';
import 'ViewApplication.dart';
import 'login.dart';
import 'package:url_launcher/url_launcher.dart';

class checkPost extends StatefulWidget {
  int? userId;
  String? userName;
  String? userEmail;
  String? sessionToken;
  String? userGroup;
  String? dropdownValue;
  String? userMobile;
  String? userAddress;
  String? userProfile;
  checkPost(
      {super.key,
      this.userId,
      this.userName,
      this.userEmail,
      this.sessionToken,
      this.userGroup,
      this.dropdownValue,
      this.userMobile,
      this.userProfile,
      this.userAddress});

  @override
  State<checkPost> createState() => _checkPostState(
      userId,
      userName,
      userEmail,
      sessionToken,
      userGroup,
      dropdownValue,
      userMobile,
      userProfile,
      userProfile);
}

class _checkPostState extends State<checkPost> {
  @override
  void initState() {
    super.initState();
    ScanApp();
    print(userId);
  }

  int? userId;
  String? userName;
  String? userEmail;
  String? sessionToken;
  String? userGroup;
  String? dropdownValue;
  String? userMobile;
  String? userAddress;
  String? userProfile;
  _checkPostState(
      this.userId,
      this.userName,
      this.userEmail,
      this.sessionToken,
      this.userGroup,
      this.dropdownValue,
      this.userMobile,
      this.userProfile,
      this.userAddress);
  final List sr = [];
  final List Ids = [];
  final List Check_officer_id = [];
  final List App_no = [];

  //------------------------

  List list1 = [];
  int allApplication = 0;
//-----------Approved------------------------
  int allApplication1 = 0;
  final List Ids1 = [];
  final List sr1 = [];
  final List App_no1 = [];

  void ScanApp() async {
    sr.clear();
    Check_officer_id.clear();
    App_no.clear();

    print("Scanning Application");
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/ScanedListApplication';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    List list = responseJSON["data"];
    setState(() {
      allApplication = list.length;
    });
    for (var i = 0; i < allApplication; i++) {
      sr.add(i.toString());
      App_no.add(list[i]['app_form_id'].toString());
      Check_officer_id.add(list[i]["checkpost_officer_id"].toString());
      // App_no.add(list[i]['app_form_id'].toString());
    }
  }

  final int _radioValue = 0;
  bool flag = true;
  var tab = 0;
  @override
  // void _handleRadioValueChange(int value) async {
  //   setState(() {
  //     _radioValue = value;
  //     if (_radioValue == 0) {
  //       setState(() {
  //         tab = 0;
  //         flag = true;
  //         ScanApp();
  //       });
  //     } else if (_radioValue == 1) {
  //       setState(() {
  //         tab = 1;
  //         flag = false;
  //         // NocForm();
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Check Post DashBoard"),

        //backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
        ),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.deepOrangeAccent,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 10),
              padding:
                  const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
              child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 15,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Scrollbar(
                          thumbVisibility: true,
                          thickness: 15,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columnSpacing: 20,
                                dividerThickness: 2,
                                headingRowColor: WidgetStateColor.resolveWith(
                                    (states) => Colors.orange),
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'S.No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                      label: Text(
                                    'Application\n       No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' View \n details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Download\n Report',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'QR Code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Location',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ],
                                rows:
                                    sr // Loops through dataColumnText, each iteration assigning the value to element
                                        .map(
                                          ((value) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell((Text((int.parse(
                                                              value) +
                                                          1)
                                                      .toString()))), //Extracting from Map element the value
                                                  DataCell(Text(
                                                      App_no[int.parse(value)]
                                                          .toString())),

                                                  DataCell(
                                                    Visibility(
                                                      visible: true,
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons.visibility),
                                                        color: Colors.blue,
                                                        onPressed: () {
                                                          if (userGroup ==
                                                              userGroup) {
                                                            String IDS = App_no[
                                                                    int.parse(
                                                                        value)]
                                                                .toString();
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        ViewApplication(
                                                                          sessionToken:
                                                                              sessionToken ?? "",
                                                                          userGroup:
                                                                              userGroup ?? "",
                                                                          userId:
                                                                              userId ?? 0,
                                                                          Ids:
                                                                              IDS,
                                                                          Range: const [],
                                                                          userName:
                                                                              userName ?? "",
                                                                          userEmail:
                                                                              userEmail ?? "",
                                                                        )));
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Visibility(
                                                      visible: true,
                                                      child: IconButton(
                                                        icon: Icon(Icons
                                                            .file_download),
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          await launch(
                                                              "${"https://timber.forest.kerala.gov.in/api/auth/new_transit_pass_pdf/" + App_no[int.parse(value)]}/");
                                                          // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  // DataCell(
                                                  //   IconButton(
                                                  //     icon: new Icon(
                                                  //         Icons.file_download),
                                                  //     color: Colors.blue,
                                                  //     onPressed: () async {
                                                  //       await launch(
                                                  //           "https://timber.forest.kerala.gov.in/api/auth/new_user_report/" +
                                                  //               Ids[int.parse(
                                                  //                   value)] +
                                                  //               "/");
                                                  //       // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                  //     },
                                                  //   ),
                                                  // ),

                                                  DataCell(
                                                    Visibility(
                                                      visible: true,
                                                      child: IconButton(
                                                        icon: Icon(Icons
                                                            .qr_code_outlined),
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          await launch(
                                                              "${"https://timber.forest.kerala.gov.in/api/auth/qr_code_pdf/" + App_no[int.parse(value)]}/");
                                                          // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Visibility(
                                                      child: IconButton(
                                                        icon: Icon(Icons
                                                            .file_download),
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          await launch(
                                                              "${"https://timber.forest.kerala.gov.inapp/location_views/" + App_no[int.parse(value)]}/");
                                                          // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )
                                        .toList(),
                              ))))));
        }),
      ])),
      drawer: Container(
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor("#26f596"), HexColor("#0499f2")]),
                  ),
                  accountEmail: Text('$userEmail'),
                  accountName: Text("$userName"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      userName != null && userName!.isNotEmpty
                          ? userName![0].toUpperCase()
                          : 'U',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => checkPost(
                                    sessionToken: sessionToken,
                                    userName: userName,
                                    userEmail: userEmail,
                                    userGroup: userGroup,
                                  )));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'QR-Scanner',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => queryPage(
                                    userId: userId ?? 0,
                                    sessionToken: sessionToken ?? "",
                                    userName: userName ?? "",
                                    userEmail: userEmail ?? "",
                                    userAddress: userAddress ?? "",
                                    userGroup: userGroup ?? "",
                                    userMobile: '',
                                  )));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () async {
                      const String url =
                          'https://timber.forest.kerala.gov.in/api/auth/logout/';
                      await http.post(
                        Uri.parse(url),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Authorization': "token $sessionToken"
                        },
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('isLoggedIn');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => login()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
