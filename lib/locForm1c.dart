import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/locForm1d.dart';

class locForm1c extends StatefulWidget {
  String sessionToken;
  int userId;
  int id;
  String Type;
  String userName;
  String userEmail;
  String App_no;
  String Division;
  String Range;
  String District;
  String Taluke;
  String Village;
  String address;
  String survay;
  String treePCut;
  String blockL;
  String pin;
  String imageA;
  String imageB;
  String imageC;
  String imageD;
  String image1lat;
  String image2lat;
  String image3lat;
  String image4lat;
  String image1log;
  String image2log;
  String image3log;
  String image4log;
  String treespecies;
  String purposecut;
  String drivername;
  String vechclereg;
  String mode;
  String phone;
  String destAddress;
  String destState;
  String licenceImg;
  String ownerProof;
  String revenApplication;
  String revenApprove;
  String declaration;
  String locationSkch;
  String treeOwnership;
  String aadarcard;
  String signatureImg;
  String selectProof;
  String logData;
  locForm1c(
      {super.key,
      required this.sessionToken,
      required this.userId,
      required this.id,
      required this.Type,
      required this.userName,
      required this.userEmail,
      required this.App_no,
      required this.Division,
      required this.Range,
      required this.District,
      required this.Taluke,
      required this.Village,
      required this.address,
      required this.survay,
      required this.treePCut,
      required this.blockL,
      required this.pin,
      required this.imageA,
      required this.imageB,
      required this.imageC,
      required this.imageD,
      required this.image1lat,
      required this.image2lat,
      required this.image3lat,
      required this.image4lat,
      required this.image1log,
      required this.image2log,
      required this.image3log,
      required this.image4log,
      required this.treespecies,
      required this.purposecut,
      required this.drivername,
      required this.vechclereg,
      required this.mode,
      required this.phone,
      required this.destAddress,
      required this.destState,
      required this.licenceImg,
      required this.ownerProof,
      required this.revenApplication,
      required this.revenApprove,
      required this.declaration,
      required this.locationSkch,
      required this.treeOwnership,
      required this.aadarcard,
      required this.signatureImg,
      required this.selectProof,
      required this.logData});

  @override
  State<locForm1c> createState() => _locForm1cState(
      sessionToken,
      userId,
      id,
      Type,
      userName,
      userEmail,
      App_no,
      Division,
      Range,
      District,
      Taluke,
      Village,
      address,
      survay,
      treePCut,
      blockL,
      pin,
      imageA,
      imageB,
      imageC,
      imageD,
      image1lat,
      image2lat,
      image3lat,
      image4lat,
      image1log,
      image2log,
      image3log,
      image4log,
      treespecies,
      purposecut,
      drivername,
      vechclereg,
      mode,
      phone,
      destAddress,
      destState,
      licenceImg,
      ownerProof,
      revenApplication,
      revenApprove,
      declaration,
      locationSkch,
      treeOwnership,
      aadarcard,
      signatureImg,
      selectProof,
      logData);
}

class _locForm1cState extends State<locForm1c> {
  @override
  void initState() {
    super.initState();

    viewData();
  }

  String sessionToken;
  int userId;
  int id;
  String Type;
  String userName;
  String userEmail;
  String App_no;
  String Division;
  String Range;
  String District;
  String Taluke;
  String Village;
  String address;
  String survay;
  String treePCut;
  String blockL;
  String pin;
  String imageA;
  String imageB;
  String imageC;
  String imageD;
  String image1lat;
  String image2lat;
  String image3lat;
  String image4lat;
  String image1log;
  String image2log;
  String image3log;
  String image4log;
  String treespecies;
  String purposecut;
  String drivername;
  String vechclereg;
  String mode;
  String phone;
  String destAddress;
  String destState;
  String licenceImg;
  String ownerProof;
  String revenApplication;
  String revenApprove;
  String declaration;
  String locationSkch;
  String treeOwnership;
  String aadarcard;
  String signatureImg;
  String selectProof;
  String logData;
  _locForm1cState(
      this.sessionToken,
      this.userId,
      this.id,
      this.Type,
      this.userName,
      this.userEmail,
      this.App_no,
      this.Division,
      this.Range,
      this.District,
      this.Taluke,
      this.Village,
      this.address,
      this.survay,
      this.treePCut,
      this.blockL,
      this.pin,
      this.imageA,
      this.imageB,
      this.imageC,
      this.imageD,
      this.image1lat,
      this.image2lat,
      this.image3lat,
      this.image4lat,
      this.image1log,
      this.image2log,
      this.image3log,
      this.image4log,
      this.treespecies,
      this.purposecut,
      this.drivername,
      this.vechclereg,
      this.mode,
      this.phone,
      this.destAddress,
      this.destState,
      this.licenceImg,
      this.ownerProof,
      this.revenApplication,
      this.revenApprove,
      this.declaration,
      this.locationSkch,
      this.treeOwnership,
      this.aadarcard,
      this.signatureImg,
      this.selectProof,
      this.logData);

  late String dropdownValue2;
  String holder = '';
  List<String> IdProof = [
    'Aadhar Card',
    'Driving License',
    'Passport',
    'Government ID',
    'Voter ID',
  ];
  var IMGowner;
  var IMGrevAPPL;
  var IMGrevAppr;
  var IMGrdeclare;
  var IMGlocationSk;
  var IMGtreeOwn;
  var IMGaadhar;

  void viewData() async {
    if (ownerProof == "") {
      IMGowner = "fill";
    }
    if (revenApplication == "") {
      IMGrevAPPL = "fill";
    }
    if (revenApprove == "") {
      IMGrevAppr = "fill";
    }
    if (declaration == "") {
      IMGrdeclare = "fill";
    }
    if (locationSkch == "") {
      IMGlocationSk = "fill";
    }
    if (treeOwnership == "") {
      IMGtreeOwn = "fill";
    }
    if (selectProof != "") {
      dropdownValue2 = selectProof.toString();
      print(selectProof.toString());
    }

    if (aadarcard == "") {
      IMGaadhar = "fill";
    }
  }

  var _imageOwn;
  var _imageForm;
  var _imageApprove;
  var _imageDeclare;
  var _imageSkechI;
  var _imageTreeOwn;
  var _imageIDProof;
  void _showpickoptiondialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepicgallery();
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

  void _showpickoptiondialogOwn(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepicgalleryOwn();
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

  void _showpickoptiondialogApprove(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setApprovepicgallery();
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

  void _showpickoptiondialogDeclaration(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setDeclarepicgallery();
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

  void _showpickoptiondialogSkechI(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setSkechIpicgallery();
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

  void _showpickoptiondialogTreeOwn(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setTreeOwnpicgallery();
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

  void _showpickoptiondialogIDProof(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setIDProofpicgallery();
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
  Future<void> setfilepicgallery() async {
    print('object');
    revenApplication = "";
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageForm = File(pickedFile.path);

        revenApplication = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepicgalleryOwn() async {
    ownerProof = "";
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageOwn = File(pickedFile.path);

        ownerProof = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setApprovepicgallery() async {
    print('object');
    revenApprove = "";
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageApprove = File(pickedFile.path);

        revenApprove = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setDeclarepicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');
    declaration = "";
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageDeclare = File(pickedFile.path);

        declaration = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setSkechIpicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');
    locationSkch = "";
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageSkechI = File(pickedFile.path);

        locationSkch = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setTreeOwnpicgallery() async {
    treeOwnership = "";
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageTreeOwn = File(pickedFile.path);

        treeOwnership = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setIDProofpicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');
    aadarcard = "";
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageIDProof = File(pickedFile.path);

        aadarcard = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor:Colors.blueGrey,
        title: const Text(
          "FORM - I",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

        elevation: 0,
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: <Widget>[
        Container(
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
                left: 10.0, right: 20, top: 10, bottom: 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialogOwn(context);
                  });
                },
                label: const Text("Proof of ownership"),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: _ownFunction() == "FALSE" ? Colors.red : Colors.green,
                size: 28.0,
              ),
            ]),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.only(
                left: 10.0, right: 20, top: 10, bottom: 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialog(context);
                  });
                  //  _RevenueApplication(ImageSource.gallery);
                },
                label: const Text("Revenue Application "),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color:
                    _revapplFunction() == "FALSE" ? Colors.red : Colors.green,
                //  color: (_Application?.path) == null ? Colors.red : Colors.green,
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
                left: 10.0, right: 20, top: 10, bottom: 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialogApprove(context);
                  });
                  // _RevenueApproval(ImageSource.gallery);
                },
                label: const Text("Revenue Approval"),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color:
                    _revapprFunction() == "FALSE" ? Colors.red : Colors.green,
                //  color: (_Approval?.path) == null ? Colors.red : Colors.green,
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
                left: 10.0, right: 20, top: 10, bottom: 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialogDeclaration(context);
                    //  takePhoto(ImageSource.gallery);
                  });
                  // Declaration(ImageSource.gallery);
                },
                label: const Text("Declaration"),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: _declFunction() == "FALSE" ? Colors.red : Colors.green,
                //color: (_Declaration?.path) == null ? Colors.red : Colors.green,
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
                left: 10.0, right: 20, top: 10, bottom: 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialogSkechI(context);
                    //  takePhoto(ImageSource.gallery);
                  });
                  // _LocationSketch(ImageSource.gallery);
                },
                label: const Text("Location Sketch"),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: _locskFunction() == "FALSE" ? Colors.red : Colors.green,
                // color: (_Location?.path) == null ? Colors.red : Colors.green,
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
                left: 10.0, right: 20, top: 10, bottom: 0),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialogTreeOwn(context);
                    //  takePhoto(ImageSource.gallery);
                  });
                  // _TreeOwnership(ImageSource.gallery);
                },
                label: const Text("Tree Ownership Details"),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color:
                    _treeownFunction() == "FALSE" ? Colors.red : Colors.green,
                size: 28.0,
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
              style: const TextStyle(color: Colors.black, fontSize: 18),
              hint: const Text("Select Photo Identity Proof"),
              /*underline: Container(
                           height: 2,
                           color: Colors.grey,
                         ),*/
              onChanged: (String? data) {
                setState(() {
                  dropdownValue2 = data!;
                });
                print(dropdownValue2);
              },
              items: IdProof.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            margin:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.only(
                left: 10.0, right: 15, top: 10, bottom: 5),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  setState(() {
                    _showpickoptiondialogIDProof(context);
                    //  takePhoto(ImageSource.gallery);
                  });
                  //  _IdProof(ImageSource.gallery);
                },
                label: const Text("Upload Photo ID Proof"),
              ),
              const Spacer(),
              Icon(
                Icons.check_circle,
                color: _aadharFunction() == "FALSE" ? Colors.red : Colors.green,
                // color: (_Proof?.path) == null ? Colors.red : Colors.green,
                size: 28.0,
              ),
            ]),
          ),
        ]))
      ]))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: HexColor("#0499f2"),
        onPressed: () async {
          // if ((dropdownValue == null)
          //     // (dropdownValue1 == null) ||
          //     // (Name.text.length == 0) ||
          //     // (Address.text.length == 0) ||
          //     // (survey_no.text.length == 0) ||
          //     // (Tree_Proposed_to_cut.text.length == 0) ||
          //     // (SelectedVillage == null) ||
          //     // (selectedDistrict == null) ||
          //     // (selectedTaluka == null) ||
          //     // (_image1 == null) ||
          //     // (latImage1.length == 0) ||
          //     // (longImage1.length == 0) ||
          //     // (_image2 == null) ||
          //     // (latImage2.length == 0) ||
          //     // (longImage2.length == 0) ||
          //     // (_image3 == null) ||
          //     // (latImage3.length == 0) ||
          //     // (longImage3.length == 0) ||
          //     // (_image4 == null) ||
          //     // (latImage4.isEmpty) ||
          //     // (longImage4.length == 0)
          //     ) {
          //   // if ((Name.text.length == 0) ||
          //   //     (Address.text.length == 0) ||
          //   //     (survey_no.text.length == 0)
          //   // // (Tree_Proposed_to_cut.text.length == 0)

          //   // ) {
          //   Fluttertoast.showToast(
          //       msg: "Please select and fill all Field",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.CENTER,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 18.0);
          // } else {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return locForm1d(
                        sessionToken: sessionToken,
                        userId: userId,
                        id: id,
                        Type: Type,
                        userName: userName,
                        userEmail: userEmail,
                        Division: Division,
                        Range: Range,
                        District: District,
                        Taluke: Taluke,
                        Village: Village,
                        App_no: App_no,
                        address: address,
                        survay: survay,
                        treePCut: treePCut,
                        blockL: blockL,
                        pin: pin,
                        imageA: imageA,
                        imageB: imageA,
                        imageC: imageC,
                        imageD: imageD,
                        image1lat: image1lat,
                        image2lat: image2lat,
                        image3lat: image3lat,
                        image4lat: image4lat,
                        image1log: image1log,
                        image2log: image2log,
                        image3log: image3log,
                        image4log: image4log,
                        treespecies: treespecies,
                        purposecut: purposecut,
                        drivername: drivername,
                        vechclereg: vechclereg,
                        mode: mode,
                        phone: phone,
                        destAddress: destAddress,
                        destState: destState,
                        licenceImg: licenceImg,
                        ownerProof: ownerProof,
                        revenApplication: revenApplication,
                        revenApprove: revenApprove,
                        declaration: declaration,
                        locationSkch: locationSkch,
                        treeOwnership: treeOwnership,
                        aadarcard: aadarcard,
                        signatureImg: signatureImg,
                        selectProof: dropdownValue2,
                        logData: logData);
                  }));

          setState(() {});
          // print(sessionToken + dropdorwnValue1 + userName);
          // }
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  Object _ownFunction() {
    if (_imageOwn != null || IMGowner != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _revapplFunction() {
    if (_imageForm != null || IMGrevAPPL != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _revapprFunction() {
    if (_imageApprove != null || IMGrevAppr != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _declFunction() {
    if (_imageDeclare != null || IMGrdeclare != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _locskFunction() {
    if (_imageSkechI != null || IMGlocationSk != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _treeownFunction() {
    if (_imageTreeOwn != null || IMGtreeOwn != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }

  Object _aadharFunction() {
    if (_imageIDProof != null || IMGaadhar != "fill") {
      return "TRUE";
    }

    return "FALSE";
  }
}
