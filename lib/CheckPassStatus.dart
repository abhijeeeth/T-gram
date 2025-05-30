import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io'
    show
        Directory,
        File,
        FileMode,
        HttpClient,
        HttpClientRequest,
        HttpClientResponse,
        Platform;
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schedulers/schedulers.dart';
import 'package:tigramnks/ViewApplication.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckPassStatus extends StatefulWidget {
  String sessionToken;
  String userName;
  String userEmail;
  String userGroup;
  int userId;
  CheckPassStatus(
      {required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userGroup,
      required this.userId});
  @override
  _CheckPassStatusState createState() => _CheckPassStatusState(
      sessionToken, userName, userEmail, userGroup, userId);
}

class _CheckPassStatusState extends State<CheckPassStatus> {
  String sessionToken;
  String userName;
  String userEmail;
  String userGroup;
  int userId;

  _CheckPassStatusState(this.sessionToken, this.userName, this.userEmail,
      this.userGroup, this.userId);
  final imageUrl = "${ServerHelper.baseUrl}auth/new_transit_pass_pdf/90/";
  final scheduler = LazyScheduler(latency: Duration(seconds: 1));

  // List<Status> status = <Status>[];
  // StatusDataSource statusDataSource;

  bool downloading = true;
  String downloadingStr = "No data";
  double download = 0.0;
  late File f;

  Future downloadFile() async {
    try {
      Dio dio = Dio();
      var dir = await getApplicationDocumentsDirectory();
      f = File("${dir.path}/myimagepath.jpg");
      String fileName = imageUrl;
      dio.download(imageUrl, "${dir.path}/$fileName",
          onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          download = (rec / total) * 100;
          downloadingStr =
              "Downloading Image : " + (download).toStringAsFixed(0);
        });

        setState(() {
          downloading = false;
          downloadingStr = "Completed";
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    check_pass();
    // NocForm();
    cut_pass();

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  String IDS = "";

  int progress = 0;

  ReceivePort _receivePort = ReceivePort();
  Future<void> downloadFormIIPdf(int appId, String notified) async {
    // If not Android, show message and exit function
    if (!Platform.isAndroid) {
      // Fluttertoast.showToast(
      //     msg: "Downloads are only supported on Android devices");
      return;
    }

    String url = notified == 'Yes'
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
            '${appDocDir.path}/FormI_${appId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final File file = File(filePath);

        await file.writeAsBytes(response.bodyBytes);

        // Try to open the file using open_filex
        final result = await OpenFilex.open(filePath);
        log("File opened with result: ${result.message}");

        // Move file to appropriate directory based on the platform
        if (Platform.isAndroid) {
          await moveFileToDownloads(filePath); // Move to Downloads for Android
          //Fluttertoast.showToast(msg: "PDF downloaded to Downloads folder");
        } else if (Platform.isIOS) {
          await moveFileToDocuments(filePath); // Save to Documents for iOS
          // Fluttertoast.showToast(msg: "PDF saved to Documents folder");
        } else {
          log("Unknown platform: PDF saved to app directory");
          //Fluttertoast.showToast(msg: "PDF saved to app directory");
        }
      }
    } catch (e) {
      log('Error during PDF download: $e');
      //  Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  Future<void> downloadFormIPdf(
    String appId,
  ) async {
    // If not Android, show message and exit function
    if (!Platform.isAndroid) {
      // Fluttertoast.showToast(
      //     msg: "Downloads are only supported on Android devices");
      return;
    }

    String url = '${ServerHelper.baseUrl}auth/generate_transit_pass_pdf/';

    try {
      // Request storage permissions

      // Make API request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: jsonEncode({'transit_number': appId}),
      );

      log('PDF download response body: ${response.body}');

      if (response.statusCode == 200) {
        // Save PDF to app's internal documents directory first
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String filePath =
            '${appDocDir.path}/FormI_${appId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final File file = File(filePath);

        await file.writeAsBytes(response.bodyBytes);

        // Try to open the file using open_filex
        final result = await OpenFilex.open(filePath);
        log("File opened with result: ${result.message}");

        // Move file to appropriate directory based on the platform
        if (Platform.isAndroid) {
          await moveFileToDownloads(filePath); // Move to Downloads for Android
          // Fluttertoast.showToast(msg: "PDF downloaded to Downloads folder");
        } else if (Platform.isIOS) {
          await moveFileToDocuments(filePath); // Save to Documents for iOS
          // Fluttertoast.showToast(msg: "PDF saved to Documents folder");
        } else {
          log("Unknown platform: PDF saved to app directory");
          // Fluttertoast.showToast(msg: "PDF saved to app directory");
        }
      }
    } catch (e) {
      log('Error during PDF download: $e');
      // Fluttertoast.showToast(msg: "Error: $e");
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

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");
    if (sendPort != null) {
      sendPort.send([id, status, progress]);
    }
  }

  void _requestDownload(String link) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final localPath = await getExternalStorageDirectory();
      if (localPath != null) {
        final Id = await FlutterDownloader.enqueue(
          url: link,
          savedDir: localPath.path,
          showNotification: true,
          openFileFromNotification: true,
        );
        print(localPath.path);
      } else {
        print("External storage directory is null");
      }
    } else {
      print("Permission deined");
    }
  }

  void _requestDownload1(String link) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final localPath = await getExternalStorageDirectory();
      if (localPath != null) {
        final Id1 = await FlutterDownloader.enqueue(
          url: link,
          savedDir: localPath.path,
          showNotification: true,
          // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
        );
        print(localPath.path);
      } else {
        print("External storage directory is null");
      }
    } else {
      print("Permission deined");
    }
  }

  final List Ids_0 = [];
  final List sr_0 = [];
  final List App_no_0 = [];
  final List App_Date_0 = [];
  final List App_Status_0 = [];
  final List Current_status_0 = [];
  final List Remark_0 = [];
  List list_0 = [];

  int allApplication_0 = 0;
  void cut_pass() async {
    sr_0.clear();
    App_no_0.clear();
    App_Date_0.clear();
    Current_status_0.clear();
    App_Status_0.clear();
    Remark_0.clear();

    const String url = '${ServerHelper.baseUrl}auth/GetTransitPasses';

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON_0 = json.decode(response.body);

    list_0 = responseJSON_0["transits"];

    setState(() {
      print("LENGTHH T $allApplication_0");
      allApplication_0 = list_0.length;
      print("LENGTHH T $allApplication_0");
    });
    for (var i = 0; i < allApplication_0; i++) {
      sr_0.add((i).toString());
      Ids_0.add(list_0[i]['app_form'].toString());
      App_no_0.add(list_0[i]['transit_number']);
      App_Date_0.add(list_0[i]['created_date'].toString());
      App_Status_0.add(list_0[i]['transit_status'].toString());
      Current_status_0.add(list_0[i]['created_date'].toString());
      Remark_0.add(list_0[i]['remarks'].toString());
    }
  }

  final List Ids = [];
  final List sr = [];
  final List App_no = [];
  final List App_Date = [];
  final List App_Status = [];
  final List Current_status = [];
  final List Tp_status = [];
  final List Tp_Issue_Date = [];
  final List Tp_Number = [];
  final List days_left_transit = [];
  final List Remark = [];
  final List Action = [''];
  List list = [];
  final List verify_range = [];
  final List depty_range_officer = [];
  final List verify_range_officer = [];
  final List tp_expiry_date = [];

  //------------
  final List reason_office = [];
  final List reason_depty_ranger_office = [];
  final List reason_range_officer = [];
  final List disapproved_reason = [];

  final List division = [];
  final List other_State = [];
  final List division_date = [];
  final List reason_division = [];
  final List is_form_two = [];

  final List verify_deputy2 = [];
  final List reason_deputy2 = [];
  final List deputy2_date = [];

  final List assigned_deputy1_by_id = [];
  final List assigned_deputy2_by_id = [];
  final List log_updated_by_use = [];
  final List verify_forest1 = [];
  final List user_Loc = [];
  final List recomend_Officer = [];
  final List field_status = [];
  final List current_status_1 = [];
  //------------
  late Map<String, dynamic> responseJSON;
  int allApplication = 0;
  void check_pass() async {
    //----clear----
    sr.clear();
    App_no.clear();
    App_Date.clear();
    Current_status.clear();
    days_left_transit.clear();
    Action.clear();
    Remark.clear();
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
    user_Loc.clear();
    recomend_Officer.clear();
    field_status.clear();
    current_status_1.clear();
    //-----clear------

    const String url = '${ServerHelper.baseUrl}auth/GetCuttingPasses';

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);

    List list = responseJSON["applications"];

    setState(() {
      allApplication = list.length;
    });
    for (var i = 0; i < allApplication; i++) {
      sr.add((i).toString());
      Ids.add(list[i]['id']);
      App_no.add(list[i]['application_no']);
      App_Date.add(list[i]['created_date'].toString());
      App_Status.add(list[i]['application_status'].toString());
      Current_status.add(list[i]['created_date'].toString());
      Tp_status.add(list[i]['application_status'].toString());
      Tp_Issue_Date.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number.add(list[i]['transit_pass_id'].toString());
      days_left_transit.add(list[i]['transit_pass_created_date'].toString());
      verify_range.add(list[i]['verify_office']);
      depty_range_officer.add(list[i]['depty_range_officer']);
      verify_range_officer.add(list[i]['verify_range_officer']);
      tp_expiry_date.add(list[i]['tp_expiry_date']);
      // Action.add(list[i][''].toString());
      Remark.add(list[i]['reason_range_officer'].toString());
      reason_office.add(list[i]['reason_office']);
      reason_depty_ranger_office.add(list[i]['reason_depty_ranger_office']);
      reason_range_officer.add(list[i]['reason_range_officer']);
      disapproved_reason.add(list[i]['disapproved_reason']);
      user_Loc.add(list[i]['application_status']);
      division.add(list[i]['d']);
      reason_division.add(list[i]['reason_division_officer']);
      division_date.add(list[i]['division_officer_date']);
      recomend_Officer.add(list[i]['r']);
      other_State.add(list[i]['other_state']);
      is_form_two.add(list[i]['is_form_two']);

      verify_deputy2.add(list[i]['verify_deputy2']);
      reason_deputy2.add(list[i]['reason_deputy2']);
      deputy2_date.add(list[i]['deputy2_date']);

      assigned_deputy1_by_id.add(list[i]['assigned_deputy1_name']);
      assigned_deputy2_by_id.add(list[i]['assigned_deputy2_name']);
      log_updated_by_use.add(list[i]['log_updated_by_user']);
      verify_forest1.add(list[i]['verify_forest1']);
      field_status.add(list[i]['status'].toString());
      current_status_1.add(list[i]['current_app_status'].toString());
    }
  }

  //-------------------------Noc--Form------------------------------------
  //--------------------
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

    const String url = '${ServerHelper.baseUrl}auth/UserNocListApplication';
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);

    List list = responseJSON["data"];
    setState(() {
      allApplication3 = list.length;
    });
    for (var i = 0; i < allApplication3; i++) {
      sr3.add(i.toString());
      Ids3.add(list[i]['id'].toString());
      App_no3.add(list[i]['application_no']);
      App_Name3.add(list[i]['name'].toString());
      App_Date3.add(list[i]['created_date'].toString());
      Current_status3.add(list[i]['application_status'].toString());
      days_left_transit3.add(list[i]['application_status'].toString());
      Approved_date3.add(list[i]['verify_office_date'].toString());
      Action3.add(list[i][''].toString());
      Remark3.add(list[i]['reason_office'].toString());
      Remark_date3.add(list[i]['range_officer_date'].toString());
      Tp_Issue_Date3.add(list[i]['transit_pass_created_date'].toString());
      Tp_Number3.add(list[i]['transit_pass_created_date'].toString());
    }
  }

  String OfficerStatus(String user, String user_Locc, String recomend_r,
      String division, String status) {
    if (user == "user") {
      if (user_Locc == "L") {
        return "User Location pending";
      } else if (status == "true") {
        return "field varification completed ";
      } else {
        return "Deputy Officer Field Verification Pending";
      }
    } else if (recomend_r == null) {
      return "Range Officer Recommendation pending for\nField verification";
    } else if (division == null) {
      return "Division pending";
    } else {
      return "";
    }
  }

  String AssignOfficer(bool isForm2, String assign_deputy2,
      String assign_deputy1, bool log_updated_by_user) {
    if (isForm2 == true) {
      if (assign_deputy2 != null) {
        return assign_deputy2;
      } else if (assign_deputy1 != null) {
        if (log_updated_by_user == true) {
          return 'Yet to Assign for Stage 2';
        } else {
          return assign_deputy1;
        }
      } else {
        return 'Yet to Assign for Stage 1';
      }
    }
    return 'N/A'; // Default return value when isForm2 is false
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

  bool _isVisible = true;

  //void showToast() {
  //  if(Remark[int.parse(value)].toString()==null){
  //    _isVisible=false;
  // }
  //}
  var _sortAscending = true;
  var _sortColumnIndex = 0;
  int _currentSortColumn = 6;
  bool _isAscending = true;

  int _radioValue = 0;
  bool flag = true;
  var tab = 0;
  void _handleRadioValueChange(int? value) {
    if (value != null) {
      setState(() {
        _radioValue = value;
        if (_radioValue == 0) {
          tab = 0;
          flag = true;
          cut_pass();
        } else if (_radioValue == 1) {
          tab = 1;
          flag = true;
          check_pass();
        }
      });
    }
  }

  Future<bool> _onBackPressed() async {
    bool returnValue = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go to the Home page?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              returnValue = false; // User selects "NO"
              Navigator.of(context).pop();
            },
            child: const Text("NO"),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              returnValue = true; // User selects "YES"
              Navigator.of(context).pop();
            },
            child: const Text("YES"),
          ),
        ],
      ),
    );

    return returnValue;
  }

  GlobalKey myKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Forms'),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () {
            //       // Navigate back to HomePage and pass any data if needed
            //       Navigator.pop(context);
            //     },
            //   ),
            // ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: ToggleSwitch(
                    minWidth: MediaQuery.of(context).size.width,
                    initialLabelIndex: _radioValue,
                    cornerRadius: 8.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey[200],
                    inactiveFgColor: Colors.blue,
                    labels: const ['Transit \n Pass  ', ' Cutting \n Pass'],
                    activeBgColors: const [
                      [Colors.green],
                      [Colors.green]
                    ],
                    onToggle: _handleRadioValueChange,
                  ),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  if (tab == 0) {
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
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
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
                                                ' Transit \nPass No',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Application \n      Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'Current Status',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            DataColumn(
                                              label: Text(
                                                'Remark',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'Notified / Non-Notified\n     Villages',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            DataColumn(
                                                label: Text(
                                              'Download\n    TP',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'Download\n Report',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'Action',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            DataColumn(
                                                label: Text(
                                              'Location',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                          ],
                                          rows:
                                              sr_0 // Loops through dataColumnText, each iteration assigning the value to element
                                                  .map(
                                                    ((value) => DataRow(
                                                          cells: <DataCell>[
                                                            DataCell((Text((int
                                                                        .parse(
                                                                            value) +
                                                                    1)
                                                                .toString()))), //Extracting from Map element the value
                                                            DataCell(Text(App_no_0[
                                                                    int.parse(
                                                                        value)]
                                                                .toString())),
                                                            DataCell(Text(
                                                                App_Date_0[
                                                                    int.parse(
                                                                        value)])),
                                                            // DataCell(Text(
                                                            //     App_Status_0[
                                                            //             int.parse(
                                                            //                 value)]
                                                            //         .toString())),

                                                            DataCell(
                                                              Text(Remark_0[
                                                                  int.parse(
                                                                      value)]),
                                                            ),
                                                            // DataCell(Text("")),
                                                            DataCell(
                                                              //blimga
                                                              Visibility(
                                                                visible: (App_Status_0[int.parse(value)]
                                                                            .toString() ==
                                                                        'Approved')
                                                                    ? true
                                                                    : false,
                                                                child:
                                                                    IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .file_download),
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      () {
                                                                    downloadFormIPdf(
                                                                      App_no_0[int.parse(
                                                                              value)]
                                                                          .toString(),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            // DataCell(
                                                            //   Visibility(
                                                            //     visible: (App_Status_0[int.parse(value)]
                                                            //                 .toString() ==
                                                            //             'Approved')
                                                            //         ? true
                                                            //         : false,
                                                            //     child:
                                                            //         IconButton(
                                                            //       icon: new Icon(
                                                            //           Icons
                                                            //               .file_download),
                                                            //       color: Colors
                                                            //           .blue,
                                                            //       onPressed:
                                                            //           () async {
                                                            //         // _downloadFile(down,"TransitPass.pdf");
                                                            //         //   downloadFile();
                                                            //         await launch("${ServerHelper.baseUrl}auth/new_user_report/" +
                                                            //             App_no_0[
                                                            //                 int.parse(value)] +
                                                            //             "/");
                                                            //       },
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // DataCell(
                                                            //   Visibility(
                                                            //     visible: true,
                                                            //     child:
                                                            //         IconButton(
                                                            //       icon: new Icon(
                                                            //           Icons
                                                            //               .visibility),
                                                            //       color: Colors
                                                            //           .blue,
                                                            //       onPressed:
                                                            //           () async {
                                                            //         if (userGroup ==
                                                            //             'user') {
                                                            //           IDS = (Ids_0[
                                                            //                   int.parse(value)]
                                                            //               .toString());

                                                            //           await Navigator.push(
                                                            //               context,
                                                            //               MaterialPageRoute(
                                                            //                   builder: (_) => ViewApplication(
                                                            //                         sessionToken: sessionToken,
                                                            //                         userGroup: userGroup,
                                                            //                         Ids: IDS,
                                                            //                         userName: userName,
                                                            //                         userEmail: userEmail,
                                                            //                         userId: userId,
                                                            //                       )));
                                                            //         }
                                                            //       },
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            DataCell(
                                                              Visibility(
                                                                child:
                                                                    IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .location_on_rounded),
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      () async {
                                                                    await launch("https://timber.forest.kerala.gov.in/app/location_views/" +
                                                                        Ids_0[int.parse(
                                                                            value)] +
                                                                        "/");
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
                  } else if (tab == 1) {
                    // if (tab == 0) {
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
                                          sortColumnIndex: _currentSortColumn,
                                          sortAscending: _isAscending,
                                          dividerThickness: 2,
                                          columnSpacing: 20,
                                          showBottomBorder: true,
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.green),
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
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Application \n      Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            DataColumn(
                                                label: Text(
                                              'Application\n     Status',
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
                                            // DataColumn(
                                            //     label: Text(
                                            //   'Deputy Officer \n Assignment status',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'TP Status',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'TP Issuing\n      Date',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            // DataColumn(
                                            //   label: Text(
                                            //     'TP No',
                                            //     style: TextStyle(
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.white),
                                            //   ),
                                            // ),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'No.of days left\n   for Transit',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            // DataColumn(
                                            //   label: Text(
                                            //     'Remark',
                                            //     style: TextStyle(
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.white),
                                            //   ),
                                            // ),
                                            DataColumn(
                                                label: Text(
                                              'Notified / Non-Notified\n     Villages',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              'Download\n    CP',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                            // DataColumn(
                                            //     label: Text(
                                            //   'Download\n Report',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Colors.white),
                                            // )),
                                            DataColumn(
                                                label: Text(
                                              'Action',
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
                                                            DataCell((Text((int
                                                                        .parse(
                                                                            value) +
                                                                    1)
                                                                .toString()))), //Extracting from Map element the value
                                                            DataCell(Text(App_no[
                                                                    int.parse(
                                                                        value)]
                                                                .toString())),
                                                            DataCell(Text(App_Date[
                                                                    int.parse(
                                                                        value)]
                                                                .toString())),
                                                            DataCell(Text(App_Status[int.parse(
                                                                            value)]
                                                                        .toString() ==
                                                                    'A'
                                                                ? "Approved"
                                                                : App_Status[int.parse(value)]
                                                                            .toString() ==
                                                                        'S'
                                                                    ? "Submitted"
                                                                    : App_Status[int.parse(value)].toString() ==
                                                                            'R'
                                                                        ? "Rejected"
                                                                        : App_Status[int.parse(value)].toString() ==
                                                                                'RT'
                                                                            ? "Returned"
                                                                            : App_Status[int.parse(value)].toString() == 'A'
                                                                                ? "Accepted"
                                                                                : "Pending")),
                                                            DataCell(Text(
                                                                current_status_1[
                                                                        int.parse(
                                                                            value)]
                                                                    .toString()

                                                                // OfficerStatus(
                                                                //   userGroup,
                                                                //   user_Loc[int.parse(
                                                                //           value)]
                                                                //       .toString(),
                                                                //   recomend_Officer[
                                                                //           int.parse(
                                                                //               value)]
                                                                //       .toString(),
                                                                //   division[int.parse(
                                                                //           value)]
                                                                //       .toString(),
                                                                //   field_status[int
                                                                //           .parse(
                                                                //               value)]
                                                                //       .toString(),
                                                                // ),
                                                                )),

                                                            // DataCell(Text(OfficerStatus(
                                                            //     division[int.parse(
                                                            //         value)],
                                                            //     verify_range[int.parse(
                                                            //         value)],
                                                            //     depty_range_officer[
                                                            //         int.parse(
                                                            //             value)],
                                                            //     verify_range_officer[
                                                            //         int.parse(
                                                            //             value)],
                                                            //     Current_status[int.parse(value)]
                                                            //         .toString(),
                                                            //     user_Loc[int.parse(value)]
                                                            //         .toString(),
                                                            //     other_State[int.parse(
                                                            //         value)],
                                                            //     verify_deputy2[
                                                            //         int.parse(
                                                            //             value)],
                                                            //     log_updated_by_use[
                                                            //         int.parse(value)],
                                                            //     verify_forest1[int.parse(value)]))),
                                                            // DataCell(Text(AssignOfficer(
                                                            //             is_form_two[
                                                            //                 int.parse(
                                                            //                     value)],
                                                            //             assigned_deputy2_by_id[
                                                            //                 int.parse(
                                                            //                     value)],
                                                            //             assigned_deputy1_by_id[
                                                            //                 int.parse(
                                                            //                     value)],
                                                            //             log_updated_by_use[
                                                            //                 int.parse(
                                                            //                     value)]) ==
                                                            //         null
                                                            //     ? "N/A"
                                                            //     : AssignOfficer(
                                                            //             is_form_two[
                                                            //                 int.parse(
                                                            //                     value)],
                                                            //             assigned_deputy2_by_id[
                                                            //                 int.parse(
                                                            //                     value)],
                                                            //             assigned_deputy1_by_id[
                                                            //                 int.parse(
                                                            //                     value)],
                                                            //             log_updated_by_use[
                                                            //                 int.parse(
                                                            //                     value)])
                                                            //         .toString())),
                                                            // DataCell(Text(Tp_status[int.parse(
                                                            //                 value)]
                                                            //             .toString() ==
                                                            //         'A'
                                                            //     ? "Approved"
                                                            //     : Tp_status[int.parse(value)]
                                                            //                 .toString() ==
                                                            //             'S'
                                                            //         ? "Submitted"
                                                            //         : Tp_status[int.parse(value)].toString() ==
                                                            //                 'R'
                                                            //             ? "Rejected"
                                                            //             : "Pending")),
                                                            // DataCell(Text(Tp_Number[int.parse(
                                                            //                 value)]
                                                            //             .toString() ==
                                                            //         '0'
                                                            //     ? "Not Generated"
                                                            //     : Tp_Issue_Date[
                                                            //             int.parse(
                                                            //                 value)]
                                                            //         .toString())),
                                                            // DataCell(Text(Tp_Number[int.parse(
                                                            //                 value)]
                                                            //             .toString() ==
                                                            //         '0'
                                                            //     ? "Not Generated"
                                                            //     : Tp_Number[int
                                                            //             .parse(
                                                            //                 value)]
                                                            //         .toString())),
                                                            // DataCell(Text(Tp_Number[int.parse(
                                                            //                 value)]
                                                            //             .toString() ==
                                                            //         '0'
                                                            //     ? "  N/A  "
                                                            //     : "   " +
                                                            //         daysBetween(
                                                            //                 DateTime.parse(Tp_Issue_Date[int.parse(value)].toString()))
                                                            //             .toString())),
                                                            // DataCell(
                                                            //   Text("remark"),
                                                            //   // Text(OfficerRemark(
                                                            //   //   Current_status[
                                                            //   //       int.parse(
                                                            //   //           value)],
                                                            //   //   disapproved_reason[
                                                            //   //       int.parse(
                                                            //   //           value)],
                                                            //   //   reason_division[
                                                            //   //       int.parse(
                                                            //   //           value)],
                                                            //   //   reason_range_officer[
                                                            //   //       int.parse(
                                                            //   //           value)],
                                                            //   //   reason_depty_ranger_office[
                                                            //   //       int.parse(
                                                            //   //           value)],
                                                            //   //   reason_office[
                                                            //   //       int.parse(
                                                            //   //           value)]))
                                                            // ),

                                                            DataCell(Text(is_form_two[
                                                                        int.parse(
                                                                            value)] ==
                                                                    true
                                                                ? "Notified"
                                                                : "Non-Notified")),
                                                            DataCell(
                                                              Visibility(
                                                                visible:
                                                                    (App_Status[int.parse(value)].toString() ==
                                                                            'A')
                                                                        ? true
                                                                        : false,
                                                                child:
                                                                    IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .file_download),
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      () {
                                                                    downloadFormIIPdf(
                                                                      int.parse(
                                                                          Ids[int.parse(value)]
                                                                              .toString()),
                                                                      Tp_status[
                                                                          int.parse(
                                                                              value)],
                                                                    );
                                                                    // await launch("${ServerHelper.baseUrl}auth/new_transit_pass_pdf/" +
                                                                    //     Ids[int.parse(
                                                                    //         value)] +
                                                                    //     "/");
                                                                    // _requestDownload("http://www.orimi.com/pdf-test.pdf");
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            // DataCell(
                                                            //   Visibility(
                                                            //     visible:
                                                            //         (App_Status[int.parse(value)].toString() ==
                                                            //                 'A')
                                                            //             ? true
                                                            //             : false,
                                                            //     child:
                                                            //         IconButton(
                                                            //       icon: new Icon(
                                                            //           Icons
                                                            //               .file_download),
                                                            //       color: Colors
                                                            //           .blue,
                                                            //       onPressed:
                                                            //           () async {
                                                            //         await launch("${ServerHelper.baseUrl}auth/new_user_report/" +
                                                            //             Ids[int.parse(
                                                            //                 value)] +
                                                            //             "/");
                                                            //       },
                                                            //     ),
                                                            //   ),
                                                            // ),

                                                            DataCell(
                                                              Visibility(
                                                                visible: true,
                                                                child:
                                                                    IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .visibility),
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      () async {
                                                                    if (userGroup ==
                                                                        'user') {
                                                                      IDS = (Ids[
                                                                              int.parse(value)]
                                                                          .toString());

                                                                      await Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (_) => ViewApplication(sessionToken: sessionToken, userGroup: userGroup, Ids: IDS, userName: userName, userEmail: userEmail, userId: userId, Range: [] // Add the required Range parameter
                                                                                  )));
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            DataCell(
                                                              Visibility(
                                                                child:
                                                                    IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .location_on_rounded),
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      () async {
                                                                    await launch("https://timber.forest.kerala.gov.in/app/location_views/" +
                                                                        Ids[int.parse(
                                                                            value)] +
                                                                        "/");
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
                  } else {
                    // Default case when tab is neither 0 nor 1
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.79,
                      child: Center(
                        child: Text("No data available"),
                      ),
                    );
                  }
                }),
              ],
            ),
          )),
    );
  }
}
