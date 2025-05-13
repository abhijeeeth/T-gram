// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' show File;
import 'dart:io' as Io;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/CheckPassStatus.dart';
import 'package:tigramnks/Images.dart';
import 'package:tigramnks/NEW_FORMS/transitView.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:tigramnks/ViewApplication1.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tigramnks/homePage.dart';

import '../model/MyIcon.dart';

class viewApplicationNw2 extends StatefulWidget {
  final String sessionToken;
  final String userGroup;
  final int userId;
  final String Ids;
  final List Range;
  final String userName;
  final String userEmail;
  String img_signature;
  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  int assigned_range_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  String field_requre;
  bool field_status;
  List species;
  List length;
  List breadth;
  List volume;
  List log_details;
  String treeSpecies;
  String user_Loc;

  viewApplicationNw2(
      {super.key,
      required this.sessionToken,
      required this.userId,
      required this.Ids,
      required this.Range,
      required this.userName,
      required this.userEmail,
      required this.img_signature,
      required this.userGroup,
      required this.verify_officer,
      required this.deputy_range_officer,
      required this.verify_range_officer,
      required this.is_form_two,
      required this.assigned_deputy2_id,
      required this.assigned_deputy1_id,
      required this.assigned_range_id,
      required this.verify_deputy2,
      required this.division_officer,
      required this.other_state,
      required this.verify_forest1,
      required this.field_requre,
      required this.field_status,
      required this.species,
      required this.length,
      required this.breadth,
      required this.volume,
      required this.log_details,
      required this.treeSpecies,
      required this.user_Loc});

  @override
  State<viewApplicationNw2> createState() => _viewApplicationNw2State(
      sessionToken,
      userId,
      Ids,
      Range,
      userName,
      userEmail,
      img_signature,
      userGroup,
      verify_officer,
      deputy_range_officer,
      verify_range_officer,
      is_form_two,
      assigned_deputy2_id,
      assigned_deputy1_id,
      assigned_range_id,
      verify_deputy2,
      division_officer,
      other_state,
      verify_forest1,
      field_requre,
      field_status,
      species,
      length,
      breadth,
      volume,
      log_details,
      treeSpecies,
      user_Loc);
}

class _viewApplicationNw2State extends State<viewApplicationNw2> {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String userName;
  String userEmail;

  String img_signature;
  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  int assigned_range_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  String field_requre;
  bool field_status;
  List species;
  List length;
  List breadth;
  List volume;
  List log_details;
  String treeSpecies;
  String user_Loc;

  _viewApplicationNw2State(
      this.sessionToken,
      this.userId,
      this.Ids,
      this.Range,
      this.userName,
      this.userEmail,
      this.img_signature,
      this.userGroup,
      this.verify_officer,
      this.deputy_range_officer,
      this.verify_range_officer,
      this.is_form_two,
      this.assigned_deputy2_id,
      this.assigned_deputy1_id,
      this.assigned_range_id,
      this.verify_deputy2,
      this.division_officer,
      this.other_state,
      this.verify_forest1,
      this.field_requre,
      this.field_status,
      this.species,
      this.length,
      this.breadth,
      this.volume,
      this.log_details,
      this.treeSpecies,
      this.user_Loc);
  List Tree_species = [];

  String latImage_u = "";
  String longImage_u = "";
  void getCurrentLocation() async {
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
    if (latImage_u == "" || longImage_u == "") {
      getCurrentLocation3();
    }

    setState(() {
      latImage_u = posi4.latitude.toString();
      longImage_u = posi4.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void logApplicationDetails() {
    print('=== Application Details Log ===');
    print('Application ID: $Ids');
    print('User Details:');
    print('- Group: $userGroup');
    print('- ID: $userId');
    print('- Name: $userName');
    print('- Email: $userEmail');

    print('\nApplication Status:');
    print('- Field Status: $field_status');
    print('- Form Two: $is_form_two');
    print('- Field Requirement: $field_requre');

    print('\nOfficer Assignments:');
    print('- Deputy 1 ID: $assigned_deputy1_id');
    print('- Deputy 2 ID: $assigned_deputy2_id');
    print('- Range ID: $assigned_range_id');

    print('\nVerification Status:');
    print('- Officer Verified: $verify_officer');
    print('- Range Officer Verified: $verify_range_officer');
    print('- Deputy 2 Verified: $verify_deputy2');
    print('- Forest 1 Verified: $verify_forest1');

    print('\nLocation Details:');
    print('- User Location: $user_Loc');
    print('=== End Application Details ===');
  }

  @override
  void initState() {
    super.initState();
    logApplicationDetails();

    // Initialize log_details with the incoming data
    setState(() {
      log_details =
          List.from(log_details); // Create a copy of incoming log details
      if (!field_status) {
        feachLog();
      } else {
        fechAppLog();
      }
      listDeputy();
    });

    // Add status validation
    if (!canViewApplication()) {
      String errorMessage = '';
      if (field_status) {
        errorMessage = 'Field verification already completed';
      } else if (assigned_deputy1_id != 0) {
        errorMessage = 'Deputy already assigned';
      } else if (verify_range_officer) {
        errorMessage = 'Application already verified';
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(errorMessage);
      });
      return;
    }

    if (userGroup == "user" && user_Loc == "L") {
      getCurrentLocation();
    }

    setState(() {
      if (!field_status) {
        feachLog();
      } else {
        fechAppLog();
      }
      listDeputy();
    });
  }

  TextEditingController remark = TextEditingController();
  File? _imageIDProof;
  File? _pdfIDProof;
  String Remark_Assign = "";
  bool assignMyself = true;
  String AssignMyself = "yes";
  String AssignOr = "";
  bool varifyOk = false;
  bool varifyNot = false;

  bool imageP = false;

  String base64ImagePic1 = "";
  var _image1;
  String base64ImagePic2 = "";
  var _image2;
  String base64ImagePic3 = "";
  var _image3;
  String base64ImagePic4 = "";
  var _image4;
  bool _isVisible2 = false;
  bool assign_btn = true;
  bool _finalApp = false;
  bool _buttonApp = true;
  String latImage1 = "";
  String longImage1 = "";
  String latImage2 = "";
  String longImage2 = "";
  String latImage3 = "";
  String longImage3 = "";
  String latImage4 = "";
  String longImage4 = "";
  final List logId_ = [];
  final List species_ = [];
  final List length_ = [];
  final List breadth_ = [];
  final List volume_ = [];
  List Tree_species_ = [];
  List log_details_ = [];
  List selectedValues = [];
  List treelog_ = [];
  bool isShow = false;

  bool can_assign_officer = false;
  bool transit_pass_exist = false;
  bool reject_visible = false;
  bool feild_butt_deputy = false;
  bool feild_butt_range = false;
  bool approve_deputy = false;
  bool approvefinal = false;
  List n_list = [];
  bool add_Loc = false;

  Map<String, TextEditingController> textEditingControllers = {};
  TextEditingController leng = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController Girth = TextEditingController();
  double v = 0.0;
  // double _getVolume(double girth, double length) {
  //   v = (girth / 4) * (girth / 4) * length;
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

  List d = [];
  String? dropdownValue4;
  List c = [];

  bool isAssignmentComplete = false;

  Map DisableButton(
      String userGroup,
      bool verifyOfficer,
      bool deputyRangeOfficer,
      bool verifyRangeOfficer,
      bool isFormTwo,
      int userId,
      int assignedDeputy1Id,
      bool verifyDeputy2,
      bool divisionOfficer,
      bool otherState,
      bool verifyForest1,
      String fieldRequre,
      String userLoc,
      bool fieldStatus) {
    bool canAssignOfficer = false;
    bool transitPassExist = false;
    bool rejectVisible = false;
    bool feildButtRange = false;
    bool approvefinal = false;
    bool addLoc = false;

    // Check if application is self-assigned to the range officer
    bool isSelfAssigned =
        userGroup == 'forest range officer' && assigned_deputy2_id == userId;

    // Check if application is assigned to a deputy
    bool isDeputyAssigned = assignedDeputy1Id != 0;

    if (userGroup == 'forest range officer') {
      if (!fieldStatus && !verifyRangeOfficer) {
        if (isSelfAssigned && !isDeputyAssigned) {
          feildButtRange = true;
          canAssignOfficer = false;
        } else if (!isDeputyAssigned) {
          canAssignOfficer = true;
          rejectVisible = true;
        }
      }
      // Only range officers can approve final cutting pass
      if (fieldStatus && !verifyRangeOfficer) {
        approvefinal = true;
      }
    } else if (userGroup == 'deputy range officer') {
      // Only allow field verification if assigned to this deputy
      if (assignedDeputy1Id == userId && !fieldStatus) {
        feildButtRange = true;
      }
      // Explicitly set approvefinal to false for deputies
      approvefinal = false;
      canAssignOfficer = false;
      rejectVisible = false;
    }

    print("User Group: $userGroup, Approve Final: $approvefinal"); // Debug log

    return {
      'can_assign_officer': canAssignOfficer,
      'transit_pass_exist': transitPassExist,
      'reject_visible': rejectVisible,
      'feild_butt_range': feildButtRange,
      'final_approve': approvefinal,
      'add_LOC': addLoc
    };
  }

  int? dropdownValue3;
  bool Edit = false;
  bool EditA = true; // Store the selected 'id'
  List<Map<String, dynamic>> apiResponse = [];
  listDeputy() async {
    try {
      // Use the first range ID from the Range list or default to 0 if unavailable
      int rangeId = Range.isNotEmpty &&
              Range[0] is Map<String, dynamic> &&
              Range[0].containsKey('id')
          ? Range[0]['id']
          : 0;

      print("Fetching deputies for range ID: $rangeId");

      String url = 'https://timber.forest.kerala.gov.in/api/auth/get_deputies/';
      Map data = {"range": userId};
      var body = json.encode(data);
      print(sessionToken);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJSON = json.decode(response.body);

        if (responseJSON.containsKey("deputy range officers")) {
          List list = responseJSON["deputy range officers"];
          setState(() {
            apiResponse = list.cast<Map<String, dynamic>>();
            print("Loaded ${apiResponse.length} deputies");
          });
        } else {
          print(
              "API response missing 'deputy range officers' key: $responseJSON");
          setState(() {
            apiResponse = [];
          });
        }
      } else {
        print("Failed to load deputies: ${response.statusCode}");
        setState(() {
          apiResponse = []; // Set empty list to avoid null errors
        });
      }
    } catch (e) {
      print("Error fetching deputies: $e");
      setState(() {
        apiResponse = []; // Set empty list to avoid null errors
      });
    }
  }

  feachLog() async {
    String url = 'https://timber.forest.kerala.gov.in/api/auth/get_req_log/';
    Map data = {"app_id": Ids};
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);

    setState(() {
      // Clear existing data
      c.clear();
      Tree_species_.clear();
      logId_.clear();
      species_.clear();
      length_.clear();
      breadth_.clear();
      volume_.clear();

      // Load new data
      for (int i = 0; i < responseJSON['data'].length; i++) {
        c.add(i);
        Tree_species_.add(responseJSON['data'][i]['species_of_tree']);
        logId_.add(responseJSON['data'][i]['id']);
        species_.add(responseJSON['data'][i]['species_of_tree']);
        length_.add(responseJSON['data'][i]['length']);
        breadth_.add(responseJSON['data'][i]['breadth']);
        volume_.add(responseJSON['data'][i]['volume']);
      }

      n_list = List.from(c); // Create a copy
      treelog_ = List.from(responseJSON['data']); // Create a copy
      log_details_ = treelog_;
      log_details = List.from(log_details_); // Initialize log_details

      // Debug logs
      print("Loaded ${log_details.length} log details");
      print(
          "First log detail: ${log_details.isNotEmpty ? log_details[0] : 'none'}");
    });
  }

  fechAppLog() async {
    String url =
        'https://timber.forest.kerala.gov.in/api/auth/get_verified_log/';
    Map data = {"app_id": Ids};
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    Map<String, dynamic> responseJSON = json.decode(response.body);

    setState(() {
      for (int i = 0; i < responseJSON['data'].length; i++) {
        c.add(i);
        Tree_species_.add(responseJSON['data'][i]['species_of_tree']);
        // n_list.add(i);
        logId_.add(responseJSON['data'][i]['id']);
        species_.add(responseJSON['data'][i]['species_of_tree']);
        length_.add(responseJSON['data'][i]['length']);
        breadth_.add(responseJSON['data'][i]['breadth']);
        volume_.add(responseJSON['data'][i]['volume']);
      }

      n_list = c;
      treelog_ = responseJSON['data'];
      log_details_ = treelog_;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            //dropdownValue3='Rosewood (Dalbergia latifolia)';
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue4,
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
                    Map<String, dynamic> logs = {
                      "id": logId_,
                      "species_of_tree": dropdownValue4,
                      "length": leng.text,
                      "volume": _getVolume(
                              (double.parse(
                                  Girth.text == "" ? '0' : Girth.text)),
                              (double.parse(leng.text == "" ? '0' : leng.text)))
                          .toString(),
                      "breadth": Girth.text,
                      "latitude": "00",
                      "longitude": "00"
                    };
                    log_details.add(logs);
                    int n = log_details.length;
                    n_list = [];
                    //
                    //  List n_list =[];

                    for (int i = 0; i < n; i++) {
                      n_list.add(i);
                    }

                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
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
          dropdownValue4 = log_details_[index]['species_of_tree'].toString();
          leng.text = log_details_[index]['length'].toString();
          Girth.text = log_details_[index]['breadth'].toString();
          // Volume=log_details[index]['volume'].toString();
          // latitude.text = log_details[index]['latitude'].toString();
          // longitude.text = log_details[index]['longitude'].toString();
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
                        //initialValue: log_details[index]['length'],
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
                    Map<String, dynamic> logs = {
                      "id": logId_[index],
                      "species_of_tree": dropdownValue4,
                      "length": leng.text,
                      "volume": _getVolume(
                              (double.parse(
                                  Girth.text == "" ? '0' : Girth.text)),
                              (double.parse(leng.text == "" ? '0' : leng.text)))
                          .toString(),
                      "breadth": Girth.text,
                      "latitude": 00,
                      "longitude": 00
                    };
                    // log_details.elementAt(int.parse(source));
                    log_details[index] = logs;
                    int n = log_details.length;
                    n_list = [];

                    for (int i = 0; i < n; i++) {
                      n_list.add(i);
                    }

                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
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

  bool canViewApplication() {
    if (userGroup == 'forest range officer') {
      // Check if this is a self-assigned application
      bool isSelfAssigned = assigned_deputy2_id == userId;

      // For Form Two applications
      if (is_form_two) {
        // Allow if not verified by range officer and either:
        // - application is not assigned (for initial assignment)
        // - application is self-assigned (for field verification)
        return !verify_range_officer &&
            (assigned_deputy1_id == 0 || isSelfAssigned);
      }

      // For regular applications, same logic
      return (assigned_deputy1_id == 0 || isSelfAssigned) &&
          assigned_range_id == 0 &&
          !verify_range_officer;
    }
    return false;
  }

  void showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cannot View Application'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("View Application"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(width: 0, height: 10, color: Colors.white),
              Center(
                child: Visibility(
                    visible: DisableButton(
                            userGroup,
                            verify_officer,
                            deputy_range_officer,
                            verify_range_officer,
                            is_form_two,
                            userId,
                            assigned_deputy1_id,
                            verify_deputy2,
                            division_officer,
                            other_state,
                            verify_forest1,
                            field_requre,
                            user_Loc,
                            field_status)["can_assign_officer"] ==
                        true, // Explicit comparison
                    child: Visibility(
                      visible: assign_btn,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isVisible2 = !_isVisible2;
                            assign_btn = !assign_btn;
                          });
                        },
                        child: const Text(
                          ' Assign or Approve ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ),
              // Debugging information - access outside of the widget tree
              SizedBox(
                height: 0,
                width: 0,
                child: Builder(builder: (context) {
                  // Execute print in a side effect, not as a widget
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    print(
                        "Can assign officer: ${DisableButton(userGroup, verify_officer, deputy_range_officer, verify_range_officer, is_form_two, userId, assigned_deputy1_id, verify_deputy2, division_officer, other_state, verify_forest1, field_requre, user_Loc, field_status)["can_assign_officer"]}");
                  });
                  return const SizedBox();
                }),
              ),
              Visibility(
                visible: _isVisible2,
                child: Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    RadioListTile(
                      title: const Text('Proceed for field Verification'),
                      value: 'proceed',
                      groupValue: AssignOr,
                      onChanged: (value) {
                        setState(() {
                          varifyOk = true;
                          varifyNot = false;
                          AssignOr = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Reject Application'),
                      value: 'reject',
                      groupValue: AssignOr,
                      onChanged: (value) {
                        setState(() {
                          varifyOk = false;
                          varifyNot = true;
                          AssignOr = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                )),
              ),
              Visibility(
                visible: varifyOk,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0), // Add padding to both sides
                        child: Text(
                          "Do you want to assign it to a deputy officer or perform field verification yourself?",
                        ),
                      ),
                      RadioListTile(
                        title: const Text('field verification myself'),
                        value: 'yes',
                        groupValue: AssignMyself,
                        onChanged: (value) {
                          setState(() {
                            AssignMyself = value!;
                            assignMyself = true;
                          });
                        },
                      ),
                      RadioListTile(
                        title: const Text('Assign to deputy'),
                        value: 'no',
                        groupValue: AssignMyself,
                        onChanged: (value) {
                          setState(() {
                            AssignMyself = value!;
                            assignMyself = false;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Visibility(
                        visible: !assignMyself,
                        child: Column(children: [
                          DropdownButton<int>(
                            value: dropdownValue3,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            hint: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                    text: "Select Officer",
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
                            onChanged: (int? id) {
                              setState(() {
                                dropdownValue3 = id;
                                print(dropdownValue3);
                              });
                            },
                            items: apiResponse.isEmpty
                                ? [
                                    DropdownMenuItem<int>(
                                      value: null,
                                      child: Text("No officers available"),
                                    )
                                  ]
                                : apiResponse.map<DropdownMenuItem<int>>(
                                    (Map<String, dynamic> item) {
                                      return DropdownMenuItem<int>(
                                        value: item['id'] as int,
                                        child: Text(item['name'].toString()),
                                      );
                                    },
                                  ).toList(),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: remark,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Remark  ',
                                hintText: 'Enter Remark '),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 15,
                          top: 10,
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton.icon(
                              icon: const Icon(Icons.image),
                              onPressed: (() {
                                _pickImageOrPDF();
                                setState() {
                                  Remark_Assign;
                                }
                              }),
                              label:
                                  const Text("Upload Remark \n PDF or image"),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            onPressed: () async {
                              if (assignMyself == false) {
                                if (dropdownValue3 == null ||
                                    dropdownValue3.toString() == "") {
                                  Fluttertoast.showToast(
                                      msg: "please select deputy ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 8,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                } else if (Remark_Assign == "") {
                                  Fluttertoast.showToast(
                                      msg: "please add remark file",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 8,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }
                              }
                              if (Remark_Assign == "") {
                                Fluttertoast.showToast(
                                    msg: "please add remark file",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                const String url =
                                    'https://timber.forest.kerala.gov.in/api/auth/assgin_deputy/';
                                Map data = {
                                  "app_id": Ids,
                                  "deputy_id": dropdownValue3 != null
                                      ? dropdownValue3.toString()
                                      : "",
                                  "remark_text": remark.text,
                                  "self": assignMyself,
                                  "remark_file": {
                                    "mime": "image/jpeg",
                                    "data": Remark_Assign
                                  }
                                };

                                var body = json.encode(data);

                                final response = await http.post(Uri.parse(url),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                      'Authorization': "token $sessionToken"
                                    },
                                    body: body);

                                Map<String, dynamic> responseJson =
                                    json.decode(response.body);

                                Fluttertoast.showToast(
                                    msg: responseJson['message'].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);

                                setState(() {
                                  isAssignmentComplete = true;
                                  _isVisible2 = false;
                                  assign_btn = false;
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => OfficerDashboard(
                                              sessionToken: sessionToken,
                                              userName: userName,
                                              userEmail: userEmail,
                                              userGroup: userGroup,
                                              userId: userId,
                                              dropdownValue:
                                                  dropdownValue4 ?? "",
                                              Range: Range,
                                            )));
                              }
                            },
                            child: const Text(
                              ' ASSIGN ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'Cairo',
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: varifyNot,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: remark,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Remark  ',
                                hintText: 'Enter Remark '),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 15,
                          top: 10,
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton.icon(
                              icon: const Icon(Icons.image),
                              onPressed: (() {
                                _pickImageOrPDF();
                                setState() {
                                  Remark_Assign;
                                }
                              }),
                              label:
                                  const Text("Upload Remark \n PDF or image"),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          onPressed: () async {
                            if (Remark_Assign == "") {
                              Fluttertoast.showToast(
                                  msg: "please add remark file",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 8,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            } else {
                              const String url =
                                  'https://timber.forest.kerala.gov.in/api/auth/approve_cutting_pass_new/';
                              Map data = {
                                "app_id": int.parse(Ids),
                                "type": "Reject",
                                "remark_text": remark.text,
                                "logs_selected": "",
                                "remark_file": {
                                  "mime": "image/jpeg",
                                  "data": Remark_Assign
                                }
                              };

                              var body = json.encode(data);

                              final response = await http.post(Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                    'Authorization': "token $sessionToken"
                                  },
                                  body: body);

                              Map<String, dynamic> responseJson =
                                  json.decode(response.body);

                              Fluttertoast.showToast(
                                  msg: responseJson['message'].toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 8,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 18.0);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OfficerDashboard(
                                            sessionToken: sessionToken,
                                            userName: userName,
                                            userEmail: userEmail,
                                            userGroup: userGroup,
                                            userId: userId,
                                            dropdownValue: "",
                                            Range: Range,
                                          )));
                            }
                          },
                          child: const Text(
                            ' REJECT ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(width: 0, height: 10, color: Colors.white),
              /////----APPROVE-----
              Center(
                child: Visibility(
                    visible: DisableButton(
                        userGroup,
                        verify_officer,
                        deputy_range_officer,
                        verify_range_officer,
                        is_form_two,
                        userId,
                        assigned_deputy1_id,
                        verify_deputy2,
                        division_officer,
                        other_state,
                        verify_forest1,
                        field_requre,
                        user_Loc,
                        field_status)["final_approve"],
                    child: Visibility(
                      visible: _buttonApp,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_finalApp == false) {
                              _finalApp = true;
                              _buttonApp = false;
                            } else {
                              _finalApp = false;
                              _buttonApp = true;
                            }
                          });
                        },
                        child: const Text(
                          ' Approve Pass',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    )),
              ),

              Visibility(
                visible: _finalApp,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: remark,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Remark  ',
                                hintText: 'Enter Remark '),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 15,
                          top: 10,
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton.icon(
                              icon: const Icon(Icons.image),
                              onPressed: (() {
                                _pickImageOrPDF();
                                setState() {
                                  Remark_Assign;
                                }
                              }),
                              label:
                                  const Text("Upload Remark \n PDF or image"),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        if (EditA == true) {
                          return Container(
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
                                  offset: Offset(2.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(
                                        label: Text(
                                      'S.No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Species  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      ' Height(M)   ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      '  GBH(cm) ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      ' Volume (m³)   ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    )),
                                    // DataColumn(
                                    //     label: Text(
                                    //   ' select   ',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // )),
                                    // DataColumn(label: Text('Latitude ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                    // DataColumn(label: Text('longitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                    DataColumn(
                                        label: Text(
                                      ' select   ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    )),
                                  ],
                                  rows: n_list
                                      .map(((index) => DataRow(cells: [
                                            DataCell(
                                                Text((index + 1).toString())),
                                            DataCell(SizedBox(
                                                width: 180,
                                                child: Text(
                                                  log_details_[index]
                                                          ['species_of_tree']
                                                      .toString(),
                                                ))),
                                            DataCell(SizedBox(
                                                width: 100,
                                                child: Text(
                                                  log_details_[index]['length']
                                                      .toString(),
                                                ))),
                                            DataCell(SizedBox(
                                                width: 100,
                                                child: Text(
                                                  log_details_[index]['breadth']
                                                      .toString(),
                                                ))),
                                            DataCell(SizedBox(
                                                width: 100,
                                                child: Text(
                                                  log_details_[index]['volume']
                                                      .toString(),
                                                ))),
                                            // DataCell(Container(width:100,child:Text(log_details[index]['latitude'].toString(),))),
                                            // DataCell(Container(width:100,child:Text(log_details[index]['longitude'].toString(),))),
                                            DataCell(Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  value:
                                                      selectedValues.contains(
                                                          log_details_[index]
                                                              ['id']),
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      if (newValue != null &&
                                                          newValue) {
                                                        selectedValues.add(
                                                            log_details_[index]
                                                                ['id']);
                                                      } else {
                                                        selectedValues.remove(
                                                            log_details_[index]
                                                                ['id']);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            )),
                                          ])))
                                      .toList(),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 8, right: 8, bottom: 10),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: DataTable(
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      dividerThickness: 2,
                                      columnSpacing: 25,
                                      showBottomBorder: true,
                                      headingRowColor:
                                          WidgetStateColor.resolveWith(
                                              (states) => Colors.orange),
                                      columns: const [
                                        DataColumn(
                                            label: Text(
                                          'S.No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Species',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Length',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Girth',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Volume (m³)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ],
                                      rows:
                                          // Loops through dataColumnText, each iteration assigning the value to element
                                          c
                                              .map(
                                                ((value) => DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(
                                                            (value + 1)
                                                                .toString())),
                                                        DataCell(Text(species_[
                                                                value]
                                                            .toString())), //Extracting from Map element the value
                                                        DataCell(Text(
                                                            length_[value]
                                                                .toString())),
                                                        DataCell(Text(
                                                            breadth_[value]
                                                                .toString())),
                                                        DataCell(Text(
                                                            volume_[value]
                                                                .toString())),
                                                      ],
                                                    )),
                                              )
                                              .toList(),
                                    ),
                                  )));
                        }
                      }),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          onPressed: () async {
                            print("SELECTED $selectedValues");
                            if (Remark_Assign == "") {
                              Fluttertoast.showToast(
                                  msg: "please add remark file",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 8,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            } else {
                              const String url =
                                  'https://timber.forest.kerala.gov.in/api/auth/approve_cutting_pass_new/';
                              Map data = {
                                "app_id": int.parse(Ids),
                                "type": "Approve",
                                "remark_text": remark.text,
                                "logs_selected": selectedValues,
                                "remark_file": {
                                  "mime": "image/jpeg",
                                  "data": Remark_Assign
                                }
                              };

                              var body = json.encode(data);

                              final response = await http.post(Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                    'Authorization': "token $sessionToken"
                                  },
                                  body: body);

                              Map<String, dynamic> responseJson =
                                  json.decode(response.body);

                              Fluttertoast.showToast(
                                  msg: responseJson['message'].toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 8,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 18.0);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OfficerDashboard(
                                            sessionToken: sessionToken,
                                            userName: userName,
                                            userEmail: userEmail,
                                            userGroup: userGroup,
                                            userId: userId,
                                            dropdownValue: dropdownValue4 ?? "",
                                            Range: Range,
                                          )));
                            }
                          },
                          child: const Text(
                            ' APPROVE ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    right: 15.0, top: 15, left: 15, bottom: 0),
                child: Container(
                  height: 70,
                  // elevation: 5,
                  // semanticContainer: true,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  // margin: EdgeInsets.only(top: 10),
                  // child: InkWell(
                  //   onTap: () {
                  //     print("PDFFFFF");
                  //     final url = img_signature.toString();
                  //     if (url.toLowerCase().endsWith('.pdf')) {
                  //       // Open a PDF viewer
                  //       PdfLauncher.launchPdfUrl(url);
                  //     } else {
                  //       // Display the image
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) => ImageView(Images: url),
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: NetworkImage(img_signature.toString()),
                  //         fit: BoxFit.fitWidth,
                  //         alignment: Alignment.center,
                  //       ),
                  //     ),
                  //     child: Column(
                  //       children: <Widget>[
                  //         ListTile(
                  //           title: Text(
                  //             "Proof of Ownership",
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               backgroundColor: Colors.black,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //         if (img_signature
                  //             .toString()
                  //             .toLowerCase()
                  //             .endsWith('.pdf'))
                  //           Icon(
                  //             Icons.picture_as_pdf,
                  //             size: 50,
                  //             color: Colors.red, // Choose your preferred color
                  //           ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                ),
              ),
              Visibility(
                visible: DisableButton(
                    userGroup,
                    verify_officer,
                    deputy_range_officer,
                    verify_range_officer,
                    is_form_two,
                    userId,
                    assigned_deputy1_id,
                    verify_deputy2,
                    division_officer,
                    other_state,
                    verify_forest1,
                    field_requre,
                    user_Loc,
                    field_status)['add_LOC'],
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: () async {
                      getCurrentLocation();
                      if (latImage_u == "") {
                        Fluttertoast.showToast(
                            msg: "location not be added try agin!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 8,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      } else {
                        const String url =
                            'https://timber.forest.kerala.gov.in/api/auth/AddLocation/';
                        Map data = {
                          "app_id": int.parse(Ids),
                          "lat": latImage_u,
                          "lon": longImage_u
                        };

                        var body = json.encode(data);

                        final response = await http.post(Uri.parse(url),
                            headers: <String, String>{
                              'Content-Type': 'application/json',
                              'Authorization': "token $sessionToken"
                            },
                            body: body);

                        Map<String, dynamic> responseJson =
                            json.decode(response.body);

                        if (responseJson.containsKey('applications')) {
                          Fluttertoast.showToast(
                              msg: responseJson['applications'].toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 8,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Location added successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 8,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        }
                        await loginAction();
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 250),
                                transitionsBuilder:
                                    (context, animation, animationTime, child) {
                                  return ScaleTransition(
                                    alignment: Alignment.topCenter,
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return HomePage(
                                      sessionToken: sessionToken,
                                      userName: userName,
                                      userEmail: userEmail,
                                      userGroup: userGroup,
                                      userId: userId,
                                      userMobile: '',
                                      userAddress: '',
                                      userProfile: '',
                                      userCato: '');
                                }));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => HomePage(
                        //               sessionToken: sessionToken,
                        //               userName: userName,
                        //               userEmail: userEmail,
                        //               userGroup: userGroup,
                        //             )));
                      }
                    },
                    child: const Text(
                      ' ADD LOCATION ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Cairo',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: DisableButton(
                    userGroup,
                    verify_officer,
                    deputy_range_officer,
                    verify_range_officer,
                    is_form_two,
                    userId,
                    assigned_deputy1_id,
                    verify_deputy2,
                    division_officer,
                    other_state,
                    verify_forest1,
                    field_requre,
                    user_Loc,
                    field_status)["feild_butt_range"],
                child: Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 0, top: 10, bottom: 0),
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                    ]),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 0, top: 10, bottom: 0),
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      TextButton.icon(
                        icon: const Icon(Icons.image),
                        onPressed: () {
                          setState(() {
                            getCurrentLocation2();
                            _showpickoptiondialogImg2(context);
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
                    ]),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 0, top: 10, bottom: 0),
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      TextButton.icon(
                        icon: const Icon(Icons.image),
                        onPressed: () {
                          setState(() {
                            getCurrentLocation3();
                            _showpickoptiondialogImg3(context);
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
                    ]),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 0, top: 10, bottom: 0),
                    child:
                        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      TextButton.icon(
                        icon: const Icon(Icons.image),
                        onPressed: () {
                          setState(() {
                            getCurrentLocation4();
                            _showpickoptiondialogImg4(context);
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
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextField(
                        controller: summary,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          // border: OutlineInputBorder(),
                          labelText: 'Summary ',
                          hintText: 'Enter Summary',
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

                  const Text(
                    '----------EDIT SPECIES-----------',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                  Visibility(
                    visible: !field_status &&
                        (userGroup == 'forest range officer' ||
                            (userGroup == 'deputy range officer' &&
                                assigned_deputy1_id == userId)),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          Edit = true;
                          // Debug print
                          print(
                              "Edit button pressed. Log details count: ${log_details.length}");
                        }); // Respond to button press
                      },
                      icon: const Icon(Icons.edit_rounded, size: 18),
                      label: const Text("Edit"),
                    ),
                  ),
                  // Spacer(),
                  LayoutBuilder(builder: (context, constraints) {
                    if (Edit == true) {
                      return Container(
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
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  'S.No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Species  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                                DataColumn(
                                    label: Text(
                                  ' Height(M)   ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                                DataColumn(
                                    label: Text(
                                  '  GBH(cm) ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                                DataColumn(
                                    label: Text(
                                  ' Volume (m³)  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                                DataColumn(
                                  label: Row(
                                    children: <Widget>[],
                                  ),
                                ),
                              ],
                              rows: n_list
                                  .map(((index) => DataRow(cells: [
                                        DataCell(Text((index + 1).toString())),
                                        DataCell(SizedBox(
                                            width: 180,
                                            child: Text(
                                              log_details[index]
                                                      ['species_of_tree']
                                                  .toString(),
                                            ))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: Text(
                                              log_details[index]['length']
                                                  .toString(),
                                            ))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: Text(
                                              log_details[index]['breadth']
                                                  .toString(),
                                            ))),
                                        DataCell(SizedBox(
                                            width: 100,
                                            child: Text(
                                              log_details[index]['volume']
                                                  .toString(),
                                            ))),
                                        // DataCell(Container(width:100,child:Text(log_details[index]['latitude'].toString(),))),
                                        // DataCell(Container(width:100,child:Text(log_details[index]['longitude'].toString(),))),
                                        DataCell(Row(
                                          children: <Widget>[
                                            IconButton(
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                log_details.removeAt(index);
                                                n_list.removeLast();

                                                setState(() {
                                                  DataRow;
                                                });
                                              },
                                            ), //--------------Remove Button
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_rounded,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () async {
                                                await EditInformationDialog(
                                                    context, index);
                                                setState(() {
                                                  DataRow;
                                                });
                                              },
                                            )
                                          ],
                                        )),
                                      ])))
                                  .toList(),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 8, right: 8, bottom: 10),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                  sortColumnIndex: 0,
                                  sortAscending: true,
                                  dividerThickness: 2,
                                  columnSpacing: 25,
                                  showBottomBorder: true,
                                  headingRowColor: WidgetStateColor.resolveWith(
                                      (states) => Colors.orange),
                                  columns: const [
                                    DataColumn(
                                        label: Text(
                                      'S.No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Species',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Length',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Girth',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Volume (m³)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                    // DataColumn(label: Text('Latitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                    // DataColumn(label: Text('Longitude',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                  ],
                                  rows:
                                      // Loops through dataColumnText, each iteration assigning the value to element
                                      c
                                          .map(
                                            ((value) => DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(Text((value + 1)
                                                        .toString())),
                                                    DataCell(Text(species_[
                                                            value]
                                                        .toString())), //Extracting from Map element the value
                                                    DataCell(Text(length_[value]
                                                        .toString())),
                                                    DataCell(Text(
                                                        breadth_[value]
                                                            .toString())),
                                                    DataCell(Text(volume_[value]
                                                        .toString())),
                                                    // DataCell(Text(latit[value].toString())),
                                                    // DataCell(Text(longit[value].toString())),
                                                  ],
                                                )),
                                          )
                                          .toList(),
                                ),
                              )));
                    }
                  }),
                  Visibility(
                    visible: isShow,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      strokeWidth: 8,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(8)),
                      child: ElevatedButton(
                        onPressed: () async {
                          if ((latImage1.isEmpty) ||
                              (latImage2.isEmpty) ||
                              (summary.text.isEmpty) ||
                              (latImage3.isEmpty) ||
                              (latImage4.isEmpty)) {
                            Fluttertoast.showToast(
                                msg: "Please select and fill all Field",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          } else {
                            setState(() {
                              isShow = true;
                            });
                            const String url =
                                'https://timber.forest.kerala.gov.in/api/auth/field_verify/';
                            Map data = {
                              "app_id": Ids,
                              "location_img1": {
                                "mime": "image/jpeg",
                                // "image": ""
                                "data": base64ImagePic1
                              },
                              "location_img2": {
                                "mime": "image/jpeg",
                                // "image": ""
                                "data": base64ImagePic2
                              },
                              "location_img3": {
                                "mime": "image/jpeg",
                                // "image": ""
                                "data": base64ImagePic3
                              },
                              "location_img4": {
                                "mime": "image/jpeg",
                                // "image": ""
                                "data": base64ImagePic4
                              },
                              "summary": summary.text,
                              "log_details": log_details,
                              "image1_lat": latImage1,
                              "image2_lat": latImage2,
                              "image3_lat": latImage3,
                              "image4_lat": latImage4,
                              "image1_log": longImage1,
                              "image2_log": longImage2,
                              "image3_log": longImage3,
                              "image4_log": longImage4,
                            };
                            var body = json.encode(data);

                            final response = await http.post(Uri.parse(url),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': "token $sessionToken"
                                },
                                body: body);

                            Map<String, dynamic> responseJson =
                                json.decode(response.body);
                            print(body.toString());

                            if (responseJson['message'] !=
                                "Successfully uploaded images and location details.") {
                              isShow = false;
                              Fluttertoast.showToast(
                                  msg: "Something went wrong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            }
                            await loginAction();
                            Fluttertoast.showToast(
                                msg: responseJson['message'].toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 8,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 18.0);
                            setState(() {
                              isShow = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 250),
                                    transitionsBuilder: (context, animation,
                                        animationTime, child) {
                                      return ScaleTransition(
                                        alignment: Alignment.topCenter,
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder:
                                        (context, animation, animationTime) {
                                      return OfficerDashboard(
                                          sessionToken: sessionToken,
                                          userName: userName,
                                          userEmail: userEmail,
                                          userGroup: userGroup,
                                          userId: userId,
                                          dropdownValue: dropdownValue4 ?? "",
                                          Range: Range);
                                    }));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Set the text color
                        ),
                        child: const Text(
                          'Field verify',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            fontStyle: FontStyle.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  const SizedBox(height: 35.0),
                ]),
              ),
              LayoutBuilder(builder: (context, constraints) {
                if (userGroup == 'deputy range officer') {
                  return Container(
                    width: 0,
                    height: 0,
                    color: Colors.white,
                  );
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                    color: Colors.white,
                  );
                }
              }),
              buildApplicationStatus(),
            ],
          ),
        ),
      ),
    );
  }

  // Future<bool> _onBackPressed() {
  //   Navigator.pop(
  //     context,
  //     MaterialPageRoute(builder: (context) => ViewApplication1()),
  //   );
  // }
  Future<bool> _onBackPressed() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go previous page'),
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
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage1 == "" || longImage1 == "") {
      getCurrentLocation1();
    }

    setState(() {
      latImage1 = posi2.latitude.toString();
      longImage1 = posi2.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation2() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi3 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage2 == "" || longImage2 == "") {
      getCurrentLocation2();
    }

    setState(() {
      latImage2 = posi3.latitude.toString();
      longImage2 = posi3.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

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
    if (latImage3 == "" || longImage3 == "") {
      getCurrentLocation3();
    }

    setState(() {
      latImage3 = posi4.latitude.toString();
      longImage3 = posi4.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation4() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage4 == "" || longImage4 == "") {
      getCurrentLocation4();
    }

    setState(() {
      latImage4 = posi1.latitude.toString();
      longImage4 = posi1.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  Future<void> AssignOfficerDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0), // Add padding to both sides
                      child: Text(
                        "Do you want to assign it to a deputy officer or perform field verification yourself?",
                      ),
                    ),
                    RadioListTile(
                      title: const Text('field verification myself'),
                      value: 'yes',
                      groupValue: AssignMyself,
                      onChanged: (value) {
                        setState(() {
                          AssignMyself = value!;
                          assignMyself = true;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Assign to deputy'),
                      value: 'no',
                      groupValue: AssignMyself,
                      onChanged: (value) {
                        setState(() {
                          AssignMyself = value!;
                          assignMyself = false;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Visibility(
                      visible: !assignMyself,
                      child: DropdownButton<int>(
                        value: dropdownValue3,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        hint: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            const TextSpan(
                                text: "Select Officer",
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
                        onChanged: (int? id) {
                          setState(() {
                            dropdownValue3 = id;
                            print(dropdownValue3);
                          });
                        },
                        items: apiResponse.isEmpty
                            ? [
                                DropdownMenuItem<int>(
                                  value: null,
                                  child: Text("No officers available"),
                                )
                              ]
                            : apiResponse.map<DropdownMenuItem<int>>(
                                (Map<String, dynamic> item) {
                                  return DropdownMenuItem<int>(
                                    value: item['id'] as int,
                                    child: Text(item['name'].toString()),
                                  );
                                },
                              ).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextField(
                          controller: remark,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              // border: OutlineInputBorder(),
                              labelText: 'Remark  ',
                              hintText: 'Enter Remark '),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue)),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 15,
                        top: 10,
                        bottom: 5,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          TextButton.icon(
                            icon: const Icon(Icons.image),
                            onPressed: (() {
                              _pickImageOrPDF();
                              setState() {
                                Remark_Assign;
                              }
                            }),
                            label: const Text("Upload Remark \n PDF or image"),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          onPressed: () async {
                            if (assignMyself == false) {
                              if (dropdownValue3 == null ||
                                  dropdownValue3.toString() == "") {
                                Fluttertoast.showToast(
                                    msg: "please select deputy ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (Remark_Assign == "") {
                                Fluttertoast.showToast(
                                    msg: "please add remark file",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              }
                            }
                            if (Remark_Assign == "") {
                              Fluttertoast.showToast(
                                  msg: "please add remark file",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 8,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            } else {
                              const String url =
                                  'https://timber.forest.kerala.gov.in/api/auth/assgin_deputy/';
                              Map data = {
                                "app_id": Ids,
                                "deputy_id": dropdownValue3 != null
                                    ? dropdownValue3.toString()
                                    : "",
                                "remark_text": remark.text,
                                "self": assignMyself,
                                "remark_file": {
                                  "mime": "image/jpeg",
                                  "data": Remark_Assign
                                }
                              };

                              var body = json.encode(data);

                              final response = await http.post(Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json',
                                    'Authorization': "token $sessionToken"
                                  },
                                  body: body);

                              Map<String, dynamic> responseJson =
                                  json.decode(response.body);

                              Fluttertoast.showToast(
                                  msg: responseJson['message'].toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 8,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 18.0);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OfficerDashboard(
                                            sessionToken: sessionToken,
                                            userName: userName,
                                            userEmail: userEmail,
                                            userGroup: userGroup,
                                            userId: userId,
                                            dropdownValue: dropdownValue4 ?? "",
                                            Range: Range,
                                          )));
                            }
                          },
                          child: const Text(
                            ' SYNC ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              title: const Text('Assign Deputy Range Officer'),
              actions: <Widget>[
                InkWell(
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'CANCEL ',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ],
            );
          });
        });
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
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
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogImg2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic2();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogImg3(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic3();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogImg4(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic4();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future<String> convertPdfToBase64(String pdfFilePath) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          );
        },
      ),
    );

    // Save the PDF to a temporary file
    final tempFile = File(pdfFilePath);
    await tempFile.writeAsBytes(await pdf.save());

    // Read the temporary file as bytes
    final fileBytes = await tempFile.readAsBytes();

    // Encode the bytes to base64
    return base64Encode(fileBytes);
  }

  Future<void> _pickImageOrPDF() async {
    final picker = ImagePicker();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(); // Close the dialog
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (result != null && result.files.isNotEmpty) {
                          final filePath = result.files.single.path;
                          setState(() {
                            _pdfIDProof = File(filePath!);
                            convertPdfToBase64(filePath).then((pdfBase64) {
                              Remark_Assign = pdfBase64;
                            });
                          });
                        }
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.picture_as_pdf_sharp,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'PDF',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop(); // Close the dialog
                        final pickedImage =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedImage != null) {
                          String temp =
                              base64Encode(await pickedImage.readAsBytes());
                          setState(() {
                            _imageIDProof = File(pickedImage.path);
                            Remark_Assign = temp;
                          });
                        }
                      },
                      splashColor: Colors.greenAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  final picker = ImagePicker();
  Future<void> setfilepiccam() async {
    print('object');

    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image1 = File(pickedFile.path);
        base64ImagePic1 = temp;
        print(base64ImagePic1);
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic2() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image2 = File(pickedFile.path);
        base64ImagePic2 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic3() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image3 = File(pickedFile.path);
        base64ImagePic3 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic4() async {
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);

    if (pickedFile != null) {
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image4 = File(pickedFile.path);
        base64ImagePic4 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Widget buildApplicationStatus() {
    return Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Application Status:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  'Field Verification: ${field_status ? "Complete" : "Pending"}'),
              Text(
                  'Range Officer Verification: ${verify_range_officer ? "Complete" : "Pending"}'),
              Text(
                  'Deputy Assignment: ${assigned_deputy1_id != 0 ? "Assigned" : "Pending"}'),
              // Add other relevant status information
            ],
          ),
        ));
  }
}
