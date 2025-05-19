import 'dart:convert';
import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/ViewApplication1.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewApplication extends StatefulWidget {
  String userGroup;
  String sessionToken;
  int userId;
  final String Ids;
  List Range;
  String userName;
  String userEmail;

  ViewApplication(
      {super.key,
      required this.sessionToken,
      required this.userId,
      required this.userGroup,
      required this.Ids,
      required this.Range,
      required this.userName,
      required this.userEmail});
  @override
  _ViewApplicationState createState() => _ViewApplicationState(
      sessionToken, userId, userGroup, Ids, Range, userName, userEmail);
}

class _ViewApplicationState extends State<ViewApplication> {
  String sessionToken;
  String userGroup;
  int userId;
  final String Ids;
  List Range;
  String userName;
  String userEmail;
  _ViewApplicationState(this.sessionToken, this.userId, this.userGroup,
      this.Ids, this.Range, this.userName, this.userEmail);
  String url = '${ServerHelper.baseUrl}auth/ViewApplication';

  late bool verify_officer;
  late bool deputy_range_officer;
  late bool verify_range_officer;
  late bool is_form_two;
  late int assigned_deputy2_id;
  late int assigned_deputy1_id;
  late int assigned_range_id;
  late bool verify_deputy2;
  late bool division_officer;
  late bool other_state;
  late bool verify_forest1;
  late String field_requre;
  late bool field_status;

  String img_signature = '';
  String img_revenue_approval = '';
  String img_declaration = '';
  String img_revenue_application = '';
  String img_location_sktech = '';
  String img_tree_ownership_detail = '';
  String img_aadhar_detail = '';

  String vehical_reg_no = '';
  String driver_name = '';
  String driver_phone = '';
  String mode_of_transport = '';
  String license_image = '';
  late GoogleMapController mapController;

  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchApplicationData();
  }

  Future<void> _fetchApplicationData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await View_Record();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load application data: $e';
      });
      print("Error loading application data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List n_list = [];
  List Tree_species = [];
  final List species_nm = [];
  List treelog = [];
  List c = [];
  final List species = [];
  final List length = [];
  final List breadth = [];
  final List volume = [];
  final List latit = [];
  final List longit = [];

  final List s = [];
  final List Sname = [];
  final List Slat = [];
  final List Slong = [];
  final List Slen = [];
  final List Sbreath = [];
  final List Svol = [];

  // Add a list to hold additional documents
  List<Map<String, dynamic>> additionalDocuments = [];

  String Name = '';
  String Address = '';
  String SurveyNo = '';
  String VillageName = '';
  String OwnershipProof = '';
  String treeSpecies = '';
  String purpose = '';
  String proposed = '';
  int All_Record = 0;
  String user_Loc = "";

  View_Record() async {
    String url = '${ServerHelper.baseUrl}auth/ViewApplication';
    Map data = {"app_id": Ids};
    print(data);

    var body = json.encode(data);
    print(body);
    print(sessionToken);
    print("Session Token: $sessionToken");
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    print('Request URL: $url');
    print('Request Headers: ${{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    }}');
    print('Request Body: $body');
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------View -Application--------------");
    print(responseJSON);
    setState(() {
      try {
        Name =
            responseJSON['data']['applications'][0]['name']?.toString() ?? '';
        Address =
            responseJSON['data']['applications'][0]['address']?.toString() ??
                '';
        SurveyNo =
            responseJSON['data']['applications'][0]['survey_no']?.toString() ??
                '';
        VillageName =
            responseJSON['data']['applications'][0]['village']?.toString() ??
                '';
        OwnershipProof =
            responseJSON['data']['applications'][0]['name']?.toString() ?? '';
        treeSpecies = responseJSON['data']['applications'][0]
                    ['species_of_trees']
                ?.toString() ??
            '';

        purpose =
            responseJSON['data']['applications'][0]['purpose']?.toString() ??
                '';
        proposed = responseJSON['data']['applications'][0]
                    ['trees_proposed_to_cut']
                ?.toString() ??
            '';
        verify_officer =
            responseJSON['data']['applications'][0]['verify_office'] ?? false;
        user_Loc = responseJSON['data']['applications'][0]['application_status']
                ?.toString() ??
            '';
        deputy_range_officer = responseJSON['data']['applications'][0]
                ['depty_range_officer'] ??
            false;
        verify_range_officer = responseJSON['data']['applications'][0]
                ['verify_range_officer'] ??
            false;
        is_form_two =
            responseJSON['data']['applications'][0]['is_form_two'] ?? false;
        assigned_deputy2_id =
            responseJSON['data']['applications'][0]['r_id'] ?? 0;
        assigned_deputy1_id =
            responseJSON['data']['applications'][0]['d_id'] ?? 0;
        assigned_range_id =
            responseJSON['data']['applications'][0]['f_r_id'] ?? 0;
        verify_deputy2 =
            responseJSON['data']['applications'][0]['verify_deputy2'] ?? false;
        division_officer = responseJSON['data']['applications'][0]
                ['division_officer'] ??
            false;
        other_state =
            responseJSON['data']['applications'][0]['other_state'] ?? false;
        verify_forest1 =
            responseJSON['data']['applications'][0]['verify_forest1'] ?? false;
        field_requre = responseJSON['data']['applications'][0]
                    ['location_needed']
                ?.toString() ??
            '';
        field_status =
            responseJSON['data']['applications'][0]['status'] ?? false;
      } catch (e) {
        print("Error while accessing application data: $e");
      }

      try {
        if (responseJSON['data']['species_location'] != null) {
          for (int i = 0;
              i < responseJSON['data']['species_location'].length;
              i++) {
            s.add(i);
            Sname.add(responseJSON['data']['species_location'][i]
                        ['species_tree__name']
                    ?.toString() ??
                '');
            Slat.add(
                responseJSON['data']['species_location'][i]['latitude'] ?? 0.0);
            Slong.add(responseJSON['data']['species_location'][i]
                    ['longitude'] ??
                0.0);
            Slen.add(
                responseJSON['data']['species_location'][i]['length'] ?? 0.0);
            Sbreath.add(
                responseJSON['data']['species_location'][i]['breadth'] ?? 0.0);
            Svol.add(
                responseJSON['data']['species_location'][i]['volume'] ?? 0.0);
          }
        }
      } catch (e) {
        print("Error while accessing species location: $e");
      }

      // Parse additional_documents
      try {
        additionalDocuments = [];
        if (responseJSON['data']['additional_documents'] != null) {
          for (var doc in responseJSON['data']['additional_documents']) {
            additionalDocuments.add({
              'id': doc['id'],
              'app_form_id': doc['app_form_id'],
              'category': doc['category'],
              'document': doc['document'],
              'name': doc['name'],
              'uploaded_at': doc['uploaded_at'],
            });
          }
        }
        log.log("Additional Documents: $additionalDocuments.");
      } catch (e) {
        print("Error while accessing additional documents: $e");
      }
    });

    setState(() {
      try {
        img_signature =
            responseJSON['data']['image_documents'][0]['signature_img'] ?? '';
        img_revenue_approval = responseJSON['data']['image_documents'][0]
                ['revenue_approval'] ??
            '';
        img_declaration = responseJSON['data']['image_documents'][0]
                    ['declaration']
                ?.toString() ??
            '';
        img_revenue_application = responseJSON['data']['image_documents'][0]
                ['revenue_application'] ??
            '';
        img_location_sktech =
            responseJSON['data']['image_documents'][0]['location_sktech'] ?? '';
        img_tree_ownership_detail = responseJSON['data']['applications'][0]
                ['proof_of_ownership_of_tree'] ??
            '';
        img_aadhar_detail =
            responseJSON['data']['image_documents'][0]['aadhar_detail'] ?? '';
      } catch (e) {
        print("Error while accessing image documents: $e");
      }
    });

    Tree_species = treeSpecies.split(",");
    print("HHHHH $Tree_species");
    print(responseJSON['data']['timber_log'].length);
    for (int i = 0; i < responseJSON['data']['timber_log'].length; i++) {
      c.add(i);
      species.add(responseJSON['data']['timber_log'][i]['species_of_tree']);
      length.add(responseJSON['data']['timber_log'][i]['length']);
      breadth.add(responseJSON['data']['timber_log'][i]['breadth']);
      volume.add(responseJSON['data']['timber_log'][i]['volume']);
      latit.add(responseJSON['data']['timber_log'][i]['latitude']);
      longit.add(responseJSON['data']['timber_log'][i]['longitude']);
    }
    n_list = c;
    treelog = responseJSON['data']['timber_log'];
    log_details = treelog;

    if (responseJSON['data']['isvehicle'] != "Not Applicable") {
      vehical_reg_no =
          responseJSON['data']['vehicle']['vehicle_reg_no'].toString();
      driver_name = responseJSON['data']['vehicle']['driver_name'].toString();
      driver_phone = responseJSON['data']['vehicle']['driver_phone'].toString();
      mode_of_transport =
          responseJSON['data']['vehicle']['mode_of_transport'].toString();
      license_image =
          responseJSON['data']['vehicle']['license_image'].toString();
    }
  }

  bool X = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List values = [];
  Future<Widget> AddMap(BuildContext context) async {
    return await showDialog(
        context: this.context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                insetPadding: const EdgeInsets.only(
                    bottom: 30, top: 30, left: 10, right: 10),
                contentPadding: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(10.8505, 76.2711), zoom: 14),
                    onMapCreated: onMapCreated,
                    markers: markers.isEmpty
                        ? <Marker>{}
                        : Set<Marker>.of(markers.values),
                    onTap: (latlang) {
                      setState(() {
                        values.clear();
                        const MarkerId markerId = MarkerId('101');
                        Marker marker = Marker(
                          markerId: markerId,
                          draggable: true,
                          position: latlang,
                          infoWindow: InfoWindow(
                            title: "Tree Location",
                            snippet:
                                "( Latitude : ${latlang.latitude.toStringAsPrecision(8)} , Longitude : ${latlang.longitude.toStringAsPrecision(8)})",
                          ),
                          icon: BitmapDescriptor.defaultMarker,
                        );
                        setState(() {
                          markers[markerId] = marker;
                        });
                      });
                      values.add(latlang.latitude.toStringAsPrecision(8));
                      values.add(latlang.longitude.toStringAsPrecision(8));
                      mapController.animateCamera(
                          CameraUpdate.newLatLngZoom(latlang, 15.0));
                    },
                  ),
                ),
                title: const Text('Map'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      'OK ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onPressed: () {
                      setState(() {
                        X = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
        });
  }

  String GetLatLong() {
    return values.toString();
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  late String dropdownValue3;
  Map<String, TextEditingController> textEditingControllers = {};
  TextEditingController leng = TextEditingController();
  TextEditingController Girth = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  var b = 1;
  int a = 0;
  List log_details = [];
  List d = [];

  Map<String, String> logs = {};
  final List<TextEditingController> _controllers = [];
  late double v;

  double _getVolume(double girth, double length) {
    double girthInMeters = girth * 0.01;
    double radius = girthInMeters / (2 * pi);
    double volume = pi * pow(radius, 2) * length;

    return volume;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          dropdownValue3 = Tree_species.isNotEmpty ? Tree_species[0] : '';

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
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
                            dropdownValue3 = data;
                          });
                        },
                        items: Tree_species.toSet()
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
                          return value?.isNotEmpty == true
                              ? null
                              : "Enter Height";
                        },
                        decoration: const InputDecoration(
                            hintText: "Please Enter Height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Girth,
                        validator: (value) {
                          return value?.isNotEmpty == true
                              ? null
                              : "Enter girth";
                        },
                        decoration: const InputDecoration(
                            hintText: "Please Enter girth(cm)"),
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
                      "species_of_tree": dropdownValue3,
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
                    print(n);
                    for (int i = 0; i < n; i++) {
                      n_list.add(i);
                    }
                    if (_formKey.currentState!.validate()) {
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
          try {
            dropdownValue3 =
                log_details[index]['species_of_trees']?.toString() ??
                    log_details[index]['species_of_tree']?.toString() ??
                    '';
            leng.text = log_details[index]['length']?.toString() ?? '';
            Girth.text = log_details[index]['breadth']?.toString() ?? '';
            latitude.text = log_details[index]['latitude']?.toString() ?? '';
            longitude.text = log_details[index]['longitude']?.toString() ?? '';
          } catch (e) {
            print("Error setting EditInformationDialog fields: $e");
            dropdownValue3 = '';
            leng.text = '';
            Girth.text = '';
            latitude.text = '';
            longitude.text = '';
          }

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
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
                            dropdownValue3 = data;
                          });
                        },
                        items: Tree_species.toSet()
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
                            hintText: "Please Enter girth(cm)"),
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
                      "species_of_trees": dropdownValue3,
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
                    log_details[index] = logs;
                    int n = log_details.length;
                    n_list = [];
                    print(n);
                    for (int i = 0; i < n; i++) {
                      n_list.add(i);
                    }
                    if (_formKey.currentState!.validate()) {
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

  Future<bool> _onBackPressed() async {
    bool returnValue = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go to the previous page?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              returnValue = false;
              Navigator.of(context).pop();
            },
            child: const Text("NO"),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              returnValue = true;
              Navigator.of(context).pop();
            },
            child: const Text("YES"),
          ),
        ],
      ),
    );

    return returnValue;
  }

  bool Edit = false;
  bool userEdit = false;

  Widget _buildInfoField(String title, String content, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(icon, color: Colors.blue.shade700, size: 20),
              if (icon != null) const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.07),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              content.isNotEmpty ? content : "Not provided",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                color: content.isNotEmpty ? Colors.blue.shade700 : Colors.grey,
                fontSize: 15,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeciesTable() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8.0,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade700, Colors.orange.shade400],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.nature, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Text(
                  'Species Information',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 1,
              columnSpacing: 24,
              headingRowColor: WidgetStateProperty.all(Colors.blue.shade50),
              headingTextStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
                fontSize: 15,
              ),
              columns: const [
                DataColumn(label: Text('S.No')),
                DataColumn(label: Text('Species')),
                DataColumn(label: Text('Height(M)')),
                DataColumn(label: Text('GBH(cm)')),
                DataColumn(label: Text('Volume')),
              ],
              rows: c.map((value) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text((value + 1).toString())),
                    DataCell(Text(species[value].toString())),
                    DataCell(Text(length[value].toString())),
                    DataCell(Text(breadth[value].toString())),
                    DataCell(Text(volume[value].toString())),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableSpeciesTable() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8.0,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade400],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.edit, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Text(
                  'Edit Species Information',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.white),
                  onPressed: () async {
                    await showInformationDialog(context);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 1,
              columnSpacing: 24,
              headingRowColor: WidgetStateProperty.all(Colors.blue.shade50),
              headingTextStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
                fontSize: 15,
              ),
              columns: const [
                DataColumn(label: Text('S.No')),
                DataColumn(label: Text('Species')),
                DataColumn(label: Text('Height(M)')),
                DataColumn(label: Text('Girth(cm)')),
                DataColumn(label: Text('Volume')),
                DataColumn(label: Text('Actions')),
              ],
              rows: n_list.map((index) {
                return DataRow(
                  cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(SizedBox(
                      width: 180,
                      child: Text(
                        log_details[index]['species_of_tree']?.toString() ??
                            log_details[index]['species_of_trees']
                                ?.toString() ??
                            '',
                      ),
                    )),
                    DataCell(SizedBox(
                      width: 100,
                      child:
                          Text(log_details[index]['length']?.toString() ?? ''),
                    )),
                    DataCell(SizedBox(
                      width: 100,
                      child:
                          Text(log_details[index]['breadth']?.toString() ?? ''),
                    )),
                    DataCell(SizedBox(
                      width: 100,
                      child:
                          Text(log_details[index]['volume']?.toString() ?? ''),
                    )),
                    DataCell(Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await EditInformationDialog(context, index);
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Item'),
                                content: const Text(
                                    'Are you sure you want to delete this item?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      log_details.removeAt(index);
                                      n_list.removeLast();
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                textStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              icon: const Icon(Icons.save),
              label: const Text('SAVE CHANGES'),
              onPressed: () async {
                await _saveLogDetails();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDocuments() {
    if (additionalDocuments.isEmpty) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8.0,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade400],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.attach_file, color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Text(
                  'Additional Documents',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: additionalDocuments.length,
            itemBuilder: (context, index) {
              final doc = additionalDocuments[index];
              return ListTile(
                leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(doc['name'] ?? ''),
                subtitle: Text(doc['uploaded_at'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () async {
                    // Open PDF in browser or PDF viewer
                    final url =
                        '${ServerHelper.baseUrl}media/${doc['document']}';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Could not open document",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveLogDetails() async {
    if (log_details.isEmpty) {
      Fluttertoast.showToast(
        msg: "Log Details is Empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      const String url = '${ServerHelper.baseUrl}auth/UpdateTimberlog';
      Map data = {"app_id": Ids, "log_details": log_details};
      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);

      Fluttertoast.showToast(
        msg: responseJson['message'] ?? 'Update successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      setState(() {
        Edit = false;
        userEdit = false;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error saving data: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFB3E5FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Application View"),
            backgroundColor: HexColor("#0499f2"),
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
            ),
            actions: [
              if (userGroup == 'deputy range officer' || userGroup == 'user')
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (userGroup == 'deputy range officer') {
                        Edit = true;
                      } else if (userGroup == 'user') {
                        userEdit = true;
                      }
                    });
                  },
                ),
            ],
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.red, size: 60),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.refresh),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _fetchApplicationData,
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _fetchApplicationData,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.13),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.info_outline,
                                            color: Colors.blue, size: 22),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Application Details',
                                          style: GoogleFonts.roboto(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(thickness: 1.5),
                                    const SizedBox(height: 8),
                                    _buildInfoField('Name', Name,
                                        icon: Icons.person),
                                    _buildInfoField('Address', Address,
                                        icon: Icons.home),
                                    _buildInfoField(
                                        'List showing the species of tree or\ntrees proposed to be cut, etc.',
                                        treeSpecies,
                                        icon: Icons.nature),
                                    _buildInfoField(
                                        'Survey No. and extent of field',
                                        SurveyNo,
                                        icon: Icons.pin_drop),
                                    _buildInfoField(
                                        'Village/Taluka/Block and District',
                                        VillageName,
                                        icon: Icons.location_city),
                                    _buildInfoField(
                                        'Proof of ownership of the trees',
                                        OwnershipProof,
                                        icon: Icons.verified_user),
                                    _buildInfoField(
                                        'Purpose for which trees are proposed\nto be cut',
                                        purpose,
                                        icon: Icons.assignment),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              // Insert additional documents widget here
                              _buildAdditionalDocuments(),
                              if (Edit || userEdit)
                                _buildEditableSpeciesTable()
                              else if (c.isNotEmpty)
                                _buildSpeciesTable()
                              else
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'No species information available',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: HexColor("#0499f2"),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ViewApplication1(
                            sessionToken: sessionToken,
                            userGroup: userGroup,
                            userId: userId,
                            Ids: Ids,
                            Range: Range,
                            userName: userName,
                            userEmail: userEmail,
                            img_signature: img_signature,
                            img_revenue_approval: img_revenue_approval,
                            img_declaration: img_declaration,
                            img_revenue_application: img_revenue_application,
                            img_location_sktech: img_location_sktech,
                            img_tree_ownership_detail:
                                img_tree_ownership_detail,
                            img_aadhar_detail: img_aadhar_detail,
                            verify_officer: verify_officer,
                            deputy_range_officer: deputy_range_officer,
                            verify_range_officer: verify_range_officer,
                            is_form_two: is_form_two,
                            assigned_deputy2_id: assigned_deputy2_id,
                            assigned_deputy1_id: assigned_deputy1_id,
                            assigned_range_id: assigned_range_id,
                            verify_deputy2: verify_deputy2,
                            division_officer: division_officer,
                            other_state: other_state,
                            verify_forest1: verify_forest1,
                            field_requre: field_requre,
                            field_status: field_status,
                            species: species,
                            length: length,
                            breadth: breadth,
                            volume: volume,
                            log_details: log_details,
                            treeSpecies: treeSpecies,
                            user_Loc: user_Loc,
                            additionalDocuments: additionalDocuments,
                          )));
            },
            icon: const Icon(Icons.navigate_next),
            label: Text(
              'Next',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
