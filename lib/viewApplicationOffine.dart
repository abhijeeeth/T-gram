// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io' show File;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/sqflite/dbhelper.dart';

class Viewapplicationoffine extends StatefulWidget {
  final String sessionToken;
  final String userGroup;
  final int userId;
  final String Ids;
  final List Range;
  final String userName;
  final String userEmail;
  String img_signature;
  bool field_status;
  List log_details;
  String treeSpecies;

  Viewapplicationoffine({
    super.key,
    required this.sessionToken,
    required this.userId,
    required this.Ids,
    required this.Range,
    required this.userName,
    required this.userEmail,
    required this.img_signature,
    required this.userGroup,
    required this.field_status,
    required this.log_details,
    required this.treeSpecies,
  });

  @override
  State<Viewapplicationoffine> createState() => _viewApplicationNw2State();
}

class _viewApplicationNw2State extends State<Viewapplicationoffine> {
  String latImage1 = "";
  String token = "";
  String longImage1 = "";
  String latImage2 = "";
  String longImage2 = "";
  String latImage3 = "";
  String longImage3 = "";
  String latImage4 = "";
  String longImage4 = "";

  String base64ImagePic1 = "";
  var _image1;
  String base64ImagePic2 = "";
  var _image2;
  String base64ImagePic3 = "";
  var _image3;
  String base64ImagePic4 = "";
  var _image4;

  List Tree_species_ = [];
  List log_details_ = [];
  List n_list = [];
  bool Edit = false;
  bool isShow = false;

  // Add missing variable declarations
  List c = [];
  List logId_ = [];
  List species_ = [];
  List length_ = [];
  List breadth_ = [];
  List volume_ = [];
  List treelog_ = [];
  List log_details = [];

  TextEditingController summary = TextEditingController();
  TextEditingController leng = TextEditingController();
  TextEditingController Girth = TextEditingController();
  String? dropdownValue4;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      log_details_ = List.from(widget.log_details);
      log_details = List.from(widget.log_details);
      feachLog();
    });
  }

  feachLog() async {
    // Fetch data from local transit_passes table for the current application
    final dbHelper = DbHelper();
    int appId = int.tryParse(widget.Ids) ?? 0;
    List<Map<String, dynamic>> transitPasses =
        await dbHelper.getTransitPasses(appId);

    setState(() {
      // Clear existing data
      c.clear();
      Tree_species_.clear();
      logId_.clear();
      species_.clear();
      length_.clear();
      breadth_.clear();
      volume_.clear();

      // Load new data from local DB
      for (int i = 0; i < transitPasses.length; i++) {
        c.add(i);
        Tree_species_.add(transitPasses[i]['species_of_tree']);
        logId_.add(transitPasses[i]['id']);
        species_.add(transitPasses[i]['species_of_tree']);
        length_.add(transitPasses[i]['length']);
        breadth_.add(transitPasses[i]['breadth']);
        volume_.add(transitPasses[i]['volume']);
      }

      n_list = List.from(c); // Create a copy
      treelog_ = List.from(transitPasses); // Create a copy
      log_details_ = treelog_;
      log_details = List.from(log_details_); // Initialize log_details

      // Debug logs
      print(
          "Loaded ${log_details.length} log details from local transit_passes");
      print(
          "First log detail: ${log_details.isNotEmpty ? log_details[0] : 'none'}");
    });
  }

  double _getVolume(double girth, double length) {
    double girthInMeters = girth * 0.01;
    double radius = girthInMeters / (2 * pi);
    double volume = pi * pow(radius, 2) * length;
    return volume;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Field Verification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Photo Upload Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 0, top: 10, bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation1();
                        _showpickoptiondialogImg1(context);
                      });
                    },
                    label: const Text("Location site photograph 1"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image1) == null) && (latImage1 == "")
                        ? Colors.red
                        : Colors.green,
                    size: 28.0,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 0, top: 10, bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation2();
                        _showpickoptiondialogImg1(context);
                      });
                    },
                    label: const Text("Location site photograph 2"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image2) == null) && (latImage2 == "")
                        ? Colors.red
                        : Colors.green,
                    size: 28.0,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 0, top: 10, bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation3();
                        _showpickoptiondialogImg1(context);
                      });
                    },
                    label: const Text("Location site photograph 3"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image3) == null) && (latImage3 == "")
                        ? Colors.red
                        : Colors.green,
                    size: 28.0,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 0, top: 10, bottom: 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation4();
                        _showpickoptiondialogImg1(context);
                      });
                    },
                    label: const Text("Location site photograph 4"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image4) == null) && (latImage4 == "")
                        ? Colors.red
                        : Colors.green,
                    size: 28.0,
                  ),
                ],
              ),
            ),

            // Summary Field
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: summary,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  ),
                  labelText: 'Summary ',
                  hintText: 'Enter Summary',
                  suffixIcon: RichText(
                    text: const TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),

            // Edit Species Section
            const SizedBox(height: 20),
            const Text(
              'Edit Species Details',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 16),
            ),

            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Edit = !Edit;
                });
              },
              icon: const Icon(Icons.edit_rounded, size: 18),
              label: Text(Edit ? "View Mode" : "Edit Mode"),
            ),

            // Data Table
            Container(
              margin: const EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0),
                  )
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: Edit
                        ? [
                            const DataColumn(
                                label: Text('Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue))),
                            const DataColumn(
                                label: Text('Delete',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))),
                            const DataColumn(
                                label: Text('S.No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue))),
                            const DataColumn(
                                label: Text('Species',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue))),
                            const DataColumn(
                                label: Text('Height(M)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue))),
                            const DataColumn(
                                label: Text('GBH(cm)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue))),
                            const DataColumn(
                                label: Text('Volume (m³)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue))),
                          ]
                        : [
                            const DataColumn(
                                label: Text('S.No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange))),
                            const DataColumn(
                                label: Text('Species',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange))),
                            const DataColumn(
                                label: Text('Height',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange))),
                            const DataColumn(
                                label: Text('GBH',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange))),
                            const DataColumn(
                                label: Text('Volume (m³)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange))),
                          ],
                    rows: n_list
                        .map((index) => DataRow(
                              cells: Edit
                                  ? [
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            EditInformationDialog(
                                                context, index);
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              log_details_.removeAt(index);
                                              n_list = List.generate(
                                                  log_details_.length,
                                                  (index) => index);
                                            });
                                          },
                                        ),
                                      ),
                                      DataCell(Text((index + 1).toString())),
                                      DataCell(SizedBox(
                                          width: 180,
                                          child: Text(log_details_[index]
                                                  ['species_of_tree']
                                              .toString()))),
                                      DataCell(SizedBox(
                                          width: 100,
                                          child: Text(log_details_[index]
                                                  ['length']
                                              .toString()))),
                                      DataCell(SizedBox(
                                          width: 100,
                                          child: Text(log_details_[index]
                                                  ['breadth']
                                              .toString()))),
                                      DataCell(SizedBox(
                                          width: 100,
                                          child: Text(log_details_[index]
                                                  ['volume']
                                              .toString()))),
                                    ]
                                  : [
                                      DataCell(Text((index + 1).toString())),
                                      DataCell(Text(log_details_[index]
                                              ['species_of_tree']
                                          .toString())),
                                      DataCell(Text(log_details_[index]
                                              ['length']
                                          .toString())),
                                      DataCell(Text(log_details_[index]
                                              ['breadth']
                                          .toString())),
                                      DataCell(Text(log_details_[index]
                                              ['volume']
                                          .toString())),
                                    ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),

            // Submit Button
            Visibility(
              visible: isShow,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                strokeWidth: 8,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 40.0),
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if ((latImage1.isEmpty) ||
                      (latImage2.isEmpty) ||
                      (summary.text.isEmpty) ||
                      (latImage3.isEmpty) ||
                      (latImage4.isEmpty)) {
                    Fluttertoast.showToast(
                      msg: "Please fill all required fields and upload photos",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 18.0,
                    );
                  } else {
                    setState(() {
                      isShow = true;
                    });

                    // Store data to local database (application_locations)
                    final dbHelper = DbHelper();
                    Map<String, dynamic> data = {
                      "app_id": widget.Ids,
                      "location_img1": base64ImagePic1,
                      "location_img2": base64ImagePic2,
                      "location_img3": base64ImagePic3,
                      "location_img4": base64ImagePic4,
                      "summary": summary.text,
                      "log_details": jsonEncode(log_details_),
                      "image1_lat": latImage1,
                      "image2_lat": latImage2,
                      "image3_lat": latImage3,
                      "image4_lat": latImage4,
                      "image1_log": longImage1,
                      "image2_log": longImage2,
                      "image3_log": longImage3,
                      "image4_log": longImage4,
                      "created_at": DateTime.now().toIso8601String(),
                    };

                    await dbHelper.insertApplicationLocation(data);

                    setState(() {
                      isShow = false;
                    });

                    Fluttertoast.showToast(
                      msg: "Field verification data saved locally.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 18.0,
                    );

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => OfficerDashboard(
                    //       sessionToken: widget.sessionToken,
                    //       userName: widget.userName,
                    //       userEmail: widget.userEmail,
                    //       userGroup: widget.userGroup,
                    //       userId: widget.userId,
                    //       dropdownValue: "",
                    //       Range: widget.Range,
                    //     ),
                    //   ),
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Submit Field Verification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCurrentLocation1() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi2 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latImage1 = posi2.latitude.toString();
      longImage1 = posi2.longitude.toString();
    });
  }

  void getCurrentLocation2() async {
    var posi3 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latImage2 = posi3.latitude.toString();
      longImage2 = posi3.longitude.toString();
    });
  }

  void getCurrentLocation3() async {
    var posi4 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latImage3 = posi4.latitude.toString();
      longImage3 = posi4.longitude.toString();
    });
  }

  void getCurrentLocation4() async {
    var posi1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latImage4 = posi1.latitude.toString();
      longImage4 = posi1.longitude.toString();
    });
  }

  final picker = ImagePicker();

  Future<void> setfilepiccam() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    if (pickedFile != null) {
      String temp = base64Encode(await pickedFile.readAsBytes());
      setState(() {
        _image1 = File(pickedFile.path);
        base64ImagePic1 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> EditInformationDialog(BuildContext context, int index) async {
    dropdownValue4 = log_details_[index]['species_of_tree'].toString();
    leng.text = log_details_[index]['length'].toString();
    Girth.text = log_details_[index]['breadth'].toString();

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<dynamic>(
                      value: dropdownValue4,
                      isExpanded: true,
                      hint: const Text("Species"),
                      onChanged: (dynamic data) {
                        setState(() {
                          dropdownValue4 = data;
                        });
                      },
                      items: Tree_species_.toSet()
                          .map<DropdownMenuItem<dynamic>>((dynamic value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: leng,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Enter Height";
                      },
                      decoration: const InputDecoration(
                          hintText: "Please Enter Height(M)"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: Girth,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Enter girth";
                      },
                      decoration: const InputDecoration(
                          hintText: "Please Enter GBH(cm)"),
                    ),
                  ],
                ),
              ),
              title: const Text('Edit Tree Log'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> logs = {
                        "id": log_details_[index]['id'],
                        "species_of_tree": dropdownValue4,
                        "length": leng.text,
                        "volume": _getVolume(
                                (double.parse(
                                    Girth.text.isEmpty ? '0' : Girth.text)),
                                (double.parse(
                                    leng.text.isEmpty ? '0' : leng.text)))
                            .toStringAsFixed(2),
                        "breadth": Girth.text,
                        "latitude": "00",
                        "longitude": "00"
                      };
                      log_details_[index] = logs;

                      leng.clear();
                      Girth.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  void _showpickoptiondialogImg1(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              InkWell(
                onTap: () async {
                  await setfilepiccam();
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.camera, color: Colors.blueAccent),
                    ),
                    Text('Camera', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
