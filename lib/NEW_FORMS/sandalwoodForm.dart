// ignore_for_file: unnecessary_new
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/server/serverhelper.dart';

// ignore: camel_case_types, must_be_immutable
class sandalwoodForm extends StatefulWidget {
  String sessionToken;
  String userName;
  String userEmail;
  String userGroup;
  int userId;
  // ignore: use_key_in_widget_constructors
  sandalwoodForm(
      {required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userGroup,
      required this.userId});

  @override
  // ignore: no_logic_in_create_state
  State<sandalwoodForm> createState() => _sandalwoodFormState(
      sessionToken, userName, userEmail, userGroup, userId);
}

// ignore: camel_case_types
class _sandalwoodFormState extends State<sandalwoodForm> {
  @override
  void initState() {
    super.initState();
    nameC.text = userName; // Set the initial value to the controller
    fetchVillage();
  }

  String sessionToken;
  String userName;
  String userEmail;
  String userGroup;
  int userId;
  _sandalwoodFormState(this.sessionToken, this.userName, this.userEmail,
      this.userGroup, this.userId);
  String selectedValue = '0';
  bool flag1 = false;
  bool flag2 = false;

  File? _imageLandSkech;
  File? _imageLandPoss;
  File? _landPossProff;
  File? _landSkech;
  String LAND_PROOF = "";
  String LAND_PROOF1 = "";
  File? _imglandTax;
  String LAND_PROOF_TYPE = "";
  String land_proof_type = "";
  String _selectedVillage = '';
  int _selectedVillageId = 0;

  List<String> _suggestions = [];
  final TextEditingController nameC = TextEditingController();
  final TextEditingController survayC = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController otReasonC = TextEditingController();
  final TextEditingController addressC = TextEditingController();

  final TextEditingController treeH = TextEditingController();
  final TextEditingController treeG = TextEditingController();
  List<VillageData> villages = [];
  String? divisionData;
  String? rangeData;
  List<Map<String, String>> trees = []; // List to store tree data
  String? selectedReason;
  void addTree(String height, String girth) {
    setState(() {
      trees.add({'height': height, 'girth': girth});
    });
  }

  void updateTree(int index, String height, String girth) {
    setState(() {
      trees[index] = {'height': height, 'girth': girth};
    });
  }

  void deleteTree(int index) {
    setState(() {
      trees.removeAt(index);
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool _validateFields() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  Future<void> fetchVillage() async {
    final response =
        await http.get(Uri.parse('${ServerHelper.baseUrl}auth/villages/'));

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
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}');
    }
  }

  List<String> ranges = [];
  List<String> divisions = [];
  LoadDivisionRange() async {
    int DL = 0;
    const String url = '${ServerHelper.baseUrl}auth/villages/';
    Map data = {
      "village": _selectedVillage,
    };

    var body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);

    Map<String, dynamic> responseJson = json.decode(response.body);
    // villageTaluka = responseJson['data']['village_taluka'];
    // villageDist = responseJson['data']['village_dist'];
    List<dynamic> possibilityList = responseJson['data']['possibility'];
    for (var possibility in possibilityList) {
      String range = possibility['range'];
      String divi = possibility['division'];
      divisions.add(divi);
      ranges.add(range);
    }
  }

  @override
  void dispose() {
    _villageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            body: CustomScrollView(slivers: [
          SliverAppBar(
            floating: false, // App bar won't float at the top
            pinned: false, // App bar will scroll away
            snap: false,
            expandedHeight: 50.0, // Height of the app bar when fully expanded
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('FORM SELECTION'),
              background:
                  Container(color: Colors.blueAccent), // Optional background
            ),
          ),
          SliverToBoxAdapter(
              child: Form(
            key: _formKey,
            child: Container(
              padding:
                  const EdgeInsets.all(16.0), // Adjust the padding as needed
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.grey, // Set your preferred border color
              //     width: 3.0, // Set the border width
              //   ),
              //   // borderRadius: BorderRadius.circular(8.0), // Set border radius
              // ),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                RadioListTile(
                  title: const Text('Apply for cutting'),
                  value: '1',
                  groupValue: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value ?? '0';
                    });
                  },
                ),
                if (selectedValue == '1') ...[
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextField 1
                          TextFormField(
                            controller: nameC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name'; // Error message for empty name
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: 'Enter Name :',
                              border: const OutlineInputBorder(),
                              filled: true, // Enables the background color
                              fillColor: Colors.grey[
                                  200], // Sets the background color to a light gray shade
                            ),
                          ),
                          const SizedBox(height: 10),
                          // TextField 2
                          TextFormField(
                            controller: survayC,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Survey No'; // Error message for empty name
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: 'Enter Survey No:',
                              border: const OutlineInputBorder(),
                              filled: true, // Enables the background color
                              fillColor: Colors.grey[200],
                              // Sets the background color to a light gray shade
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _villageController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your village'; // Error message for empty name
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedVillage = '';

                                _suggestions = getSuggestions(value, villages);
                              });
                            },
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: 'Search for a village...',
                              // contentPadding: const EdgeInsets.symmetric(
                              //   vertical: 12.0,
                              //   horizontal: 16.0,
                              // ),
                              border: const OutlineInputBorder(),
                              filled: true, // Enables the background color
                              fillColor: Colors.grey[
                                  200], // Sets the background color to a light gray shade
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _showSuggestionsDialog(context, villages);
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Gray background for dropdown
                              border: const OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.grey[200],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your division'; // Error message for empty name
                              }
                              return null;
                            },
                            value: divisionData, // Current selected value
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),

                            // If divisionData is null, show the hint "Select Division"
                            hint: const Text(
                              "Select Division",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),

                            onChanged: (String? data) {
                              setState(() {
                                divisionData = data; // Update selected value
                              });
                            },

                            // Generate the dropdown items from the divisions list
                            items: divisions.isNotEmpty
                                ? divisions
                                    .toSet()
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList()
                                : null, // When divisions is empty, there are no dropdown items
                          ),

                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Gray background for dropdown
                              border: const OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.grey[200],
                            value: rangeData, // Current selected value
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your range'; // Error message for empty name
                              }
                              return null;
                            },
                            // If divisionData is null, show the hint "Select Division"
                            hint: const Text(
                              "Select Range",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),

                            onChanged: (String? data) {
                              setState(() {
                                rangeData = data; // Update selected value
                              });
                            },

                            // Generate the dropdown items from the divisions list
                            items: ranges.isNotEmpty
                                ? ranges
                                    .toSet()
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList()
                                : null, // When divisions is empty, there are no dropdown items
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                ' Add Trees',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  // showTreeBottomSheet(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            padding: const EdgeInsets.all(16.0),
                                            child: Form(
                                              key: _formKey1,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'ADD TREE',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  TextFormField(
                                                      controller: treeH,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Enter Height (in meter)',
                                                        border:
                                                            const OutlineInputBorder(),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[200],
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Height is required';
                                                        }
                                                        return null;
                                                      }),
                                                  const SizedBox(height: 10),
                                                  TextFormField(
                                                      controller: treeG,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Enter Girth (in meter)',
                                                        border:
                                                            const OutlineInputBorder(),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[200],
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Girth is required';
                                                        }
                                                        return null;
                                                      }),
                                                  const SizedBox(height: 20),
                                                  Center(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        // Validate the form fields safely checking for null
                                                        if (_formKey1
                                                                    .currentState !=
                                                                null &&
                                                            _formKey1
                                                                .currentState!
                                                                .validate()) {
                                                          // If the form is valid, proceed with adding the tree
                                                          addTree(treeH.text,
                                                              treeG.text);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 24,
                                                          vertical: 12,
                                                        ),
                                                      ),
                                                      child: const Text(
                                                          'Add Tree'),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          if (trees.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: trees.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tree ${index + 1}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight
                                                  .bold), // Increased text size
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                treeH.text =
                                                    trees[index]['height']!;
                                                treeG.text =
                                                    trees[index]['girth']!;
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Form(
                                                          key: _formKey2,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const Text(
                                                                'UPDATE TREE',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              TextFormField(
                                                                controller:
                                                                    treeH,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Height',
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          200],
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Height is required';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              TextFormField(
                                                                controller:
                                                                    treeG,
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Girth',
                                                                  border:
                                                                      const OutlineInputBorder(),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          200],
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Girth is required';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Center(
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey2.currentState !=
                                                                            null &&
                                                                        _formKey2
                                                                            .currentState!
                                                                            .validate()) {
                                                                      updateTree(
                                                                          index,
                                                                          treeH
                                                                              .text,
                                                                          treeG
                                                                              .text);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } // Close the dialog
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey, // Text color
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            24,
                                                                        vertical:
                                                                            12),
                                                                  ),
                                                                  child: const Text(
                                                                      'Update Tree'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                deleteTree(
                                                    index); // Delete tree logic
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            height:
                                                8), // Add some space between lines
                                        Text(
                                          'Entered Height (In meters) : ${trees[index]['height']} meters',
                                          style: const TextStyle(
                                              fontSize:
                                                  16), // Increased text size
                                        ),
                                        const SizedBox(
                                            height:
                                                4), // Add some space between lines
                                        Text(
                                          'Entered Girth (In meter)   : ${trees[index]['girth']} meters',
                                          style: const TextStyle(
                                              fontSize:
                                                  16), // Increased text size
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                          const SizedBox(height: 10),

                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                flag1 = true;
                                flag2 = false;
                                if (flag1) {
                                  _pickImageOrPDF();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              backgroundColor: Colors.grey[200], // Text color
                              padding: const EdgeInsets.all(
                                  16.0), // Padding inside the button
                              side: const BorderSide(
                                  color: Colors.grey,
                                  width: 2), // Border color and width
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                              ),
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Land Possession Certificate",
                                textAlign: TextAlign.center, // Center the text
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_landPossProff != null ||
                              _imageLandPoss != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _landPossProff != null
                                        ? 'PDF File: ${_landPossProff!.path.split('/').last}'
                                        : 'Image File: ${_imageLandPoss!.path.split('/').last}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _landPossProff = null;
                                      _imageLandPoss = null;
                                      LAND_PROOF = '';
                                      LAND_PROOF_TYPE = '';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                flag1 = false;
                                flag2 = true;

                                if (flag2) {
                                  _pickImageOrPDF();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              backgroundColor: Colors.grey[200], // Text color
                              padding: const EdgeInsets.all(
                                  16.0), // Padding inside the button
                              side: const BorderSide(
                                  color: Colors.grey,
                                  width: 2), // Border color and width
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                              ),
                            ),
                            child: const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Land Sketch Cirtificate",
                                textAlign: TextAlign.center, // Center the text
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_landSkech != null ||
                              _imageLandSkech != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _landSkech != null
                                        ? 'PDF File: ${_landSkech!.path.split('/').last}'
                                        : 'Image File: ${_imageLandSkech!.path.split('/').last}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _landSkech = null;
                                      _imageLandSkech = null;
                                      LAND_PROOF = '';
                                      LAND_PROOF_TYPE = '';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                          const Text(
                            ' Reason in case of :',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors
                                  .grey[200], // Gray background for dropdown
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select reason'; // Error message for empty name
                              }
                              return null;
                            },
                            hint: const Text(
                              "Select Reason",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            dropdownColor: Colors.grey[200],
                            value: selectedReason,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            items: const [
                              DropdownMenuItem(
                                value: 'Dead',
                                child: Text('Dead'),
                              ),
                              DropdownMenuItem(
                                value: 'Wind Fallen',
                                child: Text('Wind Fallen'),
                              ),
                              DropdownMenuItem(
                                value: 'Dangerous to Life and Property',
                                child: Text('Dangerous to Life and Property'),
                              ),
                              DropdownMenuItem(
                                value: 'Others',
                                child: Text('Others'),
                              ),
                            ],
                            onChanged: (value) async {
                              // Safely update state
                              await Future.delayed(
                                  const Duration(milliseconds: 100), () {
                                setState(() {
                                  selectedReason = value;
                                });
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Conditionally show the TextField if "Others" is selected
                          if (selectedReason == 'Others')
                            TextFormField(
                              controller: otReasonC,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                labelText: 'Please specify other reason',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter reason'; // Error message for empty name
                                }
                                return null;
                              },
                            ),
                          const SizedBox(height: 20),

                          TextFormField(
                            controller: addressC,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              labelText: 'Enter your Address here ..',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address'; // Error message for empty name
                              }
                              return null;
                            },
                            maxLines: 5, // Allows up to 5 lines of text
                            minLines:
                                3, // Ensures the TextField is at least 3 lines high
                            keyboardType: TextInputType
                                .multiline, // Allows multi-line input
                            textInputAction: TextInputAction
                                .newline, // Moves to the next line when Enter is pressed
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  if (trees.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please add tree details",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  } else if (LAND_PROOF == "") {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please add land possession cirtificate",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  } else if (LAND_PROOF1 == "") {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please add land sketch cirtificate",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  } else {
                                    const String url =
                                        '${ServerHelper.baseUrl}auth/new_application_form/';
                                    Map data = {
                                      "name": nameC.text,
                                      "survey_no": survayC.text,
                                      "division": divisionData,
                                      "range": rangeData,
                                      "reason": selectedReason,
                                      "other_reason": otReasonC.text,
                                      "address": addressC.text,
                                      "land_possession_certificate":
                                          "certificate.pdf",
                                      "land_sketch": "sketch.png",
                                      "heights[]": ["10m", "15m"],
                                      "girths[]": ["30cm", "40cm"]
                                    };

                                    var body = json.encode(data);

                                    final response = await http.post(
                                        Uri.parse(url),
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'Authorization': "token $sessionToken"
                                        },
                                        body: body);

                                    Map<String, dynamic> responseJson =
                                        json.decode(response.body);

                                    if (responseJson['status'] != "success") {
                                      Fluttertoast.showToast(
                                          msg: "Something went wrong",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 4,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 18.0);
                                    } else {
                                      _showSuccessDialog(context);
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors
                                    .grey, // Text color (white for contrast)
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12), // Padding for the button
                              ),
                              child: const Text('APPLY'),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )),
                ],
                RadioListTile(
                  title: const Text('Application Status'),
                  value: '2',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                if (selectedValue == '2') ...[
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // landSketchText = 'Land Sketch Uploaded'; // Example action
                                // Implement your action here, e.g., file picker
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              padding: const EdgeInsets.all(16.0),
                              // Gray background color
                              child: const Text(
                                "Select Application",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _showSuccessDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors
                                    .grey, // Text color (white for contrast)
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12), // Padding for the button
                              ),
                              child: const Text('Check Status'),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )),
                ],
              ]),
            ),
          )),
        ])));
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimize the size of the dialog
              children: [
                // Green tick mark at the center
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 100.0,
                ),
                const SizedBox(height: 20),
                // Text in green color
                const Text(
                  'Application Submitted Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Note text
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Note: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Your application number is 12345',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Close button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Green background color
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onBackPressed() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go Home page'),
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

  Future<String?> convertPdfToBase64(String pdfFilePath) async {
    final pdfFile = File(pdfFilePath);

    if (await pdfFile.exists()) {
      final fileBytes = await pdfFile.readAsBytes();
      final pdfBase64 = base64Encode(fileBytes);

      return pdfBase64;
    } else {
      return null;
    }
  }

  //   final picker = ImagePicker();
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             content: SingleChildScrollView(
  //               child: ListBody(
  //                 children: [
  //                   InkWell(
  //                     onTap: () async {
  //                       Navigator.of(context).pop(); // Close the dialog
  //                       final result = await FilePicker.platform.pickFiles(
  //                         type: FileType.custom,
  //                         allowedExtensions: ['pdf'],
  //                       );
  //                       if (result != null && result.files.isNotEmpty) {
  //                         final filePath = result.files.single.path;
  //                         setState(() {
  //                           if (flag1) {
  //                             _landPossProff = File(filePath);
  //                             convertPdfToBase64(filePath).then((pdfBase64) {
  //                               LAND_PROOF = pdfBase64;
  //                               LAND_PROOF_TYPE = "PDF";
  //                             });
  //                           } else if (flag2) {
  //                             _landSkech = File(filePath);
  //                             convertPdfToBase64(filePath).then((pdfBase64) {
  //                               LAND_PROOF = pdfBase64;
  //                               LAND_PROOF_TYPE = "PDF";
  //                             });
  //                           }
  //                         });
  //                       }
  //                     },
  //                     splashColor: Colors.blueAccent,
  //                     child: Row(
  //                       children: const [
  //                         Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: Icon(
  //                             Icons.picture_as_pdf_sharp,
  //                             color: Colors.blueAccent,
  //                           ),
  //                         ),
  //                         Text(
  //                           'Files',
  //                           style: TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.w500,
  //                               color: Colors.black),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: () async {
  //                       Navigator.of(context).pop(); // Close the dialog
  //                       final pickedImage =
  //                           await picker.pickImage(source: ImageSource.gallery);
  //                       if (pickedImage != null) {
  //                         String temp =
  //                             base64Encode(await pickedImage.readAsBytes());
  //                         setState(() {
  //                           if (flag1) {
  //                             _imageLandPoss = File(pickedImage.path);
  //                             LAND_PROOF = temp;
  //                             LAND_PROOF_TYPE = "IMG";
  //                           } else if (flag2) {
  //                             _imageLandSkech = File(pickedImage.path);
  //                             LAND_PROOF = temp;
  //                             land_proof_type = "IMG";
  //                           }
  //                         });
  //                       }
  //                     },
  //                     splashColor: Colors.greenAccent,
  //                     child: Row(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Icon(
  //                             Icons.image,
  //                             color: Colors.blueAccent,
  //                           ),
  //                         ),
  //                         Text(
  //                           'Gallery',
  //                           style: TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.w500,
  //                               color: Colors.black),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ));
  // }
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
                      _villageController.text = selectedVillage.villageName;
                      _selectedVillage = selectedVillage.villageName;
                      _selectedVillageId = selectedVillage.id;
                      divisionData = null;
                      rangeData = null;
                      divisions.clear();
                      ranges.clear();
                      LoadDivisionRange();
                      // _isNotified = selectedVillage.isNotified;
                      _suggestions = []; // Clear suggestions
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

  Future<void> _pickImageOrPDF() async {
    final picker = ImagePicker();

    // Use FilePicker to allow picking both images and PDFs
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'], // Allowed file types
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path;
      final fileSize = result.files.single.size;

      // Convert file size to MB
      double fileSizeInMB = fileSize / (1024 * 1024);

      if (fileSizeInMB > 6) {
        // Show error message if file size exceeds 6MB
        _showErrorDialog(context, 'File size should not exceed 6MB.');
        return;
      }

      setState(() {
        if (filePath != null) {
          // Check if the selected file is an image or a PDF
          if (filePath.endsWith('.pdf')) {
            // Handle PDF selection
            if (flag1) {
              _landPossProff = File(filePath);
              convertPdfToBase64(filePath).then((pdfBase64) {
                LAND_PROOF = pdfBase64 ?? '';
                LAND_PROOF_TYPE = "PDF";
              });
            } else if (flag2) {
              _landSkech = File(filePath);
              convertPdfToBase64(filePath).then((pdfBase64) {
                LAND_PROOF1 = pdfBase64 ?? '';
                LAND_PROOF_TYPE = "PDF";
              });
            }
          } else {
            // Handle image selection
            final pickedImage = File(filePath);
            String temp = base64Encode(pickedImage.readAsBytesSync());
            if (flag1) {
              _imageLandPoss = pickedImage;
              LAND_PROOF = temp;
              LAND_PROOF_TYPE = "IMG";
            } else if (flag2) {
              _imageLandSkech = pickedImage;
              LAND_PROOF1 = temp;
              LAND_PROOF_TYPE = "IMG";
            }
          }
        }
      });
    }
  }

// Helper function to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

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

List<String> getSuggestions(String query, List<VillageData> villageList) {
  if (query.isEmpty) {
    return []; // Return an empty list when query is empty
  }

  // Extract village names from the VillageData objects
  List<String> villageNames =
      villageList.map((village) => village.villageName).toList();

  // Filter the village names based on the query
  List<String> filteredVillages = villageNames
      .where((village) => village.toLowerCase().startsWith(query.toLowerCase()))
      .toList();

  return filteredVillages;
}
