import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigramnks/CheckPassStatus.dart';
import 'package:tigramnks/Help.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNonNot.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNotified.dart';
import 'package:tigramnks/NEW_FORMS/transitView.dart';
import 'package:tigramnks/Profile.dart';
import 'package:tigramnks/QueryPage.dart';
import 'package:tigramnks/itgramWoodBuy.dart';
import 'package:tigramnks/login.dart';
import 'package:tigramnks/tigramWoodShed.dart';
import 'package:tigramnks/woodBuyerForm.dart';

class VillageData {
  final int id;
  final String villageName;
  final bool isNotified;

  VillageData({
    required this.id,
    required this.villageName,
    required this.isNotified,
  });

  factory VillageData.fromJson(Map<String, dynamic> json) {
    return VillageData(
      id: json['id'],
      villageName: json['village_name'],
      isNotified: json['is_notified'],
    );
  }
}

class HomePage extends StatefulWidget {
  final String sessionToken;
  final int userId;
  final String userName;
  final String userMobile;
  final String userEmail;
  final String userAddress;
  final String userProfile;
  final String userGroup;
  final String userCato;
  const HomePage(
      {super.key,
      required this.sessionToken,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.userMobile,
      required this.userAddress,
      required this.userProfile,
      required this.userGroup,
      required this.userCato});

  @override
  _HomePageState createState() => _HomePageState(sessionToken, userId, userName,
      userEmail, userMobile, userAddress, userProfile, userGroup, userCato);
}

class _HomePageState extends State<HomePage> {
  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userMobile;
  String userAddress;
  String userProfile;
  String userGroup;
  String userCato;
  _HomePageState(
      this.sessionToken,
      this.userId,
      this.userName,
      this.userEmail,
      this.userMobile,
      this.userAddress,
      this.userProfile,
      this.userGroup,
      this.userCato);

  final bool _showPopup = false;
  // Future<bool> _onBackPressedDialog() async {
  //   final bool result = await showDialog<bool>(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Select the User type'),
  //           content: const Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               // ... your existing dialog content ...
  //             ],
  //           ),
  //           actions: [
  //             ElevatedButton(
  //               child: const Text("cancel"),
  //               onPressed: () {
  //                 Navigator.of(context).pop(false);
  //               },
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false;
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TIGRAM"),

          //backgroundColor: Colors.blueGrey,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return YourDialog(
                //             sessionToken: sessionToken,
                //             userId: userId,
                //             userName: userName,
                //             userMail: userEmail,
                //             userGroup: userGroup);
                //       },
                //     );
                //   },
                //   child: Container(
                //       // width: 310,
                //       width: double.infinity,
                //       height: MediaQuery.of(context).size.height * 0.25,
                //       margin: const EdgeInsets.only(
                //           top: 25.0, left: 20, right: 20, bottom: 20.0),
                //       decoration: BoxDecoration(
                //           color: Colors.blue,
                //           boxShadow: const [
                //             BoxShadow(
                //               color: Colors.black,
                //               blurRadius: 2.0,
                //               spreadRadius: 0.0,
                //               offset: Offset(
                //                   2.0, 2.0), // shadow direction: bottom right
                //             )
                //           ],
                //           borderRadius: BorderRadius.circular(20)),
                //       child: Column(children: <Widget>[
                //         Container(
                //           child: Image.asset(
                //             'assets/images/apply_icon.png',
                //             height: MediaQuery.of(context).size.height * 0.12,
                //           ),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(top: 15.0),
                //           child: const Text(
                //             'Apply for Cutting / \nTransit Pass',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 22),
                //           ),
                //         ),
                //       ])),
                // ),

                // InkWell(
                //   splashColor: Colors.white70,
                //   onTap: () async {
                //     await Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (_) => sandalwoodForm(
                //             sessionToken: sessionToken,
                //             userName: userName,
                //             userEmail: userEmail,
                //             userGroup: userGroup,
                //             userId: userId),
                //       ),
                //     );
                //   },
                //   hoverColor: Colors.blueGrey,
                //   child: Container(
                //       width: double.infinity,
                //       height: MediaQuery.of(context).size.height * 0.25,
                //       margin: const EdgeInsets.only(
                //           top: 8, left: 20, right: 20, bottom: 20.0),
                //       decoration: BoxDecoration(
                //           color: const Color.fromARGB(255, 173, 126, 72),
                //           boxShadow: const [
                //             BoxShadow(
                //               color: Colors.black,
                //               blurRadius: 2.0,
                //               spreadRadius: 0.0,
                //               offset: Offset(
                //                   2.0, 2.0), // shadow direction: bottom right
                //             )
                //           ],
                //           borderRadius: BorderRadius.circular(20)),
                //       child: Column(children: <Widget>[
                //         Image.asset(
                //           'assets/images/apply_icon.png',
                //           height: MediaQuery.of(context).size.height * 0.12,
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(top: 15.0),
                //           child: const Text(
                //             'Apply for cutting \nSandalwood',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 22),
                //           ),
                //         )
                //       ])),
                // ),
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Lottie.asset(
                        'assets/tree.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: const Text(
                        'Welcome to TIGRAM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckPassStatus(
                            sessionToken: sessionToken,
                            userName: userName,
                            userEmail: userEmail,
                            userGroup: userGroup,
                            userId: userId),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height / 12,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 28, 110, 99),
                          Color.fromARGB(207, 28, 110, 99),
                          Color.fromARGB(195, 105, 138, 132)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/images/check_status.png',
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Check Pass Status',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),

                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (_) => NocForm(
                //               sessionToken: sessionToken,
                //               userName: userName,
                //               userEmail: userEmail,
                //               userId: userId),
                //         ),
                //       );

                //       // Navigator.pushReplacement(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (_) => NocForm(
                //       //             sessionToken: sessionToken,
                //       //             userName: userName,
                //       //             userEmail: userEmail,
                //       //             userId: userId)));
                //     },
                //     hoverColor: Colors.blueGrey,
                //     child: Container(
                //         width: double.infinity,
                //         height: MediaQuery.of(context).size.height * 0.25,
                //         margin: const EdgeInsets.only(
                //             top: 8.0, left: 20, right: 20, bottom: 20.0),
                //         decoration: BoxDecoration(
                //             color: Colors.orange,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black,
                //                 blurRadius: 2.0,
                //                 spreadRadius: 0.0,
                //                 offset: Offset(
                //                     2.0, 2.0), // shadow direction: bottom right
                //               )
                //             ],
                //             borderRadius: BorderRadius.circular(20)),
                //         child: Column(children: <Widget>[
                //           Container(
                //             child: Icon(
                //               Icons.sticky_note_2,
                //               size: MediaQuery.of(context).size.height * 0.12,
                //               color: Colors.white,
                //             ),
                //             /*child:new Image.asset(
                //                 'assets/images/question_icon.png',
                //                 height: 125,
                //               ),*/
                //           ),
                //           Container(
                //             margin: const EdgeInsets.only(top: 15.0),
                //             child: Text(
                //               'NOC For Exempted Species',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 22),
                //             ),
                //           ),
                //         ]))),
                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (_) => acknowUser(
                //             userId: userId,
                //             sessionToken: sessionToken,
                //             userName: userName,
                //             userEmail: userEmail,
                //             userGroup: userGroup,
                //           ),
                //         ),
                //       );
                //     },
                //     hoverColor: Color.fromARGB(255, 26, 189, 17),
                //     child: Container(
                //         width: double.infinity,
                //         height: MediaQuery.of(context).size.height * 0.25,
                //         margin: const EdgeInsets.only(
                //             top: 8.0, left: 20, right: 20, bottom: 20.0),
                //         decoration: BoxDecoration(
                //             color: Color.fromARGB(255, 185, 30, 144),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black,
                //                 blurRadius: 2.0,
                //                 spreadRadius: 0.0,
                //                 offset: Offset(
                //                     2.0, 2.0), // shadow direction: bottom right
                //               )
                //             ],
                //             borderRadius: BorderRadius.circular(20)),
                //         child: Column(children: <Widget>[
                //           Container(
                //             child: Icon(
                //               Icons.ads_click_outlined,
                //               size: MediaQuery.of(context).size.height * 0.12,
                //               color: Colors.white,
                //             ),
                //             /*child:new Image.asset(
                //                 'assets/images/question_icon.png',
                //                 height: 125,
                //               ),*/
                //           ),
                //           Container(
                //             margin: const EdgeInsets.only(top: 15.0),
                //             child: Text(
                //               'My Acknowledgement',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 22),
                //             ),
                //           ),
                //         ]))),
                // InkWell(
                //     onTap: selectType,
                //     hoverColor: Colors.blueGrey,
                //     child: Container(
                //         width: double.infinity,
                //         height: MediaQuery.of(context).size.height * 0.25,
                //         margin: const EdgeInsets.only(
                //             top: 8.0, left: 20, right: 20, bottom: 20.0),
                //         decoration: BoxDecoration(
                //             color: const Color.fromARGB(255, 15, 143, 55),
                //             boxShadow: const [
                //               BoxShadow(
                //                 color: Colors.black,
                //                 blurRadius: 2.0,
                //                 spreadRadius: 0.0,
                //                 offset: Offset(
                //                     2.0, 2.0), // shadow direction: bottom right
                //               )
                //             ],
                //             borderRadius: BorderRadius.circular(20)),
                //         child: Column(children: <Widget>[
                //           Container(
                //             child: Icon(
                //               Icons.sell,
                //               size: MediaQuery.of(context).size.height * 0.12,
                //               color: Colors.white,
                //             ),
                //             /*child:new Image.asset(
                //             'assets/images/question_icon.png',
                //             height: 125,
                //           ),*/
                //           ),
                //           Container(
                //             margin: const EdgeInsets.only(top: 15.0),
                //             child: const Text(
                //               'Tigram Woodshed',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 22),
                //             ),
                //           ),
                //         ]))),
              ])),
        ),
        drawer: Container(
          child: Drawer(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor("#26f596"), HexColor("#0499f2")]),
                    ),
                    accountEmail: Text(userEmail),
                    accountName: Text(userName),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        userName[0].toUpperCase(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.perm_identity,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Profile(
                                    sessionToken: sessionToken,
                                    userName: userName,
                                    userEmail: userEmail,
                                    userMobile: userMobile,
                                    userAddress: userAddress,
                                    userProfile: userProfile)));
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.dashboard,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: const Text(
                        'Dashboard',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomePage(
                                      sessionToken: sessionToken,
                                      userName: userName,
                                      userEmail: userEmail,
                                      userMobile: userMobile,
                                      userAddress: userAddress,
                                      userProfile: userProfile,
                                      userGroup: userGroup,
                                      userId: userId,
                                      userCato: userCato,
                                    )));
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: const Text(
                        'QR-Scanner',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QueryPage(
                                      sessionToken: sessionToken,
                                      userId: userId,
                                      userName: userName,
                                      userEmail: userEmail,
                                      userMobile: userMobile,
                                      userAddress: userAddress,
                                    )));
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.help,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: const Text(
                        'Help',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const Help()));
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: const Text(
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
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => login()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String usertCat = "";
  void selectType() async {
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/check_usr_category';
    Map data = {"id": userId};

    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);

    Map<String, dynamic> responseJson = json.decode(response.body);
    setState(() {
      usertCat = responseJson["data"][0]["usr_category"];
    });

    if (usertCat == "no_data") {
      _onBackPressed();
    } else if (usertCat == "individual" || usertCat == "firm") {
      _onBackPressed();
    }
  }

  Future<bool> _onBackPressed() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select the User type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: usertCat.contains("no_data"),
              child: ListTile(
                // leading: Icon(Icons.box),
                title: const Text("Buyer"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => woodBuyerForm(
                              userId: userId,
                              sessionToken: sessionToken,
                              userName: userName,
                              userEmail: userEmail,
                              userCato: "buyer")));
                },
              ),
            ),
            const Divider(),
            Visibility(
              visible: usertCat != "no_data",
              child: ListTile(
                // leading: Icon(Icons.check_box),
                title: const Text("Buyer"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => tigramWoodBuy(
                                userId: userId,
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userEmail,
                                userCato: "buyer",
                              )));
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text("Seller"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => tigramWoodShed(
                            userId: userId,
                            sessionToken: sessionToken,
                            userName: userName,
                            userEmail: userEmail,
                            userCato: "")));
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class YourDialog extends StatefulWidget {
  final String sessionToken;
  final int userId;
  final String userName;
  final String userMail;
  final String userGroup;

  const YourDialog({
    super.key,
    required this.sessionToken,
    required this.userId,
    required this.userName,
    required this.userMail,
    required this.userGroup,
  });
  @override
  _YourDialogState createState() =>
      _YourDialogState(sessionToken, userName, userMail, userId, userGroup);
}

class _YourDialogState extends State<YourDialog> {
  String sessionToken;
  String userName;
  String userMail;
  int userId;
  String userGroup;

  List<VillageData> villages = [];
  final bool _showPopup = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String CuttingId = "";
  _YourDialogState(this.sessionToken, this.userName, this.userMail, this.userId,
      this.userGroup);

  final TextEditingController _searchController = TextEditingController();
  String _selectedVillage = '';
  int _selectedVillageId = 0;
  late bool _isNotified;
  List<String> _suggestions = [];
  String _selectedForm = '';
  String _selectedField = '';
  String _speciasContain = "";

  bool _showTextField = false;
  bool _showTextField_C = false;
  bool _showSpecias = false;
  final List<String> speciasTextList = [
    "Coconut",
    "Rubber",
    "Cashew",
    "Tamarind",
    "Mango",
    "Jack Fruit Tree",
    "Kodampuli",
    "Matti",
    "Arecanut",
    "Konna",
    "Seema Konna",
    "Nelli",
    "Neem",
    "Murukku",
    "Jathi",
    "Albezia",
    "Silk Cotton",
    "Acacia auraculiformis",
    "Mangium",
    "Anhili",
    "Kilimaram",
    "Manchadimaram",
    "Vatta",
    "Palm tree",
    "Aranamaram",
    "Eucalyptus",
    "Seemaplavu",
    "Paala"
  ];
  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to go Home page'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("NO"),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FORM SELECTION'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Set your preferred border color
                width: 3.0, // Set the border width
              ),
              borderRadius: BorderRadius.circular(8.0), // Set border radius
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RadioListTile(
                  title: const Text('Cutting Permission'),
                  value: 'cutting',
                  groupValue: _selectedForm,
                  onChanged: (value) {
                    setState(() {
                      _selectedForm = value!;
                      print(_selectedForm);
                      _showTextField = false;
                      _showTextField_C = true;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Transit Pass'),
                  value: 'transit',
                  groupValue: _selectedForm,
                  onChanged: (value) {
                    setState(() {
                      _selectedForm = value!;
                      print(_selectedForm);
                      _showTextField = true;
                      _showTextField_C = false;
                    });
                  },
                ),
                const SizedBox(height: 18),
                if (_showTextField_C)
                  Column(
                    children: [
                      const Text(
                          " Whether your land falls under \nCardamom / Coffiee plantation ? "),
                      const SizedBox(height: 13),
                      // Row(
                      //   children: [
                      RadioListTile(
                        title: const Text('Yes'),
                        value: 'yes',
                        groupValue: _selectedField,
                        onChanged: (value) {
                          setState(() {
                            _selectedField = value!;
                            print(_selectedField);
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('No'),
                        value: 'no',
                        groupValue: _selectedField,
                        onChanged: (value) {
                          setState(() {
                            _selectedField = value!;
                            print(_selectedField);

                            // _showPopupMessageField(context);
                          });
                        },
                      ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(" Search and select your village "),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors
                                      .grey, // Set your preferred border color
                                  width: 2.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    8.0), // Set border radius
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _suggestions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_suggestions[index]),
                                    onTap: () {
                                      _searchController.text =
                                          _suggestions[index];
                                      _selectedVillage = _suggestions[index];
                                      final selectedVillageName =
                                          _suggestions[index];
                                      final selectedVillage =
                                          villages.firstWhere(
                                        (village) =>
                                            village.villageName ==
                                            selectedVillageName,
                                        orElse: () => VillageData(
                                            id: 0,
                                            villageName: '',
                                            isNotified: false),
                                      );

                                      setState(() {
                                        _searchController.text =
                                            selectedVillage.villageName;
                                        _selectedVillage =
                                            selectedVillage.villageName;
                                        _selectedVillageId = selectedVillage.id;
                                        _isNotified =
                                            selectedVillage.isNotified;
                                        _suggestions = []; // Clear suggestions

                                        print("isNot$_isNotified");
                                        if (_isNotified == false) {
                                          _showSpecias = false;
                                        } else if (_isNotified == true) {
                                          _showSpecias = true;
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _selectedVillage = '';
                                  _suggestions =
                                      getSuggestions(value, villages);
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search for a village...',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _showSuggestionsDialog(context, villages);
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      if (_showSpecias)
                        SizedBox(
                          height: 200,
                          child: SingleChildScrollView(
                            child: Column(
                              children: speciasTextList
                                  .map((text) => ListTile(title: Text(text)))
                                  .toList(),
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      if (_showSpecias)
                        const Text("Is your specias are in the above list ? "),
                      if (_showSpecias) const SizedBox(height: 13),
                      if (_showSpecias)
                        RadioListTile(
                          title: const Text('Yes'),
                          value: 'yes',
                          groupValue: _speciasContain,
                          onChanged: (value) {
                            setState(() {
                              _speciasContain = value!;
                              print(_speciasContain);
                              _showPopupMessage(context);
                            });
                          },
                        ),
                      if (_showSpecias)
                        RadioListTile(
                          title: const Text('No'),
                          value: 'no',
                          groupValue: _speciasContain,
                          onChanged: (value) {
                            setState(() {
                              _speciasContain = value!;
                              print(_speciasContain);
                              print("VILLAGE_se $_selectedVillage");
                            });
                          },
                        ),

                      ElevatedButton(
                        onPressed: () {
                          if (_selectedForm == "") {
                            Fluttertoast.showToast(
                                msg: "Please select application type ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }
                          if (_selectedForm == "cutting") {
                            if (_selectedField == "") {
                              Fluttertoast.showToast(
                                  msg: "Please select land type ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            }
                          }
                          if (_selectedVillage == "") {
                            Fluttertoast.showToast(
                                msg: "Please select proper village ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }
                          if (_selectedVillageId == 0) {
                            Fluttertoast.showToast(
                                msg: "Please select village ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }

                          if (_selectedForm == "cutting" &&
                              _selectedVillageId != 0 &&
                              _selectedVillage != "" &&
                              _selectedField == "yes" &&
                              _isNotified == false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => transitPassNotified(
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userMail,
                                  userId: userId,
                                  village_: _selectedVillage,
                                  userGroup: userGroup,
                                  formOneIndex: 0,
                                ),
                              ),
                            );
                          } else if (_selectedForm == "cutting" &&
                              _selectedVillage != "" &&
                              _selectedVillageId != 0 &&
                              _selectedField == "yes" &&
                              _isNotified == true &&
                              _speciasContain == "no") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => transitPassNotified(
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userMail,
                                  userId: userId,
                                  village_: _selectedVillage,
                                  userGroup: userGroup,
                                  formOneIndex: 0,
                                ),
                              ),
                            );
                          }
                          //// Yes for plantation-- will go F2
                          else if (_selectedForm == "cutting" &&
                              _selectedVillageId != 0 &&
                              _selectedField == "yes" &&
                              _isNotified == true &&
                              _speciasContain == "yes") {
                            Fluttertoast.showToast(
                                msg: "No need of Transit pass",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }

                          //// Yes for plantation--and Yes for specias  -- Toast

                          else if (_selectedForm == "cutting" &&
                              _selectedVillageId != 0 &&
                              _selectedField == "no" &&
                              _selectedVillage != "" &&
                              _isNotified == true &&
                              _speciasContain == "no") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => transitPassNotified(
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userMail,
                                  userId: userId,
                                  village_: _selectedVillage,
                                  userGroup: userGroup,
                                  formOneIndex: 0,
                                ),
                              ),
                            );
                          } else if (_selectedForm == "cutting" &&
                              _selectedVillageId != 0 &&
                              _selectedVillage != "" &&
                              _selectedField == "no" &&
                              _isNotified == false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => transitPassNonNotified(
                                  sessionToken: sessionToken,
                                  userName: userName,
                                  userEmail: userMail,
                                  userId: userId,
                                  village_: _selectedVillage,
                                  userGroup: userGroup,
                                  formOneIndex: 0,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('NEXT'),
                      ),
                    ],
                  ),
                if (_showTextField)
                  Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          // Store the value entered in the TextField
                          CuttingId = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Cutting ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the radius as needed
                          ),
                          filled: true,
                          fillColor:
                              Colors.grey[200], // Set the background color
                        ),
                      ),
                      const SizedBox(height: 18),
                      // TextField(
                      //   controller: _searchController,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedVillage =
                      //           ''; // Clear selected value when typing
                      //       _suggestions = getSuggestions(value, villages);
                      //     });
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'Search for a village...',
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 12.0, horizontal: 16.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     suffixIcon: IconButton(
                      //       onPressed: () {
                      //         _showSuggestionsDialog(context, villages);
                      //       },
                      //       icon: const Icon(Icons.search),
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () async {
                          // Ensure that the cuttingId is not empty before making the API call
                          if (CuttingId.isNotEmpty) {
                            // Call the API request with cuttingId as a parameter
                            bool apiSuccess =
                                await callApiFunction(CuttingId, sessionToken);

                            if (apiSuccess) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => transiView(
                                    sessionToken: sessionToken,
                                    userName: userName,
                                    userEmail: userMail,
                                    userId: userId,
                                    village_: _selectedVillage,
                                    userGroup: userGroup,
                                    Ids: CuttingId,
                                    formOneIndex: 0,
                                  ),
                                ),
                              );
                            } else {
                              // Handle the case when the API request fails
                              // You can show an error message or take appropriate action
                            }
                          } else {
                            // Show an error message or take appropriate action if cuttingId is empty
                          }
                        },
                        child: const Text('NEXT'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.red), // Set the border color
          ),
          title: const Text('Popup Message'),
          content: const Text(
              'As per Section 6(3)(ii) of the The Kerala Promotion of Tree Growth in Non-forest areas Act , 2005, such prior permission is not required  for the cutting and removal of trees mentioned in the schedule'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      sessionToken: sessionToken,
                      userName: userName,
                      userEmail: userMail,
                      userId: userId,
                      userMobile: '',
                      userAddress: '',
                      userProfile: '',
                      userGroup: userGroup,
                      userCato: '',
                    ),
                  ),
                );
                // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<String> getSuggestions(String query, List<VillageData> villageList) {
    if (query.isEmpty) {
      return []; // Return an empty list when query is empty
    }

    // Extract village names from the VillageData objects
    List<String> villageNames =
        villageList.map((village) => village.villageName).toList();

    // Filter the village names based on the query
    List<String> filteredVillages = villageNames
        .where(
            (village) => village.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return filteredVillages;
  }

  late OverlayEntry overlayEntry;
  void _showSuggestionsOverlay(BuildContext context, List<String> suggestions) {
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width,
        top: 200, // Adjust the top position as needed
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
                  onTap: () {
                    final selectedVillageName = suggestions[index];
                    final selectedVillage = villages.firstWhere(
                      (village) => village.villageName == selectedVillageName,
                      orElse: () => VillageData(
                          id: 0, villageName: '', isNotified: false),
                    );

                    setState(() {
                      _searchController.text = selectedVillage.villageName;
                      _selectedVillage = selectedVillage.villageName;
                      _selectedVillageId = selectedVillage.id;
                      _isNotified = selectedVillage.isNotified;
                      _suggestions = []; // Clear suggestions

                      print("isNot$_isNotified");
                      if (_isNotified == false) {
                        _showSpecias = false;
                      } else if (_isNotified == true) {
                        _showSpecias = true;
                      }
                    });

                    overlayEntry.remove(); // Close the overlay
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  void _showSuggestionsDialog(
      BuildContext context, List<VillageData> villageList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('VILLAGE SUGGESTIONS'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                  onTap: () {
                    final selectedVillageName = _suggestions[index];
                    final selectedVillage = villages.firstWhere(
                      (village) => village.villageName == selectedVillageName,
                      orElse: () => VillageData(
                          id: 0, villageName: '', isNotified: false),
                    );

                    setState(() {
                      _searchController.text = selectedVillage.villageName;
                      _selectedVillage = selectedVillage.villageName;
                      _selectedVillageId = selectedVillage.id;
                      _isNotified = selectedVillage.isNotified;
                      _suggestions = []; // Clear suggestions

                      print("isNot$_isNotified");
                      if (_isNotified == false) {
                        _showSpecias = false;
                      } else if (_isNotified == true) {
                        _showSpecias = true;
                      }
                    });

                    Navigator.pop(context); // Close the dialog
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://timber.forest.kerala.gov.in/api/auth/villages/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        final villageList = data['villages'] as List<dynamic>;
        final parsedVillages =
            villageList.map((v) => VillageData.fromJson(v)).toList();

        setState(() {
          villages = parsedVillages;
        });
      }
    } else {
      // Handle error
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

Future<bool> loginAction() async {
  //replace the below line of code with your login request
  await Future.delayed(const Duration(seconds: 2));
  return true;
}

callApiFunction(String Id, String token) async {
  const String url =
      'https://timber.forest.kerala.gov.in/api/auth/CheckTransit/';
  Map data = {
    "app_id": Id,
  };

  var body = json.encode(data);

  final response = await http.post(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "token $token"
      },
      body: body);
  print("REQUEST$body");

  Map<String, dynamic> responseJson = json.decode(response.body);
  print("RESSS$responseJson");
  if (responseJson['status'] != "success") {
    Fluttertoast.showToast(
        msg: "Application not avaliable",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0);
    return false;
  }
  await loginAction();
  return true;
}
