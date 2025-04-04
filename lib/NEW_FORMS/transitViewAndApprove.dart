import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class transitViewAndApprove extends StatefulWidget {
  String? userGroup;
  String? sessionToken;
  String? Ids;
  String? userName;
  String? userEmail;
  transitViewAndApprove(
      {super.key,
      required this.userGroup,
      required this.sessionToken,
      required this.Ids,
      required this.userName,
      required this.userEmail});

  @override
  State<transitViewAndApprove> createState() => _transitViewAndApproveState(
      userGroup, sessionToken, Ids, userName, userEmail);
}

class _transitViewAndApproveState extends State<transitViewAndApprove> {
  String? userGroup;
  String? sessionToken;
  String? Ids;
  String? userName;
  String? userEmail;
  late File _pdfIDProof;
  late File _imageIDProof;
  late Map<String, dynamic> responseJSON;
  late String transitId;

  _transitViewAndApproveState(this.userGroup, this.sessionToken, this.Ids,
      this.userName, this.userEmail);

  @override
  void initState() {
    super.initState();
    setState(() {
      TransitView();
    });
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  TextEditingController remark = TextEditingController();
  bool isShow = false;
  List c1 = [];
  String name = "";

  String address = "";
  String villageName = "";
  String treeSpecies = "";
  String purpose = "";
  String requestDate = "";
  List currentLog = [];
  List previousLog = [];

  final List productId = [];
  final List type = [];
  final List logH = [];
  final List logMdh = [];
  final List fireW = [];
  final List swanH = [];
  final List swanL = [];
  final List swanB = [];
  final List statusF = [];
  final List speciesType = [];
  List<CardData> cardDataList = [];
  List<String> selectedProductIds = [];
  String mimeID = "";
  String ID_type = "";
  String ID_PROOF = "";
  void TransitView() async {
    String url = 'http://192.168.54.114:8000/api/auth/SeeTransit/';
    Map data = {
      "transit_number": Ids,
    };

    var body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "token $sessionToken"
        },
        body: body);
    responseJSON = json.decode(response.body);

    setState(() {
      name = responseJSON['application']['name'].toString();
      address = responseJSON['application']['address'].toString();
      transitId = responseJSON['transit']['transit_number'].toString();
      responseJSON['application']['village'].toString();

      treeSpecies = responseJSON['application']['species_of_trees'].toString();
      purpose = responseJSON['application']['purpose'].toString();

      try {
        List<dynamic> currentRequest = responseJSON['curent_request'];
        currentLog = responseJSON['curent_request'];

        // Clear the cardDataList outside of the loop
        cardDataList.clear();

        for (int i = 0; i < currentLog.length; i++) {
          c1.add(i);
          print("CURRENT INSIDE");
          productId.add(responseJSON['curent_request'][i]['id'].toString());
          type.add(responseJSON['curent_request'][i]['product'].toString());
          logH.add(responseJSON['curent_request'][i]['log_height'].toString());
          logMdh.add(responseJSON['curent_request'][i]['log_mdh'].toString());
          fireW.add(
              responseJSON['curent_request'][i]['firewood_weight'].toString());
          swanH
              .add(responseJSON['curent_request'][i]['swan_length'].toString());
          swanL.add(
              responseJSON['curent_request'][i]['swan_breadth'].toString());
          swanB
              .add(responseJSON['curent_request'][i]['swan_height'].toString());
          statusF.add(responseJSON['curent_request'][i]['is_transit_approved']
              .toString());
          speciesType.add(responseJSON['curent_request'][i]['name'].toString());

          final Map<String, dynamic> jsonItemData = {
            'Product ID': productId[i],
            'Species ': speciesType[i],
            'Type': type[i],
            'Log Height': logH[i],
            'Log MDH': logMdh[i],
            'Firewood Weight': fireW[i],
            'Swan Length': swanH[i],
            'Swan Breadth': swanL[i],
            'Swan Height': swanB[i],
            'Status': statusF[i],
          };

          CardData cardData = CardData(
            generatedString: 'Some generated data',
            jsonItemData: jsonItemData,
          );

          // Add the CardData object to the list
          cardDataList.add(cardData);
        }
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    });
  }

  Future<String> convertPdfToBase64(String pdfFilePath) async {
    final pdfFile = File(pdfFilePath);

    if (await pdfFile.exists()) {
      final fileBytes = await pdfFile.readAsBytes();
      final pdfBase64 = base64Encode(fileBytes);

      return pdfBase64;
    } else {
      return '';
    }
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
          body: responseJSON == null
              ? const CircularProgressIndicator() // Display loading indicator while fetching data
              : SingleChildScrollView(
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
                          trailing: Text(transitId,
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
                          trailing: Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: ListTile(
                          title: const Text(
                            "Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          trailing: Text(address,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
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
                                text: " Requested Log List ",
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
                        visible: true,
                        child: Container(
                          height: 200, // Adjust the height as needed
                          padding: const EdgeInsets.only(
                              right: 10,
                              left: 10,
                              top: 20,
                              bottom: 20), // Add padding for spacing
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: 1.0), // Add border
                            borderRadius:
                                BorderRadius.circular(10), // Add border radius
                          ),
                          child: Row(
                            children: [
                              if (cardDataList.length > 1)
                                const Icon(
                                  Icons.arrow_downward,
                                  size: 22,
                                  color: Colors.blue, // Customize icon color
                                ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: cardDataList.length,
                                  itemBuilder: (context, index) {
                                    final cardData = cardDataList[index];
                                    final jsonItemData = cardData.jsonItemData;

                                    final cardContents = <Widget>[];

                                    jsonItemData.forEach((key, value) {
                                      if (value is List) {
                                        for (var item in value) {
                                          jsonItemData.remove('Status');

                                          final valueString = item.toString();
                                          if (valueString.isNotEmpty) {
                                            cardContents.add(
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      '    $key:',
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
                                      } else {
                                        final valueString = value.toString();
                                        if (valueString.isNotEmpty) {
                                          cardContents.add(
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    '    $key:',
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
                                    final productId =
                                        cardData.jsonItemData['Product ID'];
                                    final statusValue =
                                        cardData.jsonItemData['Status'];

                                    //   final productIdst =
                                    // cardData.jsonItemData['Product ID'];
                                    return Card(
                                      elevation: 6,
                                      color: Colors.blue[50],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Visibility(
                                              visible: statusValue == "0",
                                              child: CheckboxListTile(
                                                value: selectedProductIds
                                                    .contains(productId),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    if (value ?? false) {
                                                      selectedProductIds
                                                          .add(productId);
                                                    } else {
                                                      selectedProductIds
                                                          .remove(productId);
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                            ...cardContents,
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
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: remark,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              labelText: 'Add remarks',
                              hintText: 'Add Remarks'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
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
                              }),
                              label: const Text("Upload remark File"),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.check_circle,
                              color:
                                  (_imageIDProof != null || _pdfIDProof != null)
                                      ? Colors.green
                                      : Colors.red,
                              size: 28.0,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isShow,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 8,
                        ),
                      ),
                      Visibility(
                        visible: selectedProductIds.isNotEmpty,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 30.0),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            onPressed: () async {
                              if (remark.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please enter remaks ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                setState(() {
                                  isShow = true;
                                });
                                if (ID_type == "IMG") {
                                  mimeID = "image/jpeg";
                                } else {
                                  mimeID = "application/pdf";
                                }

                                const String url =
                                    'http://192.168.54.114:8000/api/auth/ApproveNewProductTransit/';
                                Map data = {
                                  "transit_number": transitId,
                                  "action": "Approve",
                                  "remark_text": remark.text,
                                  "logs_to_approve": selectedProductIds,
                                  "remark_file": {
                                    "mime": mimeID,
                                    "data": ID_PROOF
                                  }
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
                                    msg: "Application Approved",
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
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return OfficerDashboard(
                                              sessionToken: sessionToken ?? "",
                                              userName: userName ?? "",
                                              userEmail: userEmail ?? "",
                                              userGroup: userGroup ?? "",
                                              userId: 1,
                                              dropdownValue: "All",
                                              Range: const ["All"]);
                                        }));
                              }
                            },
                            child: const Text(
                              'APPROVE',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectedProductIds.isEmpty,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 30.0),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextButton(
                            onPressed: () async {
                              if (remark.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please enter remaks ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                setState(() {
                                  isShow = true;
                                });
                                const String url =
                                    'http://192.168.54.114:8000/api/auth/ApproveNewProductTransit/';
                                Map data = {
                                  "transit_number": transitId,
                                  "action": "Reject",
                                  "remark_text": remark.text,
                                  "logs_to_approve": selectedProductIds,
                                  "remark_file": {
                                    "mime": mimeID,
                                    "data": ID_PROOF
                                  }
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
                                    msg: "Application Rejected",
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
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return OfficerDashboard(
                                              sessionToken: sessionToken ?? "",
                                              userName: userName ?? "",
                                              userEmail: userEmail ?? "",
                                              userGroup: userGroup ?? "",
                                              userId: 1,
                                              dropdownValue: "All",
                                              Range: const ["All"]);
                                        }));
                              }
                            },
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ));
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
                              ID_PROOF = pdfBase64;
                              ID_type = "PDF";
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
                            ID_PROOF = temp;
                            ID_type = "IMG";
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
}

class CardData {
  final String generatedString;
  final Map<String, dynamic> jsonItemData;

  CardData({
    required this.generatedString,
    required this.jsonItemData,
  });
}
