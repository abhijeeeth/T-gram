// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/woodshedAddReq.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'Images.dart';

class tigramWoodBuy extends StatefulWidget {
  final int userId;
  final String sessionToken;
  final String userName;
  final String userEmail;
  final String userCato;
  const tigramWoodBuy(
      {super.key,
      required this.userId,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userCato});
  @override
  State<tigramWoodBuy> createState() => _tigramWoodBuyState(
        userId: userId,
        sessionToken: sessionToken,
        userName: userName,
        userEmail: userEmail,
        userCato: userCato,
      );
}

class _tigramWoodBuyState extends State<tigramWoodBuy> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  String userCato;
  _tigramWoodBuyState({
    required this.userId,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
    required this.userCato,
  })  : DD = '',
        dropdownValue = '',
        selectedDistrict = '';
  Future<bool> loginAction() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  int _radioValue = 0;
  bool flag = true;
  var tab = 0;
  bool isShow = false;
  final _sortAscending = true;
  final _sortColumnIndex = 0;
  final int _currentSortColumn = 9;
  final bool _isAscending = true;
  @override
  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;
      if (_radioValue == 0) {
        setState(() {
          tab = 0;
          flag = true;
        });
      } else if (_radioValue == 1) {
        setState(() {
          tab = 1;
          flag = false;
        });
      } else if (_radioValue == 2) {
        setState(() {
          tab = 2;
          flag = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    view_sellerAdded();
    view_AllAdded();
    view_buyerselect();
    LoadDistric();
    ListRange();
    // IsolateNameServer.registerPortWithName(
    //     _receivePort.sendPort, "downloading");

    // _receivePort.listen((message) {
    //   setState(() {
    //     progress = message[2];
    //   });

    //   print(progress);
    // });

    // FlutterDownloader.registerCallback(downloadingCallback);
  }

  bool _isVisible1 = false;
  bool _isVisible2 = false;
  int allApplication = 0;
  int allApplication1 = 0;
  int allApplication2 = 0;

  final List Ids1 = [];
  final List sr1 = [];
  final List Name1 = [];
  final List Address1 = [];
  final List Phone1 = [];
  final List DateT1 = [];
  final List Timber1 = [];
  final List Image1 = [];
  final List quntity1 = [];
  final List division1 = [];
  final List dist1 = [];
  void view_AllAdded() async {
    //----clear----
    Ids1.clear();
    sr1.clear();
    Name1.clear();
    Address1.clear();
    Phone1.clear();
    DateT1.clear();
    Timber1.clear();
    Image1.clear();
    quntity1.clear();
    division1.clear();
    dist1.clear();
    const String url = '${ServerHelper.baseUrl}auth/Buyer_Seller_All_Data';

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);

    List list = responseJSON["data"];
    setState(() {
      //print(list);
      allApplication1 = list.length;
    });
    for (var i = 0; i < allApplication1; i++) {
      sr1.add((i).toString());
      Ids1.add(list[i]['id'].toString());
      Name1.add(list[i]['name'].toString());
      Address1.add(list[i]['address'].toString());
      Phone1.add(list[i]['phone'].toString());
      DateT1.add(list[i]['date'].toString().substring(0, 10));
      Timber1.add(list[i]['timber_name'].toString());
      Image1.add(list[i]['timber_url']);
      quntity1.add(list[i]['quantity'].toString());
      division1.add(list[i]['division'].toString());
      dist1.add(list[i]['dist'].toString());
    }
  }

  final List Ids = [];
  final List sr = [];
  final List Name = [];
  final List Address = [];
  final List Phone = [];
  final List DateT = [];
  final List Timber = [];
  final List Image = [];
  final List pin = [];
  final List quantity = [];
  final List division = [];
  final List disti = [];
  final List status = [];

  void view_sellerAdded() async {
    //----clear----
    Ids.clear();
    sr.clear();
    Name.clear();
    Address.clear();
    Phone.clear();
    DateT.clear();
    Timber.clear();
    Image.clear();
    quantity.clear();
    pin.clear();
    division.clear();
    disti.clear();
    status.clear();
    const String url = '${ServerHelper.baseUrl}auth/View_Buyer_Requirement';

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);

    List list = responseJSON["data"];
    setState(() {
      //print(list);
      allApplication = list.length;
    });
    for (var i = 0; i < allApplication; i++) {
      sr.add((i).toString());
      Ids.add(list[i]['id'].toString());
      Name.add(list[i]['name'].toString());
      Address.add(list[i]['address'].toString());
      Phone.add(list[i]['phone'].toString());
      DateT.add(list[i]['date'].toString().substring(0, 10));
      Timber.add(list[i]['timber_name'].toString());
      Image.add(list[i]['timber_url']);
      // pin.add(list[i]['pincode']);
      quantity.add(list[i]['quantity'].toString());
      division.add(list[i]['division'].toString());
      disti.add(list[i]['dist'].toString());
      status.add(list[i]['status'].toString());
    }
  }

  final List Ids2 = [];
  final List sr2 = [];
  final List Name2 = [];
  final List Address2 = [];
  final List Phone2 = [];
  final List DateT2 = [];
  final List Timber2 = [];
  final List Image2 = [];
  final List pin2 = [];
  final List quantity2 = [];
  final List division2 = [];
  final List disti2 = [];
  final List status2 = [];
  void view_buyerselect() async {
    //----clear----
    Ids2.clear();
    sr2.clear();
    Name2.clear();
    Address2.clear();
    Phone2.clear();
    DateT2.clear();
    Timber2.clear();
    Image2.clear();
    quantity2.clear();
    pin2.clear();
    division2.clear();
    disti2.clear();
    status2.clear();
    const String url = '${ServerHelper.baseUrl}auth/Buyer_SelectedDta';

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);

    List list = responseJSON["data"];
    setState(() {
      //print(list);
      allApplication2 = list.length;
    });
    for (var i = 0; i < allApplication2; i++) {
      sr2.add((i).toString());
      Ids2.add(list[i]['id'].toString());
      Name2.add(list[i]['name'].toString());
      Address2.add(list[i]['address'].toString());
      Phone2.add(list[i]['phone'].toString());
      DateT2.add(list[i]['date'].toString().substring(0, 10));
      Timber2.add(list[i]['timber_name'].toString());
      Image2.add(list[i]['timber_url']);
      // pin.add(list[i]['pincode']);
      quantity2.add(list[i]['quantity'].toString());
      division2.add(list[i]['division'].toString());
      disti2.add(list[i]['dist'].toString());
      status2.add(list[i]['status'].toString());
    }
  }

  String dropdownValue;
  String selectedDistrict;
  String DD;
  List<String> Rname = [];
  int RL = 0;
  List<String> Dname = [];
  List<String> district = [];
  LoadDistric() async {
    int RL = 0;

    String url = '${ServerHelper.baseUrl}auth/ListDistrict';

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
      district.clear(); // Clear the list before adding items
      for (int i = 0; i < RL; i++) {
        district.add(responseJSON["data"][i]['district_name']);
      }
      district = district.toSet().toList(); // Remove duplicates
    });
  }

  ListRange() async {
    const String url = '${ServerHelper.baseUrl}auth/LoadTreeSpecies';
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    print(response.body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
      Rname.clear(); // Clear the list before adding items
    });
    for (int i = 0; i < RL; i++) {
      Rname.add(responseJSON["data"][i]['name']);
    }
    Rname = Rname.toSet().toList(); // Remove duplicates
    print(Rname);
  }

  void filterall() async {
    if (tab == 0) {
      Ids1.clear();
      sr1.clear();
      Name1.clear();
      Address1.clear();
      Phone1.clear();
      DateT1.clear();
      Timber1.clear();
      Image1.clear();
      quntity1.clear();

      division1.clear();
      dist1.clear();

      const String url =
          '${ServerHelper.baseUrl}auth/addtimber_district_species_filtration';
      Map data = {
        "district": selectedDistrict ?? "",
        "species": dropdownValue ?? ""
      };
      print(data);
      var body = json.encode(data);
      print(body);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);
      Map<String, dynamic> responseJSON = json.decode(response.body);
      print(responseJSON);

      List list = responseJSON["data"];
      setState(() {
        // filterall();
        //print(list);
        allApplication = list.length;
      });
      for (var i = 0; i < allApplication; i++) {
        sr1.add((i).toString());
        Ids1.add(list[i]['id'].toString());
        Name1.add(list[i]['name']);
        Address1.add(list[i]['address']);
        Phone1.add(list[i]['phone']);
        DateT1.add(list[i]['date'].toString().substring(0, 10));
        Timber1.add(list[i]['timber_name'].toString());
        Image1.add(list[i]['timber_url']);
        // pin.add(list[i]['pincode']);
        quntity1.add(list[i]['quantity']);
        division1.add(list[i]['division']);
        dist1.add(list[i]['dist']);
        // status.add(list[i]['status']);
      }
    } else if (tab == 1) {
      Ids.clear();
      sr.clear();
      Name.clear();
      Address.clear();
      Phone.clear();
      DateT.clear();
      Timber.clear();
      Image.clear();
      quantity.clear();
      division1.clear();
      dist1.clear();
      const String url =
          '${ServerHelper.baseUrl}auth/requirement_district_species_filtration';

      Map data = {
        "district": selectedDistrict ?? "",
        "species": dropdownValue ?? ""
      };
      print(data);
      var body = json.encode(data);
      print(body);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);
      Map<String, dynamic> responseJSON = json.decode(response.body);
      print(responseJSON);

      List list = responseJSON["data"];
      setState(() {
        //print(list);
        allApplication1 = list.length;
      });
      for (var i = 0; i < allApplication1; i++) {
        sr.add((i).toString());
        Ids.add(list[i]['id'].toString());
        Name.add(list[i]['name']);
        Address.add(list[i]['address']);
        Phone.add(list[i]['phone']);
        DateT.add(list[i]['date'].toString().substring(0, 10));
        Timber.add(list[i]['timber_name'].toString());
        Image.add(list[i]['timber_url']);
        quantity.add(list[i]['quantity']);
        division.add(list[i]['division']);
        disti.add(list[i]['dist']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tigram WoodShed"),

        //backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => woodshedAddReq(
                                userId: userId,
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userEmail,
                              )));
                },
                child: Text("ADD Requirement"),
              )),
          SizedBox(
              height: 25,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: () {
                  setState(() {
                    if (_isVisible2 == false) {
                      _isVisible1 = true;
                      _isVisible2 = true;
                    } else {
                      _isVisible2 = false;
                    }
                  });
                },
                child: const Text("Filter by"),
              )),
          Visibility(
            visible: _isVisible2,
            child: Container(
              color: Colors.grey,
              padding:
                  const EdgeInsets.only(left: 2, right: 2, top: 0, bottom: 0),
              child: Row(children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue == "" ? null : dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Specias",
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
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValue = data!;
                    });
                    print(dropdownValue);
                  },
                  items: Rname.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
                Spacer(),

                // Spacer(),
                DropdownButton<String>(
                  value: selectedDistrict == "" ? null : selectedDistrict,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
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
                  onChanged: (String? data) {
                    setState(() {
                      selectedDistrict = data!;
                    });
                    print(selectedDistrict);
                  },
                  items: district
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),
          ),
          Visibility(
            // child: Container(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (_) => woodshedAdd(
            //                       userId: userId,
            //                       sessionToken: sessionToken,
            //                       userName: userName,
            //                       userEmail: userEmail,
            //                     )));
            //       },
            //       child: Text("ADD  TIMBER"),
            //     )),
            visible: _isVisible2,
            child: Container(
              height: 37,
              width: double.infinity,
              color: Colors.grey,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  filterall();
                },
                child: const Text(" FILTER "),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ToggleSwitch(
              minWidth: MediaQuery.of(context).size.width,
              initialLabelIndex: _radioValue,
              cornerRadius: 8.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey[200],
              inactiveFgColor: Colors.blue,
              labels: [
                ' Timber \n Woodshed',
                'Requirements\nAdded',
                ' Selectes\n Timber'
              ],
              activeBgColors: [
                [Colors.orange],
                [Colors.green],
                [Colors.orange]
              ],
              onToggle: (index) => _handleRadioValueChange(index),
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            if (tab == 0) {
              // view_AllAdded();
              return Container(
                  height: MediaQuery.of(context).size.height * 0.79,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrangeAccent,
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                        //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 2, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, top: 2, bottom: 2),
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
                                // sortColumnIndex: _currentSortColumn,
                                // sortAscending: _isAscending,
                                dividerThickness: 2,
                                columnSpacing: 20,
                                showBottomBorder: true,
                                headingRowColor: WidgetStateColor.resolveWith(
                                    (states) => Colors.orange),
                                columns: [
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
                                    ' Select ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' Species ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' Division ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' District ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' Quantity ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                    label: Text(
                                      ' Name ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Address ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                      label: Text(
                                    ' Phone Number ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' Image ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    ' Date of \n insert ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ],
                                rows: sr1
                                    .map(((value) => DataRow(cells: <DataCell>[
                                          DataCell((Text((int.parse(value) + 1)
                                              .toString()))),
                                          DataCell(
                                            Visibility(
                                              visible: true,
                                              child: IconButton(
                                                  icon: new Icon(
                                                      Icons.select_all),
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    if (Ids1[
                                                            int.parse(value)] !=
                                                        null) {
                                                      const String url =
                                                          "${ServerHelper.baseUrl}auth/Select_Data";
                                                      Map data = {
                                                        "id": Ids1[
                                                            int.parse(value)]

                                                        // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                      };
                                                      print(data);
                                                      var body =
                                                          json.encode(data);
                                                      print(body);
                                                      final response =
                                                          await http.post(
                                                              Uri.parse(url),
                                                              headers: {
                                                                'Content-Type':
                                                                    'application/json',
                                                                'Authorization':
                                                                    "token $sessionToken"
                                                              },
                                                              body: body);
                                                      print(response.body);
                                                      Map<String, dynamic>
                                                          responseJson =
                                                          json.decode(
                                                              response.body);
                                                      print(responseJson);
                                                      if (responseJson[
                                                              'message'] !=
                                                          "Selected  Successfully.") {
                                                        isShow = false;
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Something went wrong",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                4,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 18.0);
                                                      }
                                                      Fluttertoast.showToast(
                                                          msg: responseJson[
                                                                  'message']
                                                              .toString(),
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity:
                                                              ToastGravity
                                                                  .CENTER,
                                                          timeInSecForIosWeb: 8,
                                                          backgroundColor:
                                                              Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 18.0);
                                                      setState(() {
                                                        isShow = false;
                                                      });
                                                    }
                                                  }),
                                            ),
                                          ),
                                          DataCell(Text(
                                              Timber1[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(
                                              division1[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(dist1[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(
                                              quntity1[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(Name1[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(
                                              Address1[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(Phone1[int.parse(value)]
                                              .toString())),

                                          DataCell(Card(
                                            elevation: 5,
                                            semanticContainer: true,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            margin: EdgeInsets.only(top: 10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ImageView(
                                                              Images: Image1[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                            )));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        Image1[int.parse(value)]
                                                            .toString()),
                                                    fit: BoxFit.fitWidth,
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          )
                                              // new Visibility(
                                              //   child: IconButton(
                                              //     icon: new Icon(
                                              //         Icons.file_download),
                                              //     color: Colors.blue,
                                              //     onPressed: () async {
                                              //       await launch(Image[
                                              //               int.parse(value)]
                                              //           .toString());
                                              //       // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                              //     },
                                              //   ),
                                              // ),
                                              ),
                                          // DataCell(Text(
                                          //     Image[int.parse(value)]
                                          //         .toString())),
                                          DataCell(Text(DateT1[int.parse(value)]
                                              .toString())),
                                          // DataCell(
                                          //   Visibility(
                                          //     visible: true,
                                          //     child: IconButton(
                                          //         icon: new Icon(
                                          //             Icons.file_download),
                                          //         color: Colors.blue,
                                          //         onPressed: () async {
                                          //           if (Ids1[
                                          //                   int.parse(value)] !=
                                          //               null) {
                                          //             const String url =
                                          //                 "${ServerHelper.baseUrl}auth/Delete_Timber_Data";
                                          //             Map data = {
                                          //               "id": Ids1[
                                          //                   int.parse(value)]

                                          //               // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                          //             };
                                          //             print(data);
                                          //             var body =
                                          //                 json.encode(data);
                                          //             print(body);
                                          //             final response =
                                          //                 await http.post(
                                          //                     Uri.parse(url),
                                          //                     headers: {
                                          //                       'Content-Type':
                                          //                           'application/json',
                                          //                       'Authorization':
                                          //                           "token $sessionToken"
                                          //                     },
                                          //                     body: body);
                                          //             print(response.body);
                                          //             Map<String, dynamic>
                                          //                 responseJson =
                                          //                 json.decode(
                                          //                     response.body);
                                          //             print(responseJson);
                                          //             if (responseJson[
                                          //                     'message'] !=
                                          //                 "Deleted  Successfully.") {
                                          //               isShow = false;
                                          //               Fluttertoast.showToast(
                                          //                   msg:
                                          //                       "Something went wrong",
                                          //                   toastLength: Toast
                                          //                       .LENGTH_SHORT,
                                          //                   gravity:
                                          //                       ToastGravity
                                          //                           .CENTER,
                                          //                   timeInSecForIosWeb:
                                          //                       4,
                                          //                   backgroundColor:
                                          //                       Colors.red,
                                          //                   textColor:
                                          //                       Colors.white,
                                          //                   fontSize: 18.0);
                                          //             }
                                          //             Fluttertoast.showToast(
                                          //                 msg: responseJson[
                                          //                         'message']
                                          //                     .toString(),
                                          //                 toastLength: Toast
                                          //                     .LENGTH_SHORT,
                                          //                 gravity:
                                          //                     ToastGravity
                                          //                         .CENTER,
                                          //                 timeInSecForIosWeb: 8,
                                          //                 backgroundColor:
                                          //                     Colors.blue,
                                          //                 textColor:
                                          //                     Colors.white,
                                          //                 fontSize: 18.0);
                                          //             setState(() {
                                          //               isShow = false;
                                          //             });
                                          //           }
                                          //           ;
                                          //         }),
                                          //   ),
                                          // ),
                                        ])))
                                    .toList(),
                              ),
                            ),
                          ))));
            } else if (tab == 1) {
              // view_sellerAdded();
              return Container(
                  height: MediaQuery.of(context).size.height * 0.79,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrangeAccent,
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                        //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 2, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, top: 2, bottom: 2),
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
                                // sortColumnIndex: _currentSortColumn,
                                // sortAscending: _isAscending,
                                dividerThickness: 2,
                                columnSpacing: 20,
                                showBottomBorder: true,
                                headingRowColor: WidgetStateColor.resolveWith(
                                    (states) => Colors.orange),
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'S.No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  // DataColumn(
                                  //   label: Text(
                                  //     'Select',
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.white),
                                  //   ),
                                  // ),
                                  DataColumn(
                                    label: Text(
                                      ' Timber \n Name  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Quantity ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Division ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' District ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Address ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const DataColumn(
                                      label: Text(
                                    ' Phone Number ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    '  Name ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),

                                  const DataColumn(
                                      label: Text(
                                    ' Date of \n insert ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ],
                                rows: sr
                                    .map(((value) => DataRow(cells: <DataCell>[
                                          DataCell((Text((int.parse(value) + 1)
                                              .toString()))),
                                          DataCell(Text(Timber[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(
                                              quantity[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(
                                              division[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(disti[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(
                                              Address[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(Phone[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(Name[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(DateT[int.parse(value)]
                                              .toString())),
                                        ])))
                                    .toList(),
                              ),
                            ),
                          ))));
            } else if (tab == 2) {
              // view_sellerAdded();
              return Container(
                  height: MediaQuery.of(context).size.height * 0.79,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrangeAccent,
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                        //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 2, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, top: 2, bottom: 2),
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
                                // sortColumnIndex: _currentSortColumn,
                                // sortAscending: _isAscending,
                                dividerThickness: 2,
                                columnSpacing: 20,
                                showBottomBorder: true,
                                headingRowColor: WidgetStateColor.resolveWith(
                                    (states) => Colors.orange),
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'S.No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  // DataColumn(
                                  //   label: Text(
                                  //     'Select',
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Colors.white),
                                  //   ),
                                  // ),
                                  DataColumn(
                                    label: Text(
                                      ' Timber \n Name  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Quantity ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Division ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' District ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      ' Address ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const DataColumn(
                                      label: Text(
                                    ' Phone Number ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    '  Name ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),

                                  const DataColumn(
                                      label: Text(
                                    ' Date of \n insert ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ],
                                rows: sr2
                                    .map(((value) => DataRow(cells: <DataCell>[
                                          DataCell((Text((int.parse(value) + 1)
                                              .toString()))),
                                          // DataCell(
                                          //   Visibility(
                                          //     visible: true,
                                          //     child: IconButton(
                                          //         icon: new Icon(
                                          //             Icons.select_all),
                                          //         color: Colors.blue,
                                          //         onPressed: () async {
                                          //           if (Ids[int.parse(value)] !=
                                          //               null) {
                                          //             const String url =
                                          //                 "${ServerHelper.baseUrl}auth/Select_Data";
                                          //             Map data = {
                                          //               "id": Ids[
                                          //                   int.parse(value)]

                                          //               // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                          //             };
                                          //             print(data);
                                          //             var body =
                                          //                 json.encode(data);
                                          //             print(body);
                                          //             final response =
                                          //                 await http.post(
                                          //                     Uri.parse(url),
                                          //                     headers: {
                                          //                       'Content-Type':
                                          //                           'application/json',
                                          //                       'Authorization':
                                          //                           "token $sessionToken"
                                          //                     },
                                          //                     body: body);
                                          //             print(response.body);
                                          //             Map<String, dynamic>
                                          //                 responseJson =
                                          //                 json.decode(
                                          //                     response.body);
                                          //             print(responseJson);
                                          //             if (responseJson[
                                          //                     'message'] !=
                                          //                 "Selected  Successfully.") {
                                          //               isShow = false;
                                          //               Fluttertoast.showToast(
                                          //                   msg:
                                          //                       "Something went wrong",
                                          //                   toastLength: Toast
                                          //                       .LENGTH_SHORT,
                                          //                   gravity:
                                          //                       ToastGravity
                                          //                           .CENTER,
                                          //                   timeInSecForIosWeb:
                                          //                       4,
                                          //                   backgroundColor:
                                          //                       Colors.red,
                                          //                   textColor:
                                          //                       Colors.white,
                                          //                   fontSize: 18.0);
                                          //             }
                                          //             Fluttertoast.showToast(
                                          //                 msg: responseJson[
                                          //                         'message']
                                          //                     .toString(),
                                          //                 toastLength: Toast
                                          //                     .LENGTH_SHORT,
                                          //                 gravity:
                                          //                     ToastGravity
                                          //                         .CENTER,
                                          //                 timeInSecForIosWeb: 8,
                                          //                 backgroundColor:
                                          //                     Colors.blue,
                                          //                 textColor:
                                          //                     Colors.white,
                                          //                 fontSize: 18.0);
                                          //             setState(() {
                                          //               isShow = false;
                                          //             });
                                          //           }
                                          //           ;
                                          //         }),
                                          //   ),
                                          // ),
                                          DataCell(Text(
                                              Timber2[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(
                                              quantity2[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(
                                              division2[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(disti2[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(
                                              Address2[int.parse(value)]
                                                  .toString())),
                                          DataCell(Text(Phone2[int.parse(value)]
                                              .toString())),
                                          DataCell(Text(Name2[int.parse(value)]
                                              .toString())),
                                          // DataCell(
                                          //   Card(
                                          //     elevation: 5,
                                          //     semanticContainer: true,
                                          //     clipBehavior:
                                          //         Clip.antiAliasWithSaveLayer,
                                          //     margin: EdgeInsets.only(top: 10),
                                          //     child: InkWell(
                                          //       onTap: () {
                                          //         Navigator.push(
                                          //             context,
                                          //             MaterialPageRoute(
                                          //                 builder:
                                          //                     (_) => ImageView(
                                          //                           Images: Image[
                                          //                                   int.parse(value)]
                                          //                               .toString(),
                                          //                         )));
                                          //       },
                                          //       child: Container(
                                          //         decoration: BoxDecoration(
                                          //           image: DecorationImage(
                                          //             image: NetworkImage(Image[
                                          //                     int.parse(value)]
                                          //                 .toString()),
                                          //             fit: BoxFit.fitWidth,
                                          //             alignment:
                                          //                 Alignment.center,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius.circular(20),
                                          //     ),
                                          //   ),
                                          // ),
                                          DataCell(Text(DateT2[int.parse(value)]
                                              .toString())),
                                        ])))
                                    .toList(),
                              ),
                            ),
                          ))));
            }
            return Container(); // Add this line
          })
        ]),
      ),
    );
  }
}
