import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/server/serverhelper.dart';

import '../homePage.dart';

class transitPassNotified2 extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String userGroup;
  String Name_;
  String Division_;
  String range_;
  String address_;
  String survey_no_;
  String tree_no_cut;
  String district_;
  String taluke_;
  String block_;
  String village_;
  String pincode_;
  List holder_1;
  String purpose_;
  List log_details;

  transitPassNotified2(
      {super.key,
      required this.formOneIndex,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.userGroup,
      required this.Name_,
      required this.Division_,
      required this.range_,
      required this.address_,
      required this.survey_no_,
      required this.tree_no_cut,
      required this.district_,
      required this.taluke_,
      required this.block_,
      required this.village_,
      required this.pincode_,
      required this.holder_1,
      required this.purpose_,
      required this.log_details});

  @override
  State<transitPassNotified2> createState() => _transitPassNotified2State(
      formOneIndex,
      sessionToken,
      userName,
      userEmail,
      userId,
      userGroup,
      Name_,
      Division_,
      range_,
      address_,
      survey_no_,
      tree_no_cut,
      district_,
      taluke_,
      block_,
      village_,
      pincode_,
      holder_1,
      purpose_,
      log_details);
}

class _transitPassNotified2State extends State<transitPassNotified2> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String userGroup;
  String Name_;
  String Division_;
  String range_;
  String address_;
  String survey_no_;
  String tree_no_cut;
  String district_;
  String taluke_;
  String block_;
  String village_;
  String pincode_;
  List holder_1;
  String purpose_;
  List log_details;
  bool isDeclarationChecked = false;
  TextEditingController id_no = TextEditingController();
  String? dropdownValue2;
  String holder = '';
  File? _imageIDProof;
  File? _pdfIDProof;
  File? _imglandTax;
  File? _pdfLandTax;
  File? _imgDigiSignature;
  File? _pdfDigiSignature;
  File? _imgProofOwner;
  File? _pdfProofOwner;
  File? _imgPossession;
  File? _pdfPossession;
  List<String> IdProof = [
    'Aadhar Card',
    'Driving License',
    'Passport',
    'Government ID',
    'Voter ID',
  ];
  String? selectedPRoof;
  bool isShow = false;
  String mimeID = "";
  String mimeLand = "";
  String mimeSign = "";
  String mimeOwn = "";
  String mimePos = "";

  _transitPassNotified2State(
      this.formOneIndex,
      this.sessionToken,
      this.userName,
      this.userEmail,
      this.userId,
      this.userGroup,
      this.Name_,
      this.Division_,
      this.range_,
      this.address_,
      this.survey_no_,
      this.tree_no_cut,
      this.district_,
      this.taluke_,
      this.block_,
      this.village_,
      this.pincode_,
      this.holder_1,
      this.purpose_,
      this.log_details);

  @override
  void initState() {
    getCurrentLocation3();
    // TODO: implement initState
    super.initState();
  }

  String latImage = "";
  String longImage = "";
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
    if (latImage == "" || longImage == "") {
      getCurrentLocation3();
    }

    setState(() {});
    latImage = posi4.latitude.toString();
    longImage = posi4.longitude.toString();
    //  locaionmsg="$posi1.latitude,$posi1.longitude";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.blueGrey,
              title: const Text("Form II - Notified"),

              elevation: 0,
              // automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10, bottom: 0),
                              child: DropdownButton<String>(
                                value: dropdownValue2,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                hint: const Text("Select Photo Identity Proof"),
                                onChanged: (String? data) {
                                  setState(() {
                                    dropdownValue2 = data!;
                                    selectedPRoof = dropdownValue2;
                                  });
                                },
                                items: IdProof.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
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
                                      flag1 = true;
                                      flag2 = false;
                                      flag3 = false;
                                      flag4 = false;
                                      flag5 = false;
                                      if (flag1) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: const Text(
                                        "Upload Photo ID Proof or PDF"),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imageIDProof != null ||
                                            _pdfIDProof != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 10, bottom: 0),
                              //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: id_no,
                                //  obscureText: true,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14.0)),
                                    ),
                                    labelText: 'ID Number',
                                    hintText: ' Enter ID Number '),
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
                                      flag1 = false;
                                      flag2 = true;
                                      flag3 = false;
                                      flag4 = false;
                                      flag5 = false;
                                      if (flag2) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: const Text("Upload Land Tax Proof"),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imglandTax != null ||
                                            _pdfLandTax != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   margin: const EdgeInsets.only(
                            //     top: 15,
                            //     left: 15,
                            //     right: 15,
                            //     bottom: 20,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //       color: Colors.grey,
                            //       width: 1,
                            //     ),
                            //     borderRadius: BorderRadius.circular(14),
                            //   ),
                            //   padding: const EdgeInsets.only(
                            //     left: 10.0,
                            //     right: 15,
                            //     top: 10,
                            //     bottom: 5,
                            //   ),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.max,
                            //     children: <Widget>[
                            //       TextButton.icon(
                            //         icon: Icon(Icons.image),
                            //         onPressed: (() {
                            //           flag1 = false;
                            //           flag2 = false;
                            //           flag3 = true;
                            //           flag4 = false;
                            //           flag5 = false;
                            //           if (flag3) {
                            //             _pickImageOrPDF();
                            //           }
                            //         }),
                            //         label: Text("Upload Digital Signature"),
                            //       ),
                            //       Spacer(),
                            //       Icon(
                            //         Icons.check_circle,
                            //         color: (_imgDigiSignature != null ||
                            //                 _pdfDigiSignature != null)
                            //             ? Colors.green
                            //             : Colors.red,
                            //         size: 28.0,
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                                      flag1 = false;
                                      flag2 = false;
                                      flag3 = false;
                                      flag4 = true;
                                      flag5 = false;
                                      if (flag4) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label:
                                        const Text("Upload Proof of Ownership"),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imgProofOwner != null ||
                                            _pdfProofOwner != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
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
                                      flag1 = false;
                                      flag2 = false;
                                      flag3 = false;
                                      flag4 = false;
                                      flag5 = true;
                                      if (flag5) {
                                        _pickImageOrPDF();
                                      }
                                    }),
                                    label: const Text(
                                        "Upload Possession certificate"),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.check_circle,
                                    color: (_imgPossession != null ||
                                            _pdfPossession != null)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 28.0,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 15,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: isDeclarationChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isDeclarationChecked = value ?? false;
                                        if (value == true) {
                                          _showDeclarationPopup(); // Show the popup when the checkbox is checked
                                        }
                                      });
                                    },
                                  ),
                                  const Text('DECLARATION'),
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
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10.0, bottom: 0.0),
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextButton(
                                onPressed: () async {
                                  if (selectedPRoof == null) {
                                    Fluttertoast.showToast(
                                        msg: "Please select Id type ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  } else if (id_no.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter ID number ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                  } else if (OWNER_PROOF.isEmpty ||
                                      LAND_PROOF.isEmpty ||
                                      ID_PROOF.isEmpty ||
                                      POSSESSION.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please upload all required documents",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 18.0);
                                    return;
                                  } else if (isDeclarationChecked == false) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Plese read and approve declaration ",
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
                                    if (ID_proof_type == "IMG") {
                                      mimeID = "image/jpeg";
                                    } else {
                                      mimeID = "application/pdf";
                                    }
                                    if (land_proof_type == "IMG") {
                                      mimeLand = "image/jpeg";
                                    } else {
                                      mimeLand = "application/pdf";
                                    }

                                    if (sign_type == "IMG") {
                                      mimeSign = "image/jpeg";
                                    } else {
                                      mimeSign = "application/pdf";
                                    }

                                    if (owner_proof_type == "IMG") {
                                      mimeOwn = "image/jpeg";
                                    } else {
                                      mimeOwn = "application/pdf";
                                    }

                                    if (poss_type == "IMG") {
                                      mimePos = "image/jpeg";
                                    } else {
                                      mimePos = "application/pdf";
                                    }
                                    const String url =
                                        '${ServerHelper.baseUrl}auth/new_application_form/';
                                    Map data = {
                                      "name": Name_,
                                      "lat": latImage,
                                      "lon": longImage,
                                      "address": address_,
                                      "survey_no": survey_no_,
                                      "tree_proposed": tree_no_cut,
                                      "village": village_,
                                      "district": district_,
                                      "block": block_,
                                      "taluka": taluke_,
                                      "division": Division_,
                                      "area_range": range_,
                                      "pincode": pincode_,
                                      "tree_species": holder_1.toString(),
                                      "is_form_two": "1",
                                      "id_type": selectedPRoof,
                                      "id_number": id_no.text,
                                      "purpose_cut": purpose_,
                                      "ownership_proof_img": {
                                        "mime": mimeOwn,
                                        "data": OWNER_PROOF
                                      },
                                      "revenue_application_img": {
                                        "mime": "image/jpeg",
                                        "data": ""
                                      },
                                      "revenue_approval_img": {
                                        "mime": mimeLand,
                                        "data": LAND_PROOF
                                      },
                                      "declaration_img": {
                                        "mime": mimePos,
                                        "data": POSSESSION
                                      },
                                      "tree_ownership_img": {
                                        "mime": "image/jpeg",
                                        "data": ""
                                      },
                                      "location_sketch_img": {
                                        "mime": "image/jpeg",
                                        "data": ""
                                      },
                                      "aadhar_card_img": {
                                        "mime": mimeID,
                                        "data": ID_PROOF
                                      },
                                      "signature_img": {
                                        "mime": mimeSign,
                                        "data": DIGI_SIGN
                                      },
                                      "log_details": log_details ?? ""
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
                                            transitionDuration: const Duration(
                                                milliseconds: 250),
                                            transitionsBuilder: (context,
                                                animation,
                                                animationTime,
                                                child) {
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
                                  ' APPLY FOR CUTTING ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontFamily: 'Cairo',
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void _showDeclarationPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms & Conditions'),
          content: const Text(
              'I hereby declare that the information furnished above is true to the best of my knowledge and belief. I also undertake to comply with the conditions subject to which the permission may be granted by the Authorised officer'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Uncheck the checkbox when "Cancel" is pressed
                setState(() {
                  isDeclarationChecked = false;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Mark the checkbox as checked when "Agree" is pressed
                setState(() {
                  isDeclarationChecked = true;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Agree'),
            ),
          ],
        );
      },
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

  String ID_PROOF = "";
  String LAND_PROOF = "";
  String DIGI_SIGN = "";
  String OWNER_PROOF = "";
  String POSSESSION = "";

  String ID_proof_type = "";
  String land_proof_type = "";
  String sign_type = "";
  String owner_proof_type = "";
  String poss_type = "";

  bool flag1 = false;
  bool flag2 = false;
  bool flag3 = false;
  bool flag4 = false;
  bool flag5 = false;
  // Future<String> convertPdfToBase64(String pdfFilePath) async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text('Hello World'),
  //         );
  //       },
  //     ),
  //   );

  //   // Save the PDF to a temporary file
  //   final tempFile = File(pdfFilePath);
  //   await tempFile.writeAsBytes(await pdf.save());

  //   // Read the temporary file as bytes
  //   final fileBytes = await tempFile.readAsBytes();

  //   // Encode the bytes to base64
  //   return base64Encode(fileBytes);
  // }
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
                            if (flag1) {
                              _pdfIDProof = File(filePath!);
                              convertPdfToBase64(filePath).then((pdfBase64) {
                                ID_PROOF = pdfBase64;
                                ID_proof_type = "PDF";
                              });
                            } else if (flag2) {
                              _pdfLandTax = File(filePath!);
                              convertPdfToBase64(filePath).then((pdfBase64) {
                                LAND_PROOF = pdfBase64;
                                land_proof_type = "PDF";
                              });
                            } else if (flag3) {
                              _pdfDigiSignature = File(filePath!);
                              convertPdfToBase64(filePath).then((pdfBase64) {
                                DIGI_SIGN = pdfBase64;
                                sign_type = "PDF";
                              });
                            } else if (flag4) {
                              _pdfProofOwner = File(filePath!);
                              convertPdfToBase64(filePath).then((pdfBase64) {
                                OWNER_PROOF = pdfBase64;
                                owner_proof_type = "PDF";
                              });
                              print("Image data length: ${OWNER_PROOF.length}");
                              print(
                                  "First 100 chars: ${OWNER_PROOF.substring(0, 100)}");
                            } else if (flag5) {
                              _pdfPossession = File(filePath!);
                              convertPdfToBase64(filePath).then((pdfBase64) {
                                POSSESSION = pdfBase64;
                                poss_type = "PDF";
                              });
                            }
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
                            if (flag1) {
                              _imageIDProof = File(pickedImage.path);
                              ID_PROOF = temp;
                              ID_proof_type = "IMG";
                            } else if (flag2) {
                              _imglandTax = File(pickedImage.path);
                              LAND_PROOF = temp;
                              land_proof_type = "IMG";
                            } else if (flag3) {
                              _imgDigiSignature = File(pickedImage.path);
                              DIGI_SIGN = temp;
                              sign_type = "IMG";
                            } else if (flag4) {
                              _imgProofOwner = File(pickedImage.path);
                              OWNER_PROOF = temp;
                              owner_proof_type = "IMG";
                            } else if (flag5) {
                              _imgPossession = File(pickedImage.path);
                              POSSESSION = temp;
                              poss_type = "IMG";
                            }
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
