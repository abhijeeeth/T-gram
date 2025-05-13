import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/locForm1a.dart';
import 'package:tigramnks/sqflite/DatabaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../homePage.dart';
import 'formModel.dart';

class localdataForms extends StatefulWidget {
  final int userId;
  final String userName;
  final String userEmail;
  final String sessionToken;

  const localdataForms({
    super.key,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
    required this.userId,
  });

  @override
  State<localdataForms> createState() => _localdataFormsState(
        sessionToken,
        userName,
        userEmail,
      );
}

class _localdataFormsState extends State<localdataForms> {
  @override
  void initState() {
    super.initState();
    // viewData();
  }

  final dbHelper = DatabaseHelper.instance;
  List<Car> cars = [];
  List<Car> carsByName = [];
  final List sr = [];
  final List Ids = [];
  final List Type = [];
  final List App_no = [];
  final List Division = [];
  final List Range = [];
  final List District = [];
  final List Taluk = [];
  final List Village = [];
  final List address = [];
  final List survay = [];
  final List treePCut = [];
  final List block = [];
  final List pin = [];
  final List imageA = [];
  final List imageB = [];
  final List imageC = [];
  final List imageD = [];
  final List image1lat = [];
  final List image2lat = [];
  final List image3lat = [];
  final List image4lat = [];
  final List image1log = [];
  final List image2log = [];
  final List image3log = [];
  final List image4log = [];
  final List treespecies = [];
  final List purposecut = [];
  final List drivername = [];
  final List vechclereg = [];
  final List mode = [];
  final List phone = [];
  final List destAddress = [];
  final List destState = [];
  final List licenceImg = [];
  final List ownerProof = [];
  final List revenApplication = [];
  final List revenApprove = [];
  final List declaration = [];
  final List locationSkch = [];
  final List treeOwnership = [];
  final List aadarcard = [];
  final List signatureImg = [];
  final List selectProof = [];
  final List logData = [];
  final int userId;
  final String sessionToken;
  final String userName;
  final String userEmail;
  int allApplication = 0; // Added variable declaration

  _localdataFormsState(this.sessionToken, this.userName, this.userEmail)
      : userId = 0; // Default value or get it from widget
  String hideB = "true";
  // viewData() {
  //   print(allApplication);

  //   if (allApplication == 0) {
  //     hideB = "true";
  //   } else {
  //     hideB = "false";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Forms View Dashboard"),

          //backgroundColor: Colors.blueGrey,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Visibility(
            visible: hideB == "true",
            child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                  child: const Text('Refresh'),
                  onPressed: () {
                    setState(() {
                      _queryAll();
                    });
                  },
                )),
          ),
          LayoutBuilder(builder: (context, constraints) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.deepOrangeAccent,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      //offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                margin: const EdgeInsets.only(
                    left: 5, right: 5, top: 2, bottom: 10),
                padding:
                    const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
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
                                columns: const [
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
                                    'Type',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Survay No',
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
                                    'Delete',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ],
                                rows:
                                    sr // Loops through dataColumnText, each iteration assigning the value to element
                                        .map(((value) => DataRow(
                                              cells: <DataCell>[
                                                DataCell((Text(
                                                    (int.parse(value) + 1)
                                                        .toString()))),
                                                DataCell(Text(
                                                    Type[int.parse(value)]
                                                        .toString())),
                                                DataCell(Text(App_no[
                                                        int.parse(value)]
                                                    .toString())), //Extracting from Map element the value

                                                DataCell(Text(
                                                    address[int.parse(value)]
                                                        .toString())),
                                                DataCell(Text(
                                                    survay[int.parse(value)]
                                                        .toString())),
                                                DataCell(
                                                  Visibility(
                                                    visible: true,
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.visibility),
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                locForm1a(
                                                              sessionToken:
                                                                  sessionToken,
                                                              userId: userId,
                                                              id: (int.parse(
                                                                      value) +
                                                                  1),
                                                              Type: Type[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              userName:
                                                                  userName,
                                                              userEmail:
                                                                  userEmail,
                                                              App_no: App_no[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              Division: Division[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              Range: Range[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              District: District[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              Taluk: Taluk[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              Village: Village[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              address: address[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              survay: survay[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              treePCut: treePCut[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              blockL: block[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              pin: pin[int.parse(
                                                                      value)]
                                                                  .toString(),
                                                              imageA: imageA[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              imageB: imageB[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              imageC: imageC[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              imageD: imageD[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image1lat: image1lat[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image2lat: image2lat[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image3lat: image3lat[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image4lat: image4lat[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image1log: image1log[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image2log: image2log[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image3log: image3log[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              image4log: image4log[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              treespecies: treespecies[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              purposecut: purposecut[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              drivername: drivername[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              vechclereg: vechclereg[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              mode: mode[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              phone: phone[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              destAddress: destAddress[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              destState: destState[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              licenceImg: licenceImg[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              ownerProof: ownerProof[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              revenApplication:
                                                                  revenApplication[
                                                                          int.parse(
                                                                              value)]
                                                                      .toString(),
                                                              revenApprove: revenApprove[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              declaration: declaration[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              locationSkch: locationSkch[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              treeOwnership:
                                                                  treeOwnership[
                                                                          int.parse(
                                                                              value)]
                                                                      .toString(),
                                                              aadarcard: aadarcard[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              signatureImg: signatureImg[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              selectProof: selectProof[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                              logData: logData[
                                                                      int.parse(
                                                                          value)]
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                DataCell(
                                                  Visibility(
                                                    visible: true,
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        int id =
                                                            (int.parse(value));
                                                        _delete(id + 1);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )))
                                        .toList(),
                              ),
                            )))));
          })
        ])));
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    cars.clear();
    for (var row in allRows) {
      cars.add(Car.fromMap(row));
    }

    setState(() {
      if (cars.isNotEmpty) {
        hideB = "false";
      }
      allApplication = cars.length;
    });

    for (var i = 0; i < allApplication; i++) {
      sr.add(i.toString());
      Type.add(cars[i].formtype);
      App_no.add(cars[i].name);
      Division.add(cars[i].selDivision);
      Range.add(cars[i].selRange);
      District.add(cars[i].selDistrict);
      Taluk.add(cars[i].selTaluk);
      Village.add(cars[i].selVillage);
      address.add(cars[i].address);
      survay.add(cars[i].survay);
      treePCut.add(cars[i].treePCut);
      block.add(cars[i].blockL);
      pin.add(cars[i].pin);
      imageA.add(cars[i].locImageA);
      imageB.add(cars[i].locImageB);
      imageC.add(cars[i].locImageC);
      imageD.add(cars[i].locImageD);
      image1lat.add(cars[i].image1lat);
      image2lat.add(cars[i].image2lat);
      image3lat.add(cars[i].image3lat);
      image4lat.add(cars[i].image4lat);
      image1log.add(cars[i].image1log);
      image2log.add(cars[i].image2log);
      image3log.add(cars[i].image3log);
      image4log.add(cars[i].image4log);
      treespecies.add(cars[i].treespecies.toString());
      purposecut.add(cars[i].purposecut);
      drivername.add(cars[i].drivernameLoc);
      vechclereg.add(cars[i].vehicelreg);
      phone.add(cars[i].phone);
      mode.add(cars[i].mode);
      destAddress.add(cars[i].destinationaddress);
      destState.add(cars[i].destinationstate);
      licenceImg.add(cars[i].licenceImg);
      ownerProof.add(cars[i].ownershipproofimg);
      revenApplication.add(cars[i].revenueapplicationimg);
      revenApprove.add(cars[i].revenueapprovalimg);
      declaration.add(cars[i].declarationimg);
      locationSkch.add(cars[i].locationsketchimg);
      treeOwnership.add(cars[i].treeownershipimg);
      aadarcard.add(cars[i].aadharcardimg);
      signatureImg.add(cars[i].signatureimg);
      selectProof.add(cars[i].selectProof);
      logData.add(cars[i].logData);
    }
  }

  void _delete(id) async {
    final rowsDeleted = await dbHelper.delete(id) + 1;

    Fluttertoast.showToast(
        msg: "deleted $rowsDeleted form ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0);
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (context, animation, animationTime, child) {
              return ScaleTransition(
                alignment: Alignment.topCenter,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              return HomePage(
                  sessionToken: sessionToken,
                  userName: userName,
                  userEmail: userEmail,
                  userId: userId,
                  userMobile: '',
                  userAddress: '',
                  userProfile: '',
                  userGroup: '',
                  userCato: '');
            }));
  }
}
//       ),return Container(
//       child: ListView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: cars.length + 1,
//         itemBuilder: (BuildContext context, int index) {
//           if (index == cars.length) {
//             return ElevatedButton(
//               child: Text('Refresh'),
//               onPressed: () {
//                 setState(() {
//                   _queryAll();
//                 });
//               },
//             );
//           }
//           return Container(
//             height: 40,
//             child: Center(
//               child: Text(
//                 '[${cars[index].id}] ${cars[index].name} - ${cars[index].type} type',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _queryAll() async {
//     final allRows = await dbHelper.queryAllRows();
//     cars.clear();
//     allRows.forEach((row) => cars.add(Car.fromMap(row)));

//     setState(() {});
//   }
// }
