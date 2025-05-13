// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNonNot2.dart';

class transitPassNonNotified extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village_;
  String userGroup;

  transitPassNonNotified(
      {super.key,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.formOneIndex,
      required this.village_,
      required this.userGroup});

  @override
  State<transitPassNonNotified> createState() =>
      _transitPassNonNotifiedState(formOneIndex, sessionToken, userName,
          userEmail: userEmail,
          userId: userId,
          village__: village_,
          userGroup: userGroup);
}

class _transitPassNonNotifiedState extends State<transitPassNonNotified> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village__;
  String userGroup;
  String divisionData;
  String selectedPurpose;
  String rangeData;
  String dropdownValue3 = ""; // Initialize with empty string
  bool holder_check = false;
  double v = 0.0;
  double Len = 0.0;

  _transitPassNonNotifiedState(
      this.formOneIndex, this.sessionToken, this.userName,
      {required this.userEmail,
      required this.userId,
      required this.village__,
      required this.userGroup,
      this.divisionData = "",
      this.selectedPurpose = "",
      this.rangeData = "",
      this.dropdownValue3 = ""});

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController DistrictCo = TextEditingController();
  TextEditingController TalukCo = TextEditingController();
  TextEditingController blockCo = TextEditingController();
  TextEditingController pincodeCo = TextEditingController();
  TextEditingController villageCo = TextEditingController();
  TextEditingController Purpose = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController girth = TextEditingController();
  TextEditingController volume = TextEditingController();
  String no_Tree = "0";

  bool flag1 = true;
  int exindex = 1;
  Map<String, bool> SpeciasList = {
    'Rosewood(Dalbergia latifolia)': false,
    'Teak(Tectona grandis) ': false,
    'Thempavu(Terminalia tomantosa)': false,
    'Chadachi(Grewia tiliaefolia)': false,
    'Chandana vempu(Cedrela toona)': false,
    'Vellakil(Dysoxylum malabaricum)': false,
    'Irul(Xylia xylocarpa)': false,
    'Ebony(Diospyrus sp.)': false,
    'Kampakam(Hopea Parviflora)': false,
  };
  var holder_1 = [];
  bool _getHolderCheck() {
    print("No_treee Bool $no_Tree");

    return int.parse(no_Tree) > 0;
  }

  // double _getVolume(double girth, double length) {
  //   v = ((girth * 0.01) / 4) * ((girth * 0.01) / 4) * length;
  //   return v;
  // }
  double _getVolume(double girth, double length) {
    // Convert girth from cm to meters
    double girthInMeters = girth * 0.01;

    // Calculate the radius from the girth
    double radius = girthInMeters / (2 * pi);

    // Calculate the volume of the cylinder
    double volume = pi * pow(radius, 2) * length;

    return volume;
  }

  Widget getTextV(BuildContext context, double girth, double length) {
    return Text((_getVolume(girth, length).toString()).toString());
  }

  List log_details = [];
  List d = [];
  List Species = [];
  List Length = [];
  List Girth = [];
  List Volume = [];
  List Latitude = [];
  List Longitude = [];
  List n_list = [];
  bool flag_no = false;
  bool flag_Log = false;
  getItems() {
    SpeciasList.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });
    print(holder_1);
  }

  final Location location =
      Location(latitude: 0.0, longitude: 0.0, timestamp: DateTime.now());
  int num1 = 0;

  void getCurrentLocation3() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi4 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    setState(() {
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation3();
    setState(() {
      LoadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if divisionData exists in the divisions list
    bool divisionExists = divisionData.isNotEmpty &&
        divisions.where((division) => division == divisionData).isNotEmpty;

    // Check if rangeData exists in the ranges list
    bool rangeExists = rangeData.isNotEmpty &&
        ranges.where((range) => range == rangeData).isNotEmpty;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Form I - Non-Notified",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
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
                      text: "Division                                Range",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ]),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8, left: 15, right: 15),
              decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child: Row(
                children: <Widget>[
                  DropdownButton<String>(
                    value: divisionExists ? divisionData : null,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Select Division",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ),
                    onChanged: (String? data) {
                      if (data != null) {
                        setState(() {
                          divisionData = data;
                        });
                      }
                    },
                    items: divisions
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  DropdownButton<String>(
                    value: rangeExists ? rangeData : null,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Select Range",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ),
                    onChanged: (String? data) {
                      if (data != null) {
                        setState(() {
                          rangeData = data;
                        });
                      }
                    },
                    items: ranges
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: Name,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    // border: OutlineInputBorder(),
                    labelText: 'Name ',
                    hintText: 'Enter Your Name',
                    suffixIcon: RichText(
                      text: const TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Address,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  ),
                  labelText: 'Address',
                  hintText: 'Enter Your Address',
                  suffixIcon: RichText(
                    text: const TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: survey_no,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  ),
                  labelText: 'Survey Number',
                  hintText: 'Enter Survey Number',
                  suffixIcon: RichText(
                    text: const TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Tree_Proposed_to_cut,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  ),
                  labelText: 'Number of trees proposed to be cut.',
                  hintText: 'Enter Number of Trees',
                  suffixIcon: RichText(
                    text: const TextSpan(
                      text: '*',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
                onChanged: ((value) {
                  no_Tree = value;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: DistrictCo,
                  enabled: false, // Make the TextField non-editable
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'District ',
                      hintText: 'Enter Your District'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: TalukCo,
                  enabled: false, // Make the TextField non-editable
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Taluk ',
                      hintText: 'Enter Your Taluk'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: blockCo,
                  enabled: true, // Make the TextField non-editable
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      labelText: 'Block (optional)',
                      hintText: 'Enter Your Block'),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: villageCo,
                  enabled: false, // Make the TextField non-editable
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Village ',
                      hintText: 'Enter Your Village'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: pincodeCo,
                  enabled: true, // Make the TextField non-editable
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    // border: OutlineInputBorder(),
                    labelText: 'Pincode ',
                    hintText: 'Enter Your Pincode',
                    suffixIcon: RichText(
                      text: const TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Row(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 13, top: 15),
                child: const Text(
                  'Species of tree or trees proposed to be cut:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                  // Your decoration properties
                  ),
              child: Scrollbar(
                // Wrap your ListView with Scrollbar
                thumbVisibility: true, // Show the scrollbar always
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: SpeciasList.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: SpeciasList[key],
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      onChanged: (bool? value) {
                        holder_check = _getHolderCheck();

                        if (int.parse(no_Tree) > 0 && holder_check) {
                          if (value == true) {
                            if (holder_1.length < int.parse(no_Tree)) {
                              holder_1.add(key);
                            } else {
                              Fluttertoast.showToast(
                                msg: "You can only add $no_Tree species",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                              return;
                            }
                          } else {
                            holder_1.remove(key);
                          }
                          setState(() {
                            SpeciasList[key] = value ?? false;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: DropdownButton<String>(
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                value: selectedPurpose.isEmpty ? null : selectedPurpose,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                hint: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Select Purpose",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ]),
                ), // Initially selected value (can be null)
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedPurpose = newValue;
                    });
                  }
                },
                items: const <String>['Personal', 'Commercial']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                    LayoutBuilder(builder: (context, constraints) {
                      if (flag1 == true) {
                        return Column(
                          children: [
                            Column(children: [
                              LayoutBuilder(builder: (context, constraints) {
                                print(n_list.length);
                                int textValue = 0;
                                if (Tree_Proposed_to_cut.text == "") {
                                  textValue = 0;
                                } else {
                                  textValue =
                                      int.parse(Tree_Proposed_to_cut.text);
                                }
                                return Builder(
                                  builder: (context) {
                                    if (textValue > n_list.length) {
                                      flag_no = true;
                                      flag_Log = true;

                                      print("Flag_No $flag_no");
                                      return const Text(
                                        "Add log details for all trees",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                      );
                                    } else {
                                      flag_no = false;
                                      print("Flag_No F $flag_no");
                                      return const Text(
                                        "",
                                        style: TextStyle(fontSize: 1),
                                      );
                                    }
                                  },
                                );
                              })
                            ]),
                            Visibility(
                              visible: flag_Log,
                              child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.29,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Scrollbar(
                                      thumbVisibility: true,
                                      thickness: 15,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: <Widget>[
                                                DataTable(
                                                  columns: [
                                                    const DataColumn(
                                                        label: Text(
                                                      'S.No',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                    const DataColumn(
                                                        label: Text(
                                                      'Species  ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                    DataColumn(
                                                      label: Row(
                                                        children: <Widget>[
                                                          const Text(
                                                            'GBH (cm)',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.info),
                                                            onPressed: () {
                                                              // Show a dialog or tooltip with the additional information
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Information'),
                                                                    content:
                                                                        const Text(
                                                                      'Measured at a height of 1.4 meters above the ground.',
                                                                    ),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const DataColumn(
                                                        label: Text(
                                                      ' Height(M)   ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                    const DataColumn(
                                                        label: Text(
                                                      ' Volume(m³) ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                    DataColumn(
                                                      label: Row(
                                                        children: <Widget>[
                                                          const Text(
                                                            "Add log",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          Visibility(
                                                            visible:
                                                                flag_no == true,
                                                            child: IconButton(
                                                              icon: const Icon(
                                                                Icons
                                                                    .add_circle,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                await showInformationDialog(
                                                                    context);

                                                                setState(() {
                                                                  DataRow;
                                                                  exindex =
                                                                      exindex +
                                                                          1;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  rows: n_list
                                                      .map(((index) =>
                                                          DataRow(cells: [
                                                            DataCell(Text(
                                                                (index + 1)
                                                                    .toString())),
                                                            DataCell(SizedBox(
                                                                width: 180,
                                                                child: Text(
                                                                  log_details[index]
                                                                          [
                                                                          'species_of_tree']
                                                                      .toString(),
                                                                ))),
                                                            DataCell(SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  log_details[index]
                                                                          [
                                                                          'breadth']
                                                                      .toString(),
                                                                ))),
                                                            DataCell(SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  log_details[index]
                                                                          [
                                                                          'length']
                                                                      .toString(),
                                                                ))),
                                                            DataCell(SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  log_details[index]
                                                                          [
                                                                          'volume']
                                                                      .toString(),
                                                                ))),
                                                            DataCell(Row(
                                                              children: <Widget>[
                                                                const Text(
                                                                    "remove"),
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    flag_no =
                                                                        true;

                                                                    log_details
                                                                        .removeAt(
                                                                            index);
                                                                    n_list
                                                                        .removeLast();

                                                                    setState(
                                                                        () {
                                                                      DataRow;
                                                                    });
                                                                  },
                                                                ), //--------------Remove Button
                                                                const Text(
                                                                    "edit"),
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .edit_rounded,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    await EditInformationDialog(
                                                                        context,
                                                                        index);
                                                                    setState(
                                                                        () {
                                                                      DataRow;
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            )),
                                                          ])))
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                          )))),
                            ),
                          ],
                        );
                      } else if (flag1 == false) {
                        return Container(
                          color: Colors.white,
                        );
                      }
                      return Container(); // Add this line
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.green,
                ),
                onPressed: () {
                  if (Name.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Applicant Name ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (Address.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Applicant Address ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (survey_no.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Survay Number",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (pincodeCo.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Applicant Pincode ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (holder_1.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please select Specias types ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (log_details.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please add Log details ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else
                    num1 = int.parse(Tree_Proposed_to_cut.text);

                  if (log_details.length < num1) {
                    Fluttertoast.showToast(
                        msg: "Please add $num1 Log details ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if (Name.text.isNotEmpty &&
                      Address.text.isNotEmpty &&
                      survey_no.text.isNotEmpty &&
                      pincodeCo.text.isNotEmpty &&
                      holder_1.isNotEmpty &&
                      log_details.isNotEmpty &&
                      log_details.length == num1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => transitPassNonNot2(
                            formOneIndex: formOneIndex,
                            sessionToken: sessionToken,
                            userName: userName,
                            userEmail: userEmail,
                            userId: userId,
                            userGroup: userGroup,
                            Name_: Name.text,
                            Division_: divisionData,
                            range_: rangeData,
                            address_: Address.text,
                            survey_no_: survey_no.text,
                            tree_no_cut: no_Tree,
                            district_: DistrictCo.text,
                            taluke_: TalukCo.text,
                            block_: blockCo.text,
                            village_: villageCo.text,
                            pincode_: pincodeCo.text,
                            holder_1: holder_1,
                            purpose_: selectedPurpose,
                            log_details: log_details),
                      ),
                    );
                  }

                  setState(() {});
                },
                child: const Text(" NEXT "),
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.navigate_next),
        //     backgroundColor: HexColor("#0499f2"),
        //     onPressed: () {
        //       if (divisionData == null) {
        //         Fluttertoast.showToast(
        //             msg: "Please select Division ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (rangeData == null) {
        //         Fluttertoast.showToast(
        //             msg: "Please select Range ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (Name.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Applicant Name ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (Address.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Applicant Address ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (survey_no.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Survay Number",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (pincodeCo.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Applicant Pincode ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (holder_1.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please select Specias types ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (selectedPurpose == null) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Purpose ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (log_details.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Log details ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else
        //         num1 = int.parse(Tree_Proposed_to_cut.text);

        //       if (log_details.length < num1) {
        //         Fluttertoast.showToast(
        //             msg: "Please add $num1 Log details ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (divisionData != null &&
        //           rangeData != null &&
        //           Name.text.isNotEmpty &&
        //           Address.text.isNotEmpty &&
        //           survey_no.text.isNotEmpty &&
        //           selectedPurpose != null &&
        //           pincodeCo.text.isNotEmpty &&
        //           holder_1.isNotEmpty &&
        //           log_details.isNotEmpty &&
        //           log_details.length == num1) {
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => transitPassNonNot2(
        //                 formOneIndex: formOneIndex,
        //                 sessionToken: sessionToken,
        //                 userName: userName,
        //                 userEmail: userEmail,
        //                 userId: userId,
        //                 userGroup: userGroup,
        //                 Name_: Name.text,
        //                 Division_: divisionData,
        //                 range_: rangeData,
        //                 address_: Address.text,
        //                 survey_no_: survey_no.text,
        //                 tree_no_cut: no_Tree,
        //                 district_: DistrictCo.text,
        //                 taluke_: TalukCo.text,
        //                 block_: blockCo.text,
        //                 village_: villageCo.text,
        //                 pincode_: pincodeCo.text,
        //                 holder_1: holder_1,
        //                 purpose_: selectedPurpose,
        //                 log_details: log_details),
        //           ),
        //         );
        //       }

        //       setState(() {});
        //     }),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go Home page'),
        content: const Text('Changes you made may not be saved.'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: const Text("YES"),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  String villageTaluka = "";
  String villageDist = "";

  List<String> ranges = [];
  List<String> divisions = [];
  LoadData() async {
    try {
      int DL = 0;
      const String url =
          'https://timber.forest.kerala.gov.in/api/auth/villages/';
      Map data = {
        "village": village__,
      };
      var body = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: body);

      if (response.statusCode != 200) {
        Fluttertoast.showToast(
            msg:
                "Failed to load village data. Server returned status: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      Map<String, dynamic> responseJson = json.decode(response.body);

      if (responseJson['data'] == null) {
        Fluttertoast.showToast(
            msg: "No data returned from server for village: $village__",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      villageTaluka = responseJson['data']['village_taluka'] ?? "";
      villageDist = responseJson['data']['village_dist'] ?? "";

      List<dynamic> possibilityList = responseJson['data']['possibility'] ?? [];
      for (var possibility in possibilityList) {
        String range = possibility['range'] ?? "";
        String divi = possibility['division'] ?? "";
        if (range.isNotEmpty) ranges.add(range);
        if (divi.isNotEmpty) divisions.add(divi);
      }

      setState(() {
        TalukCo.text = villageTaluka;
        DistrictCo.text = villageDist;
        villageCo.text = village__ ?? "";
      });
    } catch (e) {
      print("Error in LoadData: $e");
      Fluttertoast.showToast(
          msg: "Error loading data: ${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  String spacies_holder = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    // Reset dropdown value before showing dialog to avoid stale values
    dropdownValue3 = "";
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue3.isEmpty ? null : dropdownValue3,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hint: const Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? data) {
                          setState(() {
                            dropdownValue3 = data ?? "";
                          });
                        },
                        items: holder_1
                            .toSet()
                            .toList() // Use toSet() to remove duplicates
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(
                              value.toString(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: length,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter Height(M)";
                        },
                        decoration: const InputDecoration(
                            hintText: "Please Enter Height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter GBH(cm)";
                        },
                        decoration: const InputDecoration(
                            hintText: "Please Enter GBH(cm)"),
                      ),
                    ],
                  )),
              title: const Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: const Text(
                    'OK ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.isEmpty) ||
                        (girth.text.isEmpty)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else
                      Len = double.parse(girth.text);
                    if (dropdownValue3 == "Thempavu(Terminalia tomantosa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Thempavu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Rosewood(Dalbergia latifolia)" &&
                        Len < 150) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Rosewood should be 150 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Teak(Tectona grandis) " &&
                        Len < 60) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Teak should be 60 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Kampakam(Hopea Parviflora)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Kampakam should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chadachi(Grewia tiliaefolia)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chadachi should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chandana vempu(Cedrela toona)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chandana vempu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Vellakil(Dysoxylum malabaricum)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Vellakil should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Irul(Xylia xylocarpa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Irul should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Ebony(Diospyrus sp.)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Ebony should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                        "latitude": "00",
                        "longitude": "00"
                      };
                      log_details.add(logs);
                      int n = log_details.length;
                      n_list = [];
                      //
                      //  List n_list =[];
                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }

                      length.clear();
                      girth.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> EditInformationDialog(BuildContext context, int index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          // Set the value from log_details
          dropdownValue3 = log_details[index]['species_of_tree'].toString();
          length.text = log_details[index]['length'].toString();
          girth.text = log_details[index]['breadth'].toString();
          volume.text = log_details[index]['volume'].toString();

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue3.isEmpty ? null : dropdownValue3,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hint: const Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? data) {
                          setState(() {
                            dropdownValue3 = data ?? "";
                          });
                        },
                        items: holder_1
                            .toSet()
                            .toList() // Use toSet() to remove duplicates
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(
                              value.toString(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        //initialValue: log_details[index]['length'],
                        controller: length,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter height(M)";
                        },
                        decoration: const InputDecoration(
                            hintText: "Please Enter height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter GBH(cm)";
                        },
                        decoration: const InputDecoration(
                            hintText: "Please Enter GBH(cm)"),
                      ),
                    ],
                  )),
              title: const Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: const Text(
                    'OK ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.isEmpty) ||
                        (girth.text.isEmpty)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else
                      Len = double.parse(girth.text);
                    if (dropdownValue3 == "Thempavu(Terminalia tomantosa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Thempavu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Rosewood(Dalbergia latifolia)" &&
                        Len < 150) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Rosewood should be 150 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Teak(Tectona grandis) " &&
                        Len < 60) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Teak should be 60 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Kampakam(Hopea Parviflora)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Kampakam should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chadachi(Grewia tiliaefolia)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chadachi should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chandana vempu(Cedrela toona)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chandana vempu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Vellakil(Dysoxylum malabaricum)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Vellakil should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Irul(Xylia xylocarpa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Irul should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Ebony(Diospyrus sp.)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Ebony should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                      };

                      log_details[index] = logs;
                      int n = log_details.length;
                      n_list = [];

                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }

                      if (_formKey.currentState!.validate()) {
                        length.clear();
                        girth.clear();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            );
          });
        });
  }
}
