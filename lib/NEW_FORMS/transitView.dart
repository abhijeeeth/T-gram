import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/homePage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class transiView extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village_;
  String userGroup;
  String Ids;

  transiView(
      {super.key,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.formOneIndex,
      required this.village_,
      required this.userGroup,
      required this.Ids});

  @override
  State<transiView> createState() => _transiViewState(formOneIndex,
      sessionToken, userName, userEmail, userId, village_, userGroup, Ids);
}

class _transiViewState extends State<transiView> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String userGroup;
  String Ids;
  String village__;

  TextEditingController DestinationAddress = TextEditingController();
  TextEditingController Mode = TextEditingController();
  TextEditingController RegNo = TextEditingController();
  TextEditingController DriverName = TextEditingController();
  TextEditingController DriverPhone = TextEditingController();

  TextEditingController heightController = TextEditingController();
  TextEditingController heightController2 = TextEditingController();
  TextEditingController mdhController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController breadthController = TextEditingController();

  late List<bool> tableVisibility;
  List<CardData> cardDataList = [];
  List<String> generatedStrings = [];

  String generateString(
    int id,
    String spType,
    String productType,
    String height,
    String mdh,
    String weight,
    String length,
    String breadth,
    String height2,
  ) {
    Map<String, dynamic> data = {
      'timber_id': id,
      'Species': spType,
      'product_type': productType,
      'height': height,
      'mdh': mdh,
      'weight': weight,
      'length': length,
      'breadth': breadth,
      'height2': height2,
    };

    // Convert the map to a JSON string
    String jsonString = json.encode(data);

    return jsonString;
  }

  List<Map<String, dynamic>> jsonList = [];

  Future<void> fetchData() async {
    await View_Record();
    setState(() {
      if (responseJSON_O.containsKey("timber")) {
        tableVisibility =
            List.generate(responseJSON_O['timber'].length, (index) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  bool finalLog = false;
  bool round = false;
  bool swan = false;
  bool fireW = false;

  List Tree_species_ = [];
  List log_details_ = [];
  List selectedValues = [];
  List treelog_ = [];
  bool EditA = true;
  bool UpdateCard = false;
  List n_list = [];
  final List logId_ = [];
  final List species_ = [];
  final List length_ = [];
  final List breadth_ = [];
  final List volume_ = [];
  List c = [];
  int COUNT = 0;
  final List s = [];
  final List Sname = [];
  final List Slat = [];
  final List Slong = [];
  final List Slen = [];
  final List Sbreath = [];
  final List Svol = [];
  String Name = "";
  String ID_num = "";
  String Transit_Id = "";
  var timber;
  late String districtData;
  List<String> districts = [];
  bool isShow = false;
  List<Widget> additionalInfoContainers = [];
  late Map<String, dynamic> responseJSON_O;
  _transiViewState(this.formOneIndex, this.sessionToken, this.userName,
      this.userEmail, this.userId, this.village__, this.userGroup, this.Ids);

  List<Map<String, dynamic>> parseJsonList(List<String> jsonStrings) {
    List<Map<String, dynamic>> result = [];
    for (String jsonString in jsonStrings) {
      Map<String, dynamic> map = json.decode(jsonString);
      result.add(map);
    }

    return result;
  }

  // void updateJsonList() {
  //   // Update your jsonList here with the new data
  //   // For example, if you want to add an item:
  //   final newItem = {"key": "New Data", "value": "New Value"};
  //   jsonList.add(newItem);

  //   // Trigger a rebuild of the widget tree
  //   setState(() {});
  // }

  View_Record() async {
    String url = 'https://timber.forest.kerala.gov.in/api/auth/CheckTransit/';
    Map data = {"app_id": Ids};

    var body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    responseJSON_O = json.decode(response.body);

    setState(() {
      Name = responseJSON_O['app']['name'].toString();
      ID_num = responseJSON_O['app']['id_card_number'].toString();
      Transit_Id = responseJSON_O['app']['application_no'].toString();

      COUNT = responseJSON_O['timber'].length;

      if (responseJSON_O.containsKey('timber')) {
        // Access 'timber' here
        timber = responseJSON_O['timber'];

        // Now you can work with 'timber'
      } else {
        // Handle the case where 'timber' is missing or responseJSON is null
      }
      for (int i = 0; i < responseJSON_O['timber'].length; i++) {
        c.add(i);
        Tree_species_.add(responseJSON_O['timber'][i]['species_of_tree']);
        // n_list.add(i);
        logId_.add(responseJSON_O['timber'][i]['id']);
        species_.add(responseJSON_O['timber'][i]['species_of_tree']);
        length_.add(responseJSON_O['timber'][i]['length']);
        breadth_.add(responseJSON_O['timber'][i]['breadth']);
        volume_.add(responseJSON_O['timber'][i]['volume']);
      }

      n_list = c;
      treelog_ = responseJSON_O['timber'];
      log_details_ = treelog_;
    });
  }

  Completer<bool> updateCardCompleter = Completer<bool>();
  // void updateJsonListAndTableVisibility(int index) {
  //   setState(() {
  //     jsonList = parseJsonList(generatedStrings);
  //     tableVisibility[index] = !tableVisibility[index];
  //   });
  // }
  bool visibleC = false;
  void updateJsonListAndTableVisibility(
      int index, String generatedString, Map<String, dynamic> jsonItemData) {
    setState(() {
      // Remove the generated string from the list
      generatedStrings.remove(generatedString);

      // Add a new CardData object to the list
      cardDataList.add(CardData(generatedString, jsonItemData));

      jsonList = parseJsonList(generatedStrings);

      // tableVisibility[index] = !tableVisibility[index];
      if (cardDataList.isEmpty) {
        visibleC = false;
      } else if (cardDataList.isNotEmpty) {
        visibleC = true;
      }
    });
  }

  late List<Map<String, dynamic>> jsonDataList;

  List<Map<String, dynamic>> convertCardDataListToJsonList(
      List<CardData> cardDataList) {
    List<Map<String, dynamic>> jsonList = [];

    for (CardData cardData in cardDataList) {
      Map<String, dynamic> jsonItemData = cardData.jsonItemData;

      // Remove specific keys
      jsonItemData.remove('Species');

      // Rename 'height2' key to 'swan_height'
      if (jsonItemData.containsKey('height2')) {
        jsonItemData['swan_height'] = jsonItemData['height2'];
        jsonItemData.remove('height2');
      }
      if (jsonItemData.containsKey('breadth')) {
        jsonItemData['swan_breadth'] = jsonItemData['breadth'];
        jsonItemData.remove('breadth');
      }
      if (jsonItemData.containsKey('length')) {
        jsonItemData['swan_length'] = jsonItemData['length'];
        jsonItemData.remove('length');
      }

      // Change 'Round Log' to 'Log' and 'Sawn Size' to 'Cuttings'
      if (jsonItemData['product_type'] == 'Round Log') {
        jsonItemData['product_type'] = 'Log';
      } else if (jsonItemData['product_type'] == 'Sawn Size') {
        jsonItemData['product_type'] = 'cuttings';
      }

      jsonList.add(jsonItemData);
    }

    return jsonList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "TRANSIT PASS ",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          elevation: 0,
        ),
        body: responseJSON_O == null
            ? const CircularProgressIndicator() // Display loading indicator while fetching data
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                        border: Border.all(color: Colors.blueGrey, width: 1),
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
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 2,
                            child: ListTile(
                              title: const Text(
                                'Transit Pass ID',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              trailing: Text(Transit_Id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              title: const Text(
                                'Applicant Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              trailing: Text(Name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              title: const Text(
                                "ID Number",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              trailing: Text(ID_num,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15, bottom: 5),
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: const TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: " Add Products from logs to transit ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                              ]),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                responseJSON_O.containsKey("timber")
                                    ? responseJSON_O['timber'].length
                                    : 0,
                                (index) {
                                  final item = responseJSON_O['timber'][index];

                                  return Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(
                                                  label: Text('Specias Name')),
                                              DataColumn(label: Text('Length')),
                                              DataColumn(
                                                  label: Text('Breadth')),
                                              DataColumn(
                                                  label: Text('Volume (m³)')),
                                              DataColumn(label: Text('')),
                                            ],
                                            rows: [
                                              DataRow(
                                                cells: [
                                                  DataCell(Text(
                                                      item['species_of_tree']
                                                          .toString())),
                                                  DataCell(Text(item['length']
                                                      .toString())),
                                                  DataCell(Text(item['breadth']
                                                      .toString())),
                                                  DataCell(Text(item['volume']
                                                      .toString())),
                                                  DataCell(
                                                    TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // ignore: non_constant_identifier_names
                                                            int IDD =
                                                                item['id'];

                                                            String speciesType =
                                                                item['species_of_tree']
                                                                    .toString();
                                                            String
                                                                selectedValue =
                                                                'Select Product Type'; // Initial value
                                                            return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'ADD LOG'),
                                                                  content:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <Widget>[
                                                                      DropdownButton<
                                                                          String>(
                                                                        value:
                                                                            selectedValue,
                                                                        items:
                                                                            <String>[
                                                                          'Select Product Type',
                                                                          'Round Log',
                                                                          'Firewood',
                                                                          'Sawn Size',
                                                                        ].map((String
                                                                                value) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                value,
                                                                            child:
                                                                                Text(value),
                                                                          );
                                                                        }).toList(),
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            selectedValue =
                                                                                newValue ?? 'Select Product Type';
                                                                            if (selectedValue ==
                                                                                'Round Log') {
                                                                              round = true;
                                                                              swan = false;
                                                                              fireW = false;
                                                                            } else if (selectedValue ==
                                                                                'Firewood') {
                                                                              round = false;
                                                                              swan = false;
                                                                              fireW = true;
                                                                            } else if (selectedValue ==
                                                                                'Sawn Size') {
                                                                              round = false;
                                                                              swan = true;
                                                                              fireW = false;
                                                                            }
                                                                            if (selectedValue ==
                                                                                'Select Product Type') {
                                                                              round = false;
                                                                              swan = false;
                                                                              fireW = false;
                                                                            }
                                                                          });
                                                                        },
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            round,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              heightController,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Height (M)'),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            round,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              mdhController,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'MDH (cm)'),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            fireW,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              weightController,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Weight (MT)'),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            swan,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              lengthController,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Length (M)'),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            swan,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              breadthController,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Breadth (M)'),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible:
                                                                            swan,
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              heightController2,
                                                                          decoration:
                                                                              const InputDecoration(labelText: 'Height (M)'),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'SAVE'),
                                                                      onPressed:
                                                                          () {
                                                                        if (round) {
                                                                          if (heightController.text.isNotEmpty ||
                                                                              mdhController.text.isNotEmpty) {
                                                                            finalLog =
                                                                                true;
                                                                          }
                                                                        } else if (fireW) {
                                                                          if (weightController
                                                                              .text
                                                                              .isNotEmpty) {
                                                                            finalLog =
                                                                                true;
                                                                          }
                                                                        } else if (swan) {
                                                                          if (lengthController.text.isNotEmpty ||
                                                                              breadthController.text.isNotEmpty ||
                                                                              heightController2.text.isNotEmpty) {
                                                                            finalLog =
                                                                                true;
                                                                          }
                                                                        }
                                                                        if (finalLog) {
                                                                          String
                                                                              generatedString =
                                                                              generateString(
                                                                            IDD,
                                                                            speciesType,
                                                                            selectedValue,
                                                                            heightController.text,
                                                                            mdhController.text,
                                                                            weightController.text,
                                                                            lengthController.text,
                                                                            breadthController.text,
                                                                            heightController2.text,
                                                                          );

                                                                          Map<String, dynamic>
                                                                              jsonItemData =
                                                                              {
                                                                            'timber_id':
                                                                                IDD,
                                                                            'Species':
                                                                                speciesType,
                                                                            'product_type':
                                                                                selectedValue,
                                                                            'height':
                                                                                heightController.text,
                                                                            'mdh':
                                                                                mdhController.text,
                                                                            'weight':
                                                                                weightController.text,
                                                                            'length':
                                                                                lengthController.text,
                                                                            'breadth':
                                                                                breadthController.text,
                                                                            'height2':
                                                                                heightController2.text,
                                                                          };

                                                                          // cardDataList.add(CardData(
                                                                          //     generatedString,
                                                                          //     jsonItemData));

                                                                          print(
                                                                              "LISTTTT $generatedStrings");
                                                                          IDD =
                                                                              0;
                                                                          heightController
                                                                              .clear();
                                                                          mdhController
                                                                              .clear();
                                                                          weightController
                                                                              .clear();
                                                                          lengthController
                                                                              .clear();
                                                                          breadthController
                                                                              .clear();
                                                                          heightController2
                                                                              .clear();
                                                                          round =
                                                                              false;
                                                                          swan =
                                                                              false;
                                                                          fireW =
                                                                              false;
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          print(
                                                                              'Before setState');
                                                                          updateJsonListAndTableVisibility(
                                                                              index,
                                                                              generatedString,
                                                                              jsonItemData);
                                                                          setState(
                                                                              () {
                                                                            UpdateCard =
                                                                                true;
                                                                          });
                                                                          print(
                                                                              'After setState');
                                                                        } else {
                                                                          Fluttertoast.showToast(
                                                                              msg: "Fill all data",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.CENTER,
                                                                              timeInSecForIosWeb: 8,
                                                                              backgroundColor: Colors.blue,
                                                                              textColor: Colors.white,
                                                                              fontSize: 18.0);
                                                                        }
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'CLOSE'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        UpdateCard =
                                                                            false; // Close the dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child:
                                                          const Text('Add Log'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 0),
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: const TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: " Log List ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                              ]),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            visible: visibleC,
                            // Update this as needed
                            child: Container(
                              height: 200, // Adjust the height as needed
                              padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  top: 20,
                                  bottom: 20), // Add padding for spacing
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1.0), // Add border
                                borderRadius: BorderRadius.circular(
                                    10), // Add border radius
                              ),
                              child: Row(
                                children: [
                                  if (cardDataList.length > 1)
                                    const Icon(
                                      Icons.arrow_downward,
                                      size: 22,
                                      color:
                                          Colors.blue, // Customize icon color
                                    ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: cardDataList.length,
                                      itemBuilder: (context, index) {
                                        final cardData = cardDataList[index];
                                        final generatedString =
                                            cardData.generatedString;
                                        final jsonItemData =
                                            cardData.jsonItemData;

                                        final cardContents = <Widget>[];

                                        // Define a map to customize the key labels as needed
                                        final keyLabels = {
                                          'product_type': 'Product type',
                                          'height2': 'height'
                                          // Add more key renaming as needed
                                        };

                                        jsonItemData.forEach((key, value) {
                                          if (value != null &&
                                              key != 'timber_id') {
                                            final valueString =
                                                value.toString();
                                            if (valueString.isNotEmpty) {
                                              // Use the custom label from keyLabels if available, else use the key itself
                                              final label =
                                                  keyLabels[key] ?? key;

                                              cardContents.add(
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        '    $label:',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(valueString),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          }
                                        });

                                        return Card(
                                          elevation: 6,
                                          color: Colors.blue[50],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                ...cardContents,
                                                TextButton(
                                                  onPressed: () {
                                                    // Delete card or handle any other action
                                                    if (index >= 0 &&
                                                        index <
                                                            cardDataList
                                                                .length) {
                                                      // Delete card and its associated data
                                                      setState(() {
                                                        cardDataList
                                                            .removeAt(index);
                                                      });
                                                    }
                                                  },
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15, bottom: 0),
                            child: TextField(
                                controller: DestinationAddress,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14.0)),
                                    ),
                                    // border: OutlineInputBorder(),
                                    labelText: 'Destination Address *',
                                    hintText: 'Enter destination Address'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, bottom: 30.0),
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius: BorderRadius.circular(8)),
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  isShow = true;
                                });
                                jsonDataList =
                                    convertCardDataListToJsonList(cardDataList);
                                if (cardDataList.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please add Transit Logs",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                } else if (DestinationAddress.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter Address ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                } else {
                                  const String url =
                                      'https://timber.forest.kerala.gov.in/api/auth/apply_orign_transit/';
                                  Map data = {
                                    "app_id": Ids,
                                    "dest_state": "Kerala",
                                    "destination_details":
                                        DestinationAddress.text.trim(),
                                    "logs_selected": jsonDataList,
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
                                      msg: "Application Sumbitted",
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
                                          transitionsBuilder: (context,
                                              animation, animationTime, child) {
                                            return ScaleTransition(
                                              alignment: Alignment.topCenter,
                                              scale: animation,
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (context, animation,
                                              animationTime) {
                                            return HomePage(
                                                sessionToken: sessionToken,
                                                userName: userName,
                                                userEmail: userEmail,
                                                userId: userId,
                                                userGroup: userGroup,
                                                userMobile: '',
                                                userAddress: '',
                                                userProfile: '',
                                                userCato: '');
                                          }));
                                }
                              },
                              child: const Text(
                                '   APPLY FOR \nTRANSIT PASS',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

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
}

class CardData {
  String generatedString;
  Map<String, dynamic> jsonItemData;

  CardData(this.generatedString, this.jsonItemData);
}
