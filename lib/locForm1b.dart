import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/locForm1c.dart';

class locForm1b extends StatefulWidget {
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
  locForm1b(
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
  State<locForm1b> createState() => _locForm1bState(
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

List<String> listtc = [];
List<String> specias = [];
List<String> intersection = [];

class _locForm1bState extends State<locForm1b> {
  @override
  void initState() {
    super.initState();
    viewData();
  }

  void viewData() async {
    if (purposecut != "") {
      Purpose.text = purposecut;
    }
    if (treespecies != "") {
      print(treespecies);
      String trees = treespecies.replaceAll(RegExp(r'[\[\]]'), "");
      String treesS = trees.trim();
      listtc = treesS.split(",");
      print(listtc);
      _selectedValues = listtc;
      print(_selectedValues);
    }
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
  _locForm1bState(
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

  // Map<String, bool> List = {
  //   'Rosewood(Dalbergia latifolia)': false,
  //   'Teak(Tectona grandis) ': false,
  //   'Thempavu(Terminalia tomantosa)': false,
  //   'Chadachi(Grewia tiliaefolia)': false,
  //   'Chandana vempu(Cedrela toona)': false,
  //   'Vellakil(Dysoxylum malabaricum)': false,
  //   'Irul(Xylia xylocarpa)': false,
  //   'Ebony(Diospyrus sp.)': false,
  //   'Kampakam(Hopea Parviflora)': false,
  // };
  // var holder_1 = [];
  List<String> _selectedValues = [];

  // getItems() {
  //   List.forEach((key, value) {
  //     if (value == true) {
  //       holder_1.add(key);
  //     }
  //   });
  // }

  bool flag = false;
  bool flag1 = false;

  TextEditingController Purpose = TextEditingController();

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
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 13, top: 15),
                child: const Text(
                  'Species of tree or trees proposed to be cut:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              )
            ]),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
              height: MediaQuery.of(context).size.height * 0.39,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  CheckboxListTile(
                    title: const Text("Rosewood(Dalbergia latifolia)"),
                    value: _selectedValues
                            .contains('Rosewood(Dalbergia latifolia)') ||
                        _selectedValues
                            .contains(' Rosewood(Dalbergia latifolia)'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Rosewood(Dalbergia latifolia)");
                        } else {
                          _selectedValues
                              .remove("Rosewood(Dalbergia latifolia)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Teak(Tectona grandis)'),
                    value: _selectedValues.contains('Teak(Tectona grandis)') ||
                        _selectedValues.contains('(Teak (Tectona grandis)') ||
                        _selectedValues.contains(' Teak(Tectona grandis) '),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Teak(Tectona grandis)");
                        } else {
                          _selectedValues.remove("Teak(Tectona grandis)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Thempavu(Terminalia tomantosa)"),
                    value: _selectedValues
                            .contains('Thempavu(Terminalia tomantosa)') ||
                        _selectedValues
                            .contains(' Thempavu (Terminalia tomentosa)') ||
                        _selectedValues
                            .contains(' Thempavu(Terminalia tomantosa)'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Thempavu(Terminalia tomantosa)");
                        } else {
                          _selectedValues
                              .remove("Thempavu(Terminalia tomantosa)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Chadachi(Grewia tiliaefolia)"),
                    value: _selectedValues
                            .contains("Chadachi(Grewia tiliaefolia)") ||
                        _selectedValues
                            .contains(" Chadachi(Grewia tiliaefolia)"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Chadachi(Grewia tiliaefolia)");
                        } else {
                          _selectedValues
                                  .remove("Chadachi(Grewia tiliaefolia)") ||
                              _selectedValues
                                  .remove(" Chadachi(Grewia tiliaefolia)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Chandana vempu(Cedrela toona)"),
                    value: _selectedValues
                            .contains("Chandana vempu(Cedrela toona)") ||
                        _selectedValues
                            .contains(" Chandana vempu(Cedrela toona)"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Chandana vempu(Cedrela toona)");
                        } else {
                          _selectedValues
                              .remove("Chandana vempu(Cedrela toona)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Vellakil(Dysoxylum malabaricum)"),
                    value: _selectedValues
                            .contains("Vellakil(Dysoxylum malabaricum)") ||
                        _selectedValues
                            .contains(" Vellakil(Dysoxylum malabaricum)"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues
                              .add("Vellakil(Dysoxylum malabaricum)");
                        } else {
                          _selectedValues
                              .remove("Vellakil(Dysoxylum malabaricum)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Irul(Xylia xylocarpa)"),
                    value: _selectedValues.contains("Irul(Xylia xylocarpa)") ||
                        _selectedValues.contains(" Irul(Xylia xylocarpa)"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Irul(Xylia xylocarpa)");
                        } else {
                          _selectedValues.remove("Irul(Xylia xylocarpa)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Ebony(Diospyrus sp.)"),
                    value: _selectedValues.contains("Ebony(Diospyrus sp.)") ||
                        _selectedValues.contains(" Ebony(Diospyrus sp.)"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Ebony(Diospyrus sp.)");
                        } else {
                          _selectedValues.remove("Ebony(Diospyrus sp.)");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Kampakam(Hopea Parviflora)"),
                    value: _selectedValues
                            .contains("Kampakam(Hopea Parviflora)") ||
                        _selectedValues.contains(" Kampakam(Hopea Parviflora)"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedValues.add("Kampakam(Hopea Parviflora)");
                        } else {
                          _selectedValues.remove("Kampakam(Hopea Parviflora)");
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Purpose,
                //  obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    labelText: 'Purpose',
                    hintText: 'trees proposed to be cut'),
              ),
            ),
          ],
        ),
      ),

      //   margin: const EdgeInsets.only(top: 10, left: 0, right: 0),
      //   child: new Text(
      //     'Trees have been cut or yet to be cut?',
      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // Row(children: <Widget>[
      //   Expanded(
      //     child: RadioListTile(
      //       title: Text(
      //         'Yes',
      //         style: TextStyle(fontFamily: 'Lato'),
      //       ),
      //       value: 1,
      //       // groupValue: _radioValue,
      //       // onChanged: _handleRadioValueChange,
      //     ),
      //   ),
      //   Expanded(
      //     child: RadioListTile(
      //       title: Text(
      //         'No',
      //         style: TextStyle(fontFamily: 'Lato'),
      //       ),
      //       value: 2,
      //       // groupValue: _radioValue,
      //       // onChanged: _handleRadioValueChange,
      //     ),
      //   ),
      // ]),
      // LayoutBuilder(builder: (context, constraints) {
      //   if (flag == true) {
      //     flag1 == true;r
      //     return Container(
      //         margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
      //         child: Column(children: <Widget>[
      //           Container(
      //             child: new Text(
      //               'Would you like to enter the log details?',
      //               style: TextStyle(
      //                   fontSize: 16, fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //           Row(children: <Widget>[
      //             Expanded(
      //               child: RadioListTile(
      //                 title: Text(
      //                   'Yes',
      //                   style: TextStyle(fontFamily: 'Lato'),
      //                 ),
      //                 value: 1,
      //                 // groupValue: _radioValue1,
      //                 // onChanged: _handleRadioValueChange1,
      //               ),
      //             ),
      //             Expanded(
      //               child: RadioListTile(
      //                 title: Text(
      //                   'No',
      //                   style: TextStyle(fontFamily: 'Lato'),
      //                 ),
      //                 value: 2,
      //                 // groupValue: _radioValue1,
      //                 // onChanged: _handleRadioValueChange1,
      //               ),
      //             ),
      //           ]),
      //         ]));
      //   } else if (flag == false) {
      //     flag1 = false;
      //     return Container(
      //       color: Colors.white,
      //     );
      //   }
      // }),

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
                    return locForm1c(
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
                        treespecies: _selectedValues.toString(),
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
                        selectProof: selectProof,
                        logData: logData);
                  }));

          setState(() {});
          // print(sessionToken + dropdownValue1 + userName);
          // }
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  void _selectedValues1() {
    if (_selectedValues.contains('Teak(Tectona grandis)')) {}
  }
}
