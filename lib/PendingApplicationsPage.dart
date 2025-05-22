// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/ViewApplication.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingApplicationsPage extends StatefulWidget {
  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userGroup;
  List Range;

  PendingApplicationsPage({
    super.key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.sessionToken,
    required this.userGroup,
    required this.Range,
  });

  @override
  _PendingApplicationsPageState createState() => _PendingApplicationsPageState(
      userId, userName, userEmail, sessionToken, userGroup, Range);
}

class _PendingApplicationsPageState extends State<PendingApplicationsPage> {
  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userGroup;
  List Range;
  bool isLoading = true;

  _PendingApplicationsPageState(this.userId, this.userName, this.userEmail,
      this.sessionToken, this.userGroup, this.Range);

  @override
  void initState() {
    super.initState();
    print("Initializing Pending Applications Page");
    print("User ID: $userId");
    fetchPendingApplications();
  }

  // Lists to store pending application data
  final List Ids = [];
  final List sr = [];
  final List App_no = [];
  final List App_Name = [];
  final List App_Date = [];
  final List Current_status = [];
  final List days_left_transit = [];
  final List Approved_date = [];
  final List Action = [];
  final List reason_office = [];
  final List reason_depty_ranger_office = [];
  final List reason_range_officer = [];
  final List disapproved_reason = [];
  final List reason_division = [];
  final List verify_office_date = [];
  final List deputy_officer_date = [];
  final List range_officer_date = [];
  final List division_date = [];
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
  final List field_status = [];
  final List status = []; // Added to store status field

  // Add a list to store indices of applications with status == false
  final List<int> filteredIndices = [];

  int allApplication = 0;
  int filteredApplicationCount = 0; // Track count of filtered applications

  // Fetch pending applications data
  Future<void> fetchPendingApplications() async {
    setState(() {
      isLoading = true;
    });

    // Clear all lists before fetching new data
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
    status.clear(); // Clear the status list
    filteredIndices.clear(); // Clear filtered indices

    print("Fetching Pending Applications");
    const String url = '${ServerHelper.baseUrl}auth/PendingListViewApplication';

    try {
      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "token $sessionToken"
      });

      Map<String, dynamic> responseJSON = json.decode(response.body);
      log("Pending Application Response:");
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
        is_form_two.add(list[i]['is_form_two']);
        assigned_deputy1_by_id.add(list[i]['assigned_deputy1_name']);
        assigned_deputy2_by_id.add(list[i]['assigned_deputy2_name']);
        log_updated_by_use.add(list[i]['log_updated_by_user']);
        verify_forest1.add(list[i]['verify_forest1']);
        status.add(list[i]['status']); // Added to capture status field

        // Add index to filtered list if status is false
        if (list[i]['status'] == false) {
          filteredIndices.add(i);
        }
      }
      setState(() {
        isLoading = false;
        filteredApplicationCount = filteredIndices.length;
      });
    } catch (e) {
      log("Error fetching pending applications: $e");
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Failed to load pending applications",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // Helper functions
  String replaceSlashesWithDashes(String input) {
    return input.replaceAll('/', '-');
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

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pending Applications",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 110, 99),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchPendingApplications,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredApplicationCount == 0
              ? Center(
                  child: Text(
                    "No pending applications found",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
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
                            rows: filteredIndices
                                .map(((index) => DataRow(
                                      cells: <DataCell>[
                                        DataCell((Text(
                                            (filteredIndices.indexOf(index) + 1)
                                                .toString()))),
                                        DataCell(
                                            Text(App_no[index].toString())),
                                        DataCell(
                                            Text(App_Name[index].toString())),
                                        DataCell(
                                            Text(App_Date[index].toString())),
                                        DataCell(Text(
                                            field_status[index].toString())),
                                        DataCell(Text(AssignOfficer(
                                            is_form_two[index] ?? false,
                                            assigned_deputy2_by_id[index],
                                            assigned_deputy1_by_id[index],
                                            log_updated_by_use[index]))),
                                        DataCell(Text(is_form_two[index] == true
                                            ? "Notified"
                                            : "Non-Notified")),
                                        DataCell(
                                            Text(Tp_Number[index].toString())),
                                        DataCell(
                                          IconButton(
                                            icon: Icon(Icons.visibility),
                                            color: Colors.blue,
                                            onPressed: () {
                                              String IDS =
                                                  Ids[index].toString();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          ViewApplication(
                                                              sessionToken:
                                                                  sessionToken,
                                                              userGroup:
                                                                  userGroup,
                                                              userId: userId,
                                                              Ids: IDS,
                                                              Range: Range,
                                                              userName:
                                                                  userName,
                                                              userEmail:
                                                                  userEmail)));
                                            },
                                          ),
                                        ),
                                        DataCell(
                                            Text(Remark[index].toString())),
                                        DataCell(Text(OfficerDate(
                                                Current_status[index],
                                                verify_office_date[index],
                                                division_date[index],
                                                range_officer_date[index],
                                                deputy_officer_date[index],
                                                verify_office_date[index])
                                            .toString())),
                                        DataCell(
                                          IconButton(
                                            icon:
                                                Icon(Icons.location_on_rounded),
                                            color: Colors.blue,
                                            onPressed: () async {
                                              await launch(
                                                  "https://timber.forest.kerala.gov.in/app/location_views/" +
                                                      replaceSlashesWithDashes(
                                                          App_no[index]) +
                                                      "/");
                                            },
                                          ),
                                        ),
                                      ],
                                    )))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
