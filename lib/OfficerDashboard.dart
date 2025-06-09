// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tigramnks/NEW_FORMS/transitViewAndApprove.dart';
import 'package:tigramnks/ViewApplication.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficerDashboard extends StatefulWidget {
  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userGroup;
  String dropdownValue;
  String? userMobile;
  String? userAddress;
  List Range;

  OfficerDashboard(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.sessionToken,
      required this.userGroup,
      required this.dropdownValue,
      this.userMobile,
      this.userAddress,
      required this.Range});

  @override
  _OfficerDashboardState createState() => _OfficerDashboardState(userId,
      userName, userEmail, sessionToken, userGroup, dropdownValue, Range);
}

class _OfficerDashboardState extends State<OfficerDashboard> {
  @override
  void initState() {
    permission();
    super.initState();
    print(userId);
    pie_chart();
    PendingApp();
    ApprovedApp();
    DeemedApp();
    NocForm();
  }

  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userGroup;
  String dropdownValue;
  List Range;
  double Approved = 0;
  double Rejected = 0;
  double Pending = 0;

  _OfficerDashboardState(this.userId, this.userName, this.userEmail,
      this.sessionToken, this.userGroup, this.dropdownValue, this.Range);

//---------------------Pie-chart------------------
  void pie_chart() async {
    const String url = '${ServerHelper.baseUrl}auth/dashbord_chart';

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });

    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    print("token $sessionToken");
    setState(() {
      Approved = responseJSON['data']['per_approved'];
      Rejected = responseJSON['data']['per_rejected'];
      Pending = responseJSON['data']['per_pending'];
    });
  }

  Future<void> downloadFormIPdf(int appId, bool notified) async {
    // If not Android, show message and exit function
    if (!Platform.isAndroid) {
      Fluttertoast.showToast(
          msg: "Downloads are only supported on Android devices");
      return;
    }

    String url = notified == true
        ? '${ServerHelper.baseUrl}auth/generate_form_ii_pdf/'
        : '${ServerHelper.baseUrl}auth/generate_form_i_pdf/';

    try {
      // Request storage permissions

      // Make API request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: jsonEncode({'app_id': appId}),
      );

      log('PDF download response body: ${response.body}');

      if (response.statusCode == 200) {
        // Save PDF to app's internal documents directory first
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String filePath =
            '${appDocDir.path}/Form_${appId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final File file = File(filePath);

        await file.writeAsBytes(response.bodyBytes);

        // Try to open the file using open_filex
        final result = await OpenFilex.open(filePath);
        log("File opened with result: ${result.message}");

        // Move file to appropriate directory based on the platform
        if (Platform.isAndroid) {
          await moveFileToDownloads(filePath); // Move to Downloads for Android
          Fluttertoast.showToast(msg: "PDF downloaded to Downloads folder");
        } else if (Platform.isIOS) {
          await moveFileToDocuments(filePath); // Save to Documents for iOS
          Fluttertoast.showToast(msg: "PDF saved to Documents folder");
        } else {
          log("Unknown platform: PDF saved to app directory");
          Fluttertoast.showToast(msg: "PDF saved to app directory");
        }
      }
    } catch (e) {
      log('Error during PDF download: $e');
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  Future<void> moveFileToDocuments(String sourcePath) async {
    try {
      final File sourceFile = File(sourcePath);
      final String fileName = sourcePath.split('/').last;

      // Get the Documents directory path
      final Directory documentsDir = await getApplicationDocumentsDirectory();
      final String documentPath = '${documentsDir.path}/$fileName';

      // Copy the file to Documents directory
      await sourceFile.copy(documentPath);

      // Delete the original file from temporary storage
      //await sourceFile.delete();

      log('File moved to Documents: $documentPath');
    } catch (e) {
      log('Error moving file to Documents: $e');
      rethrow;
    }
  }

  Future<void> moveFileToDownloads(String sourcePath) async {
    try {
      final File sourceFile = File(sourcePath);
      final String fileName = sourcePath.split('/').last;

      // Get the Downloads directory path
      final Directory? downloadsDir = await getExternalStorageDirectory();
      if (downloadsDir == null)
        throw Exception('Could not access Downloads directory');

      final String downloadPath = '${downloadsDir.path}/$fileName';

      // Copy the file to Downloads directory
      await sourceFile.copy(downloadPath);

      // Delete the original file from temporary storage
      // await sourceFile.delete();

      log('File moved to Downloads: $downloadPath');
    } catch (e) {
      log('Error moving file to Downloads: $e');
      rethrow;
    }
  }

  String replaceSlashesWithDashes(String input) {
    return input.replaceAll('/', '-');
  }

  List<Color> colors = [Colors.blue, Colors.red, Colors.orange];

//------------------End--Pie--Chart--------------

  String url = "http://65.1.132.43:8080/api/auth/new_transit_pass_pdf/90/";

  //---------------Table ----------------------
  //---------pending-------------
  final List Ids = [];
  final List sr = [];
  final List App_no = [];
  final List App_Name = [];
  final List App_Date = [];
  final List Current_status = [];
  final List days_left_transit = [];
  final List Approved_date = [];
  final List Action = [];
  //------------
  final List reason_office = [];
  final List reason_depty_ranger_office = [];
  final List reason_range_officer = [];
  final List disapproved_reason = [];
  final List reason_division = [];
  //------------
  //------------
  final List verify_office_date = [];
  final List deputy_officer_date = [];
  final List range_officer_date = [];
  final List division_date = [];
  //final List disapproved_reason=[];
  //------------
  final List Remark = [];
  final List Remark_date = [];
  final List Tp_status = [];
  final List Tp_Issue_Date = [];
  final List Tp_Number = [];
  final List verify_range = [];
  final List depty_range_officer = [];
  final List verify_range_officer = [];
  final List division = [];
  final List tp_expiry_date = [];
  final List other_State = [];

  final List verify_deputy2 = [];
  final List reason_deputy2 = [];
  final List deputy2_date = [];

  final List is_form_two = [];

  final List assigned_deputy1_by_id = [];
  final List assigned_deputy2_by_id = [];

  final List log_updated_by_use = [];
  final List verify_forest1 = [];
  //------------------------

  List list1 = [];
  int allApplication = 0;
//-----------Approved------------------------
  int allApplication1 = 0;
  final List Ids1 = [];
  final List sr1 = [];
  final List App_no1 = [];
  final List App_Name1 = [];
  final List App_Date1 = [];
  final List Current_status1 = [];
  final List days_left_transit1 = [];
  final List Approved_date1 = [];
  final List Action1 = [];
  final List Remark1 = [];
  final List Remark_date1 = [];
  final List Tp_status1 = [];
  final List Tp_Issue_Date1 = [];
  final List Tp_Number1 = [];
  final List verify_range1 = [];
  final List depty_range_officer1 = [];
  final List verify_range_officer1 = [];
  final List division1 = [];
  final List tp_expiry_date1 = [];
  //------------
  final List reason_office1 = [];
  final List reason_depty_ranger_office1 = [];
  final List reason_range_officer1 = [];
  final List disapproved_reason1 = [];
  final List reason_division1 = [];
  //------------
  final List verify_office_date1 = [];
  final List deputy_officer_date1 = [];
  final List range_officer_date1 = [];
  final List division_date1 = [];

  final List other_State1 = [];

  final List verify_deputy2_1 = [];
  final List reason_deputy2_1 = [];
  final List deputy2_date_1 = [];

  final List is_form_two1 = [];
  final List is_form3_1 = [];

  final List assigned_deputy1_by_id1 = [];
  final List assigned_deputy2_by_id1 = [];
  final List log_updated_by_use1 = [];
  final List verify_forest1_1 = [];
  final List field_status = [];
  final List field_status1 = [];
  //------------------------------------------
  void PendingApp() async {
    sr.clear();
    App_no.clear();
    App_Name.clear();
    App_Date.clear();
    Current_status.clear();
    days_left_transit.clear();
    Approved_date.clear();
    Action.clear();
    Remark.clear();
    Remark_date.clear();
    Tp_Issue_Date.clear();
    Tp_Number.clear();
    verify_range.clear();
    depty_range_officer.clear();
    verify_range_officer.clear();
    tp_expiry_date.clear();
    reason_office.clear();
    reason_depty_ranger_office.clear();
    reason_range_officer.clear();
    disapproved_reason.clear();
    verify_office_date.clear();
    deputy_officer_date.clear();
    range_officer_date.clear();
    division.clear();
    reason_division.clear();
    division_date.clear();
    other_State.clear();
    verify_deputy2.clear();
    reason_deputy2.clear();
    deputy2_date.clear();
    is_form_two.clear();
    assigned_deputy1_by_id.clear();
    assigned_deputy2_by_id.clear();
    log_updated_by_use.clear();
    verify_forest1.clear();
    field_status.clear();
    print("Pending Application");
    const String url = '${ServerHelper.baseUrl}auth/PendingListViewApplication';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    log("Pending Application");
    log(responseJSON.toString());
    List list = responseJSON["data"];
    setState(() {
      allApplication = list.length;
    });
    for (var i = 0; i < allApplication; i++) {
      sr.add(i.toString());
      Ids.add(list[i]['id'].toString());
      App_no.add(list[i]['application_no']);
      App_Name.add(list[i]['name'].toString());
      App_Date.add(list[i]['created_date'].toString());
      Current_status.add(list[i]['application_status'].toString());
      days_left_transit.add(list[i]['6'].toString());
      Approved_date.add(list[i]['tp_expiry_status'].toString());
      Action.add(list[i][''].toString());
      Remark.add(list[i]['disapproved_reason'].toString());
      Remark_date.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date.add(list[i]['created_date'].toString());
      Tp_Number.add(list[i]['days_left_for_approval'].toString());
      verify_range.add(list[i]['verify_office']);
      depty_range_officer.add(list[i]['depty_range_officer']);
      verify_range_officer.add(list[i]['application_status']);
      division.add(list[i]['d']);
      tp_expiry_date.add(list[i]['tp_expiry_date']);
      reason_office.add(list[i]['reason_office']);
      reason_depty_ranger_office.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer.add(list[i]['reason_range_officer']);
      reason_division.add(list[i]['reason_division_officer']);
      disapproved_reason.add(list[i]['disapproved_reason']);
      field_status.add(list[i]['current_app_status']);
      verify_office_date.add(list[i]['verify_office_date']);
      deputy_officer_date.add(list[i]['deputy_officer_date']);
      range_officer_date.add(list[i]['range_officer_date']);
      division_date.add(list[i]['division_officer_date']);
      Remark.add(list[i]['remark']);
      other_State.add(list[i]['other_state']);
      verify_deputy2.add(list[i]['verify_deputy2']);
      reason_deputy2.add(list[i]['reason_deputy2']);
      deputy2_date.add(list[i]['deputy2_date']);
      is_form_two.add(list[i]['is_form_two']); //anandhu
      assigned_deputy1_by_id.add(list[i]['assigned_deputy1_name']);
      assigned_deputy2_by_id.add(list[i]['assigned_deputy2_name']);
      log_updated_by_use.add(list[i]['log_updated_by_user']);
      verify_forest1.add(list[i]['verify_forest1']);
    }
    print("--------------- Pending Application----------------");
    print("---------------log----------");
    print(log_updated_by_use);
    // print(Ids + App_no + App_Date + App_Name + Current_status);
  }

//-----------Approved-------------
  void ApprovedApp() async {
    sr1.clear();
    App_no1.clear();
    App_Name1.clear();
    App_Date1.clear();
    Current_status1.clear();
    days_left_transit1.clear();
    Approved_date1.clear();
    Action1.clear();
    Remark.clear();
    Remark_date1.clear();
    Tp_Issue_Date1.clear();
    Tp_Number1.clear();
    verify_range1.clear();
    depty_range_officer1.clear();
    verify_range_officer1.clear();
    tp_expiry_date1.clear();
    reason_office1.clear();
    reason_depty_ranger_office1.clear();
    reason_range_officer1.clear();
    disapproved_reason1.clear();
    verify_office_date1.clear();
    deputy_officer_date1.clear();
    range_officer_date1.clear();
    division1.clear();
    reason_division1.clear();
    division_date1.clear();
    other_State1.clear();
    verify_deputy2_1.clear();
    reason_deputy2_1.clear();
    deputy2_date_1.clear();
    is_form_two1.clear();
    assigned_deputy1_by_id1.clear();
    assigned_deputy2_by_id1.clear();
    log_updated_by_use1.clear();
    verify_forest1_1.clear();
    print("Approved Application");
    const String url =
        '${ServerHelper.baseUrl}auth/ApprovedListViewApplication';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    log(responseJSON.toString());
    List list = responseJSON["data"];

    setState(() {
      allApplication1 = list.length;
    });
    print(list.length);
    for (var i = 0; i < allApplication1; i++) {
      sr1.add(i.toString());
      Ids1.add(list[i]['id'].toString());
      App_no1.add(list[i]['application_no']);
      App_Name1.add(list[i]['name'].toString());
      App_Date1.add(list[i]['created_date'].toString());
      Current_status1.add(list[i]['application_status'].toString());
      days_left_transit1.add(list[i]['application_status'].toString());
      Approved_date1.add(list[i]['verify_office_date'].toString());
      Action1.add(list[i][''].toString());
      Remark1.add(list[i]['reason_office'].toString());
      Remark_date1.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date1.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number1.add(list[i]['transit_pass_id'].toString());
      verify_range1.add(list[i]['verify_office']);
      depty_range_officer1.add(list[i]['depty_range_officer']);
      verify_range_officer1.add(list[i]['approved_by_r']);
      division1.add(list[i]['d']);
      tp_expiry_date1.add(list[i]['tp_expiry_date']);
      reason_office1.add(list[i]['reason_office']);
      reason_depty_ranger_office1.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer1.add(list[i]['reason_range_officer']);
      reason_division1.add(list[i]['reason_division_officer']);
      disapproved_reason1.add(list[i]['disapproved_reason']);
      verify_office_date1.add(list[i]['verify_office_date']);
      deputy_officer_date1.add(list[i]['deputy_officer_date']);
      range_officer_date1.add(list[i]['range_officer_date']);
      division_date1.add(list[i]['division_officer_date']);
      // Remark.add(list[i]['transit_pass_created_date']);
      Remark.add(list[i]['remark']);
      log(Remark.toString());
      other_State1.add(list[i]['other_state']);

      verify_deputy2_1.add(list[i]['verify_deputy2']);
      reason_deputy2_1.add(list[i]['reason_deputy2']);
      deputy2_date_1.add(list[i]['deputy2_date']);

      is_form_two1.add(list[i]['is_form_two']);
      is_form3_1.add(list[i]['is_form3']);

      assigned_deputy1_by_id1.add(list[i]['assigned_deputy1_name']);
      assigned_deputy2_by_id1.add(list[i]['assigned_deputy2_name']);
      log_updated_by_use1.add(list[i]['log_updated_by_user']);
      verify_forest1_1.add(list[i]['verify_forest1']);
      field_status1.add(list[i]['current_app_status'].toString());
    }
  }

//--end-Approve-------------------
  //---------------------------Deemed-Approve-----------------------------
  //----------------------
  int allApplication2 = 0;
  final List Ids2 = [];
  final List sr2 = [];
  final List App_no2 = [];
  final List App_Name2 = [];
  final List App_Date2 = [];
  final List Current_status2 = [];
  final List days_left_transit2 = [];
  final List Approved_date2 = [];
  final List Action2 = [];
  final List Remark2 = [];
  final List Remark_date2 = [];
  final List Tp_status2 = [];
  final List Tp_Issue_Date2 = [];
  final List Tp_Number2 = [];
  final List DeemedApproved2 = [];

  final List reason_office2 = [];
  final List reason_depty_ranger_office2 = [];
  final List reason_range_officer2 = [];
  final List disapproved_reason2 = [];
  final List reason_division2 = [];
  //------------
  final List verify_office_date2 = [];
  final List deputy_officer_date2 = [];
  final List range_officer_date2 = [];
  final List division_date2 = [];

  final List other_State2 = [];
  final List division2 = [];

  //---------------------
  void DeemedApp() async {
    sr2.clear();
    print("Deemed Application");
    const String url = '${ServerHelper.baseUrl}auth/DeemedApprovedList';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);

    List list = responseJSON["data"];
    setState(() {
      allApplication2 = list.length;
    });
    for (var i = 0; i < allApplication2; i++) {
      sr2.add(i.toString());
      Ids2.add(list[i]['id'].toString());
      App_no2.add(list[i]['application_no']);
      App_Name2.add(list[i]['name'].toString());
      App_Date2.add(list[i]['created_date'].toString());
      Current_status2.add(list[i]['application_status'].toString());
      Approved_date2.add(list[i]['transit_pass_created_date'].toString());
      Action2.add(list[i][''].toString());
      Remark2.add(list[i]['reason_office']);
      Remark_date2.add(list[i]['verify_office_date']);
      Tp_Issue_Date2.add(list[i]['transit_pass_created_date']);
      Tp_Number2.add(list[i]['transit_pass_id'].toString());
      DeemedApproved2.add(list[i]['deemed_approval']);

      reason_office2.add(list[i]['reason_office']);
      reason_depty_ranger_office2.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer2.add(list[i]['reason_range_officer']);
      disapproved_reason2.add(list[i]['disapproved_reason']);
      verify_office_date2.add(list[i]['verify_office_date']);
      deputy_officer_date2.add(list[i]['deputy_officer_date']);
      range_officer_date2.add(list[i]['range_officer_date']);

      division2.add(list[i]['division_officer']);
      reason_division2.add(list[i]['reason_division_officer']);
      division_date2.add(list[i]['division_officer_date']);
      // Remark.add(list[i]['transit_pass_created_date']);
      Remark.add(list[i]['remark']);
      other_State2.add(list[i]['other_state']);
    }
  }

  int allApplication3 = 0;
  final List Ids3 = [];
  final List sr3 = [];
  final List App_no3 = [];
  final List App_Name3 = [];
  final List App_Date3 = [];
  final List Current_status3 = [];
  final List days_left_transit3 = [];
  final List Approved_date3 = [];
  final List Action3 = [];
  final List Remark3 = [];
  final List Remark_date3 = [];
  final List Tp_status3 = [];
  final List Tp_Issue_Date3 = [];
  final List Tp_Number3 = [];
  //--------------------

  void NocForm() async {
    sr3.clear();
    const String url = '${ServerHelper.baseUrl}auth/GetOfficerTransitPasses/';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);

    List list = responseJSON["transits"];
    setState(() {
      allApplication3 = list.length;
    });
    for (var i = 0; i < allApplication3; i++) {
      sr3.add(i.toString());
      Ids3.add(list[i]['app_form'].toString());
      App_no3.add(list[i]['transit_number']);
      App_Name3.add(list[i]['name'].toString());
      App_Date3.add(list[i]['transit_req_date'].toString());
      Current_status3.add(list[i]['transit_status'].toString());
      days_left_transit3.add(list[i]['application_status'].toString());
      Approved_date3.add(list[i]['verify_office_date'].toString());
      Action3.add(list[i][''].toString());
      Remark3.add(list[i]['reason_office'].toString());
      Remark_date3.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date3.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number3.add(list[i]['transit_pass_created_date'].toString());
      // Remark.add(list[i]['transit_pass_created_date']);
      Remark.add(list[i]['remark']);
    }
  }

  //-----------------------End-Noc-Form-----------------------------------
  //---------------End---Table-----------------
  int _radioValue = 0;
  bool flag = true;
  var tab = 0;
  @override
  void _handleRadioValueChange(int value) async {
    pie_chart();
    setState(() {
      _radioValue = value;
      if (_radioValue == 0) {
        setState(() {
          tab = 0;
          flag = true;
          pie_chart();
        });
      } else if (_radioValue == 1) {
        setState(() {
          tab = 1;
          flag = false;
          PendingApp();
        });
      } else if (_radioValue == 2) {
        setState(() {
          tab = 2;
          ApprovedApp();
        });
      } else if (_radioValue == 3) {
        setState(() {
          tab = 3;
          DeemedApp();
        });
      } else if (_radioValue == 4) {
        setState(() {
          tab = 4;
          NocForm();
        });
      }
    });
  }

  String OfficerRemark(String AppStatus, String disapproved, String division,
      String forest, String deputy, String revenue) {
    if (AppStatus == 'R') {
      return disapproved;
    } else if (division.isNotEmpty) {
      return division;
    } else if (forest.isNotEmpty) {
      return forest;
    } else if (deputy.isNotEmpty) {
      return deputy;
    } else if (revenue.isNotEmpty) {
      return revenue;
    } else {
      return "N/A";
    }
  }

  String OfficerDate(String AppStatus, dynamic disapproved, dynamic division,
      dynamic forest, dynamic deputy, dynamic revenue) {
    if (AppStatus == 'R') {
      return disapproved != null ? disapproved.toString() : "N/A";
    } else if (division != null) {
      return division.toString();
    } else if (forest != null) {
      return forest.toString();
    } else if (deputy != null) {
      return deputy.toString();
    } else if (revenue != null) {
      return revenue.toString();
    } else {
      return "N/A";
    }
  }

  // Modify the OfficerStatus method to handle null values
  String OfficerStatus(
      String user, dynamic divisionNo, String rangeApprove, String status) {
    if (user == "deputy range officer") {
      if (status == "false") {
        if (rangeApprove == "R") {
          return "Rejected by range officer ";
        } else if (rangeApprove == "A") {
          return "Approved by range officer,\n deputy officer field varification pending";
        } else if (rangeApprove == "P") {
          return "deputy officer field varification pending";
        } else {
          return "";
        }
      } else {
        return "Recommended by Deputy Range Officer,\n Range Officer Recommendation pending";
      }
    } else if (user == "forest range officer") {
      if (status == "false") {
        if (rangeApprove == "R") {
          return "Rejected by range officer ";
        } else if (divisionNo != null) {
          return "Approved by range officer,\n deputy officer field varification pending";
        } else if (rangeApprove == "A") {
          return "Approved by range officer";
        } else if (rangeApprove == "P") {
          return "Range officer Recomendation \n pending";
        } else {
          return "";
        }
      } else {
        return "field varification pending";
      }
    } else {
      return "";
    }
  }

  String AssignOfficer(bool isForm2, String? assignDeputy2,
      String? assignDeputy1, bool? logUpdatedByUser) {
    if (isForm2 == true) {
      if (assignDeputy2 != null) {
        return assignDeputy2;
      } else if (assignDeputy1 != null) {
        if (logUpdatedByUser == true) {
          return 'Yet to Assign for Stage 2';
        } else {
          return assignDeputy1;
        }
      } else {
        return 'Yet to Assign for Stage 1';
      }
    }
    return 'N/A';
  }

  bool getForm(bool isform, bool otherState, bool divisionOfficer,
      bool verifyRangeOfficer, String appStatus) {
    bool canApply3 = false;
    if (appStatus == 'A') {
      return canApply3;
    }
    if (isform == true) {
      if (otherState == false) {
        if (divisionOfficer == true && appStatus != 'P') {
          canApply3 = true;
          return canApply3;
        } else {
          return canApply3;
        }
      } else {
        if (verifyRangeOfficer == true && appStatus != 'P') {
          canApply3 = true;
          return canApply3;
        } else {
          return canApply3;
        }
      }
    }
    return canApply3;
  }

  int daysBetween(DateTime from) {
    DateTime a = DateTime.now();
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime(a.year, a.month, a.day);
    int b = 7 - (to.difference(from).inHours / 24).round();
    if (b < 0) {
      return 0;
    } else {
      return b;
    }
  }

  final int _currentSortColumn = 0;
  final bool _isAscending = true;
  Future<bool> _onBackPressed() async {
    bool returnValue = false;
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to close the application?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  returnValue = false; // User selects "NO"
                  Navigator.of(context).pop(returnValue); // Close the dialog
                },
                child: const Text("NO"),
              ),
              TextButton(
                onPressed: () {
                  returnValue = true; // User selects "YES"
                  Navigator.of(context).pop(returnValue); // Close the dialog
                },
                child: const Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  List<String> getLabels(String userGroup) {
    if (userGroup == "forest range officer") {
      return [
        'Report',
        'Pending',
        'Approved/Rejected',
        'Deemed Approved',
        // 'Transit Approval'
      ];
    } else {
      return ['Report', 'Pending', 'Approved/Rejected', 'Deemed Approved'];
    }
  }

  List<List<Color>> getActiveBgColors(String userGroup) {
    if (userGroup == "forest range officer") {
      return [
        [
          Color.fromARGB(255, 28, 110, 99),
        ],
        [Colors.orange],
        [Colors.green],
        [Colors.cyan],
        [Colors.blue]
      ];
    } else {
      return [
        [Colors.blueAccent],
        [Colors.orange],
        [Colors.green],
        [Colors.cyan]
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6F9), // Light gray background
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.dashboard_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Officer Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 28, 110, 99),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ToggleSwitch(
                minWidth: MediaQuery.of(context).size.width,
                cornerRadius: 15.0,
                activeBgColors: getActiveBgColors(userGroup),
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey[100],
                inactiveFgColor: Color.fromARGB(255, 28, 110, 99),
                initialLabelIndex: _radioValue,
                totalSwitches: getLabels(userGroup).length,
                labels: getLabels(userGroup),
                radiusStyle: true,
                animate: true,
                curve: Curves.easeInOut,
                onToggle: (index) => _handleRadioValueChange(index!),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LayoutBuilder(builder: (context, constraints) {
                    if (tab == 0) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [],
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Application Status Overview Pie Chart",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 28, 110, 99),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    PieChart(
                                      dataMap: {
                                        "Approved": Approved,
                                        "Rejected": Rejected,
                                        "Pending": Pending
                                      },
                                      animationDuration:
                                          Duration(milliseconds: 800),
                                      chartLegendSpacing: 30,
                                      chartRadius:
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                      initialAngleInDegree: 0,
                                      chartType: ChartType.disc,
                                      colorList: [
                                        Color.fromARGB(255, 28, 110, 99),
                                        Colors.red,
                                        Colors.orange
                                      ],
                                      ringStrokeWidth: 32,
                                      centerText: "Status",
                                      centerTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                      legendOptions: LegendOptions(
                                        showLegendsInRow: true,
                                        legendPosition: LegendPosition.bottom,
                                        showLegends: true,
                                        legendTextStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      chartValuesOptions: ChartValuesOptions(
                                        showChartValueBackground: true,
                                        showChartValues: true,
                                        showChartValuesInPercentage: true,
                                        showChartValuesOutside: false,
                                        decimalPlaces: 1,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                )),
                            Divider(
                              color: const Color.fromARGB(131, 158, 158, 158),
                              height: 0.5,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [],
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Application Status Overview Bar Graph",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 28, 110, 99),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          _buildBar(
                                            context,
                                            label: "Approved",
                                            value: (Approved +
                                                        Rejected +
                                                        Pending) ==
                                                    0
                                                ? 0
                                                : (Approved /
                                                    (Approved +
                                                        Rejected +
                                                        Pending) *
                                                    100),
                                            color: Color.fromARGB(
                                                255, 28, 110, 99),
                                            max: (Approved +
                                                        Rejected +
                                                        Pending) ==
                                                    0
                                                ? 1
                                                : (Approved +
                                                    Rejected +
                                                    Pending),
                                          ),
                                          _buildBar(
                                            context,
                                            label: "Rejected",
                                            value: (Approved +
                                                        Rejected +
                                                        Pending) ==
                                                    0
                                                ? 0
                                                : (Rejected /
                                                    (Approved +
                                                        Rejected +
                                                        Pending) *
                                                    100),
                                            color: Colors.red,
                                            max: (Approved +
                                                        Rejected +
                                                        Pending) ==
                                                    0
                                                ? 1
                                                : (Approved +
                                                    Rejected +
                                                    Pending),
                                          ),
                                          _buildBar(
                                            context,
                                            label: "Pending",
                                            value: (Approved +
                                                        Rejected +
                                                        Pending) ==
                                                    0
                                                ? 0
                                                : (Pending /
                                                    (Approved +
                                                        Rejected +
                                                        Pending) *
                                                    100),
                                            color: Colors.orange,
                                            max: (Approved +
                                                        Rejected +
                                                        Pending) ==
                                                    0
                                                ? 1
                                                : (Approved +
                                                    Rejected +
                                                    Pending),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ))
                          ],
                        ),
                      );
                    } else if (tab == 1) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.79,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepOrangeAccent,
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
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
                                        columnSpacing: 20,
                                        dividerThickness: 2,
                                        headingRowColor:
                                            WidgetStateColor.resolveWith(
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
                                            'Application\n       No',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Application\n      Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Application\n      Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Current Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Deputy Officer \n Assignment status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Notified / Non-Notified\n     Villages',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Days  left\nfor Approval',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Action',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Remark',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Remark\n  Date',
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
                                                          DataCell((Text(
                                                              (int.parse(value) +
                                                                      1)
                                                                  .toString()))),
                                                          DataCell(Text(App_no[
                                                                  int.parse(
                                                                      value)]
                                                              .toString())),
                                                          DataCell(Text(App_Name[
                                                                  int.parse(
                                                                      value)]
                                                              .toString())),
                                                          DataCell(Text(App_Date[
                                                                  int.parse(
                                                                      value)]
                                                              .toString())),
                                                          DataCell(Text(
                                                              field_status[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                          DataCell(Text(AssignOfficer(
                                                              is_form_two[int.parse(
                                                                      value)] ??
                                                                  false,
                                                              assigned_deputy2_by_id[
                                                                  int.parse(
                                                                      value)],
                                                              assigned_deputy1_by_id[
                                                                  int.parse(
                                                                      value)],
                                                              log_updated_by_use[
                                                                  int.parse(
                                                                      value)]))),
                                                          DataCell(Text(is_form_two[
                                                                      int.parse(
                                                                          value)] ==
                                                                  true
                                                              ? "Notified"
                                                              : "Non-Notified")),
                                                          DataCell(Text(
                                                              Tp_Number[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                          DataCell(
                                                            Visibility(
                                                              visible: true,
                                                              child: IconButton(
                                                                icon: Icon(Icons
                                                                    .visibility),
                                                                color:
                                                                    Colors.blue,
                                                                onPressed: () {
                                                                  if (userGroup ==
                                                                      userGroup) {
                                                                    String IDS =
                                                                        Ids[int.parse(value)]
                                                                            .toString();
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (_) => ViewApplication(
                                                                                sessionToken: sessionToken,
                                                                                userGroup: userGroup,
                                                                                userId: userId,
                                                                                Ids: IDS,
                                                                                Range: Range,
                                                                                userName: userName,
                                                                                userEmail: userEmail)));
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          DataCell(Text(Remark[
                                                                  int.parse(
                                                                      value)]
                                                              .toString())),
                                                          DataCell(Text(OfficerDate(
                                                                  Current_status[
                                                                      int.parse(
                                                                          value)],
                                                                  verify_office_date[
                                                                      int.parse(
                                                                          value)],
                                                                  division_date[
                                                                      int.parse(
                                                                          value)],
                                                                  range_officer_date[
                                                                      int.parse(
                                                                          value)],
                                                                  deputy_officer_date[
                                                                      int.parse(
                                                                          value)],
                                                                  verify_office_date[
                                                                      int.parse(
                                                                          value)])
                                                              .toString())),
                                                          DataCell(
                                                            Visibility(
                                                              child: IconButton(
                                                                icon: Icon(Icons
                                                                    .location_on_rounded),
                                                                color:
                                                                    Colors.blue,
                                                                onPressed:
                                                                    () async {
                                                                  await launch("https://timber.forest.kerala.gov.in/app/location_views/" +
                                                                      replaceSlashesWithDashes(
                                                                          App_no[
                                                                              int.parse(value)]) +
                                                                      "/");
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                                .toList(),
                                      ),
                                    ),
                                  ))));
                    } else if (tab == 2) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.79,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
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
                                            columnSpacing: 30,
                                            dividerThickness: 2,
                                            headingRowColor:
                                                WidgetStateColor.resolveWith(
                                                    (states) => Colors.green),
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  'S.No',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Application\n       No',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              DataColumn(
                                                  label: Text(
                                                'Application\n     Name',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Application\n      Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Current Status',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Notified / Non-Notified\n     Villages',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Approved\n     Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Action',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                '  Download\nCutting Pass',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Remark',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Remark\n  Date',
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
                                                sr1 // Loops through dataColumnText, each iteration assigning the value to element
                                                    .map(
                                                      ((value) => DataRow(
                                                            cells: <DataCell>[
                                                              DataCell((Text((int
                                                                          .parse(
                                                                              value) +
                                                                      1)
                                                                  .toString()))),
                                                              DataCell(Text(App_no1[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(App_Name1[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(App_Date1[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(field_status1[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(is_form_two1[
                                                                          int.parse(
                                                                              value)] ==
                                                                      true
                                                                  ? "   Notified  "
                                                                  : "  Non-Notified  ")),
                                                              DataCell(Text(Tp_Number1[int.parse(
                                                                              value)]
                                                                          .toString()
                                                                          .length ==
                                                                      '0'
                                                                  ? "N/A"
                                                                  : Approved_date1[int.parse(value)]
                                                                              .toString() !=
                                                                          'null'
                                                                      ? Approved_date1[
                                                                              int.parse(value)]
                                                                          .toString()
                                                                      : "N/A")),
                                                              DataCell(
                                                                Visibility(
                                                                  visible: true,
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(Icons
                                                                        .visibility),
                                                                    color: Colors
                                                                        .blue,
                                                                    onPressed:
                                                                        () {
                                                                      if (userGroup ==
                                                                          userGroup) {
                                                                        String
                                                                            IDS =
                                                                            Ids1[int.parse(value)].toString();
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (_) => ViewApplication(sessionToken: sessionToken, userGroup: userGroup, userId: userId, Ids: IDS, Range: Range, userName: userName, userEmail: userEmail)));
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                (Current_status1[int.parse(value)]
                                                                            .toString() ==
                                                                        'R')
                                                                    ? SizedBox
                                                                        .shrink()
                                                                    : Visibility(
                                                                        visible:
                                                                            (Current_status1[int.parse(value)].toString() ==
                                                                                'A'),
                                                                        child:
                                                                            IconButton(
                                                                          icon:
                                                                              Icon(Icons.file_download),
                                                                          color:
                                                                              Colors.blue,
                                                                          onPressed:
                                                                              () {
                                                                            downloadFormIPdf(
                                                                              int.parse(Ids1[int.parse(value)].toString()),
                                                                              is_form_two1[int.parse(value)],
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                              ),
                                                              DataCell(Text(Remark[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(OfficerDate(
                                                                      Current_status1[
                                                                          int.parse(
                                                                              value)],
                                                                      verify_office_date1[
                                                                          int.parse(
                                                                              value)],
                                                                      division_date1[
                                                                          int.parse(
                                                                              value)],
                                                                      range_officer_date1[
                                                                          int.parse(
                                                                              value)],
                                                                      deputy_officer_date1[
                                                                          int.parse(
                                                                              value)],
                                                                      verify_office_date1[
                                                                          int.parse(
                                                                              value)])
                                                                  .toString())),
                                                              DataCell(
                                                                Visibility(
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(Icons
                                                                        .location_on_rounded),
                                                                    color: Colors
                                                                        .blue,
                                                                    onPressed:
                                                                        () async {
                                                                      await launch("https://timber.forest.kerala.gov.in/app/location_views/" +
                                                                          replaceSlashesWithDashes(
                                                                              App_no1[int.parse(value)]) +
                                                                          "/");
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    )
                                                    .toList(),
                                          ))))));
                    } else if (tab == 3) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.79,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyan,
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
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
                                            sortColumnIndex: _currentSortColumn,
                                            sortAscending: _isAscending,
                                            columnSpacing: 20,
                                            dividerThickness: 2,
                                            headingRowColor:
                                                WidgetStateColor.resolveWith(
                                                    (states) => Colors.cyan),
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  'S.No',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                'Application\n      Name',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Application\n      Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Current Status',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Approved\n    Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Action',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Remark',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                              DataColumn(
                                                  label: Text(
                                                'Remark\n  Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                            ],
                                            rows:
                                                sr2 // Loops through dataColumnText, each iteration assigning the value to element
                                                    .map(
                                                      ((value) => DataRow(
                                                            cells: <DataCell>[
                                                              DataCell((Text((int
                                                                          .parse(
                                                                              value) +
                                                                      1)
                                                                  .toString()))),
                                                              DataCell(Text(App_no2[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(App_Name2[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(App_Date2[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(
                                                                  DeemedApproved2[
                                                                              int.parse(value)] ==
                                                                          true
                                                                      ? "Deemed Approved"
                                                                      : '')),
                                                              DataCell(Text(Approved_date2[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(
                                                                Visibility(
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(Icons
                                                                        .visibility),
                                                                    color: Colors
                                                                        .blue,
                                                                    onPressed:
                                                                        () {
                                                                      if (userGroup ==
                                                                          userGroup) {
                                                                        String
                                                                            IDS =
                                                                            Ids2[int.parse(value)].toString();
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (_) => ViewApplication(
                                                                                      sessionToken: sessionToken,
                                                                                      userGroup: userGroup,
                                                                                      userId: userId,
                                                                                      Ids: IDS,
                                                                                      userName: userName,
                                                                                      userEmail: userEmail,
                                                                                      Range: [],
                                                                                    )));
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(Text(Remark[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString())),
                                                              DataCell(Text(OfficerDate(
                                                                  Current_status2[
                                                                      int.parse(
                                                                          value)],
                                                                  verify_office_date2[
                                                                      int.parse(
                                                                          value)],
                                                                  division_date2[
                                                                      int.parse(
                                                                          value)],
                                                                  range_officer_date2[
                                                                      int.parse(
                                                                          value)],
                                                                  deputy_officer_date2[
                                                                      int.parse(
                                                                          value)],
                                                                  verify_office_date2[
                                                                      int.parse(
                                                                          value)]))),
                                                            ],
                                                          )),
                                                    )
                                                    .toList(),
                                          ))))));
                    } else if (tab == 4) {
                      if (userGroup == "forest range officer") {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.79,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
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
                                              sortColumnIndex:
                                                  _currentSortColumn,
                                              sortAscending: _isAscending,
                                              columnSpacing: 20,
                                              dividerThickness: 2,
                                              headingRowColor:
                                                  WidgetStateColor.resolveWith(
                                                      (states) => Colors.blue),
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    'S.No',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                DataColumn(
                                                    label: Text(
                                                  'Application \n   No',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  'Application \n   Date',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  ' Action ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                                DataColumn(
                                                    label: Text(
                                                  ' Location ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                              ],
                                              rows:
                                                  sr3 // Loops through dataColumnText, each iteration assigning the value to element
                                                      .map(
                                                        ((value) => DataRow(
                                                              cells: <DataCell>[
                                                                DataCell((Text(
                                                                    (int.parse(value) +
                                                                            1)
                                                                        .toString()))),
                                                                DataCell(Text(App_no3[
                                                                        int.parse(
                                                                            value)]
                                                                    .toString())),
                                                                DataCell(Text(App_Date3[
                                                                        int.parse(
                                                                            value)]
                                                                    .toString())),
                                                                DataCell(
                                                                  IconButton(
                                                                    icon: Icon(Icons
                                                                        .visibility),
                                                                    color: Colors
                                                                        .blue,
                                                                    onPressed:
                                                                        () {
                                                                      if (userGroup ==
                                                                          'forest range officer') {
                                                                        String
                                                                            IDS =
                                                                            Ids3[int.parse(value)].toString();
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (_) => transitViewAndApprove(
                                                                                      sessionToken: sessionToken,
                                                                                      userGroup: userGroup,
                                                                                      Ids: App_no3[int.parse(value)],
                                                                                      userName: userName,
                                                                                      userEmail: userEmail,
                                                                                    )));
                                                                      } else {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                "Approval and Rejection handle by range officer",
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .CENTER,
                                                                            timeInSecForIosWeb:
                                                                                8,
                                                                            backgroundColor:
                                                                                Colors.blue,
                                                                            textColor: Colors.white,
                                                                            fontSize: 18.0);
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                  Visibility(
                                                                    child:
                                                                        IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .location_on_rounded),
                                                                      color: Colors
                                                                          .blue,
                                                                      onPressed:
                                                                          () async {
                                                                        await launch("https://timber.forest.kerala.gov.in/app/location_views/" +
                                                                            replaceSlashesWithDashes(App_no3[int.parse(value)]) +
                                                                            "/");
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      )
                                                      .toList(),
                                            ))))));
                      } else {
                        return Container();
                      }
                    }
                    return Container();
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context,
      {required String label,
      required double value,
      required Color color,
      required double max}) {
    const double barMaxHeight = 150; // Increased height
    final double barHeight = max == 0 ? 0 : (value / max) * barMaxHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toStringAsFixed(1) + '%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 50,
          height: barHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void permission() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }
  }
}
