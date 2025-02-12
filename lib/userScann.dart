import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tigramnks/acknowlegeUser.dart';
import 'package:tigramnks/checkPostDash.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class userScan extends StatefulWidget {
  int userId;
  String sessionToken;
  String userName;

  String userEmail;

  String userGroup;
  userScan(
      {this.userId,
      this.sessionToken,
      this.userName,
      this.userEmail,
      this.userGroup});

  @override
  _userScanState createState() =>
      _userScanState(userId, sessionToken, userName, userEmail, userGroup);
}

class _userScanState extends State<userScan> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;

  String userGroup;
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  _userScanState(this.userId, this.sessionToken, this.userName, this.userEmail,
      this.userGroup);
  bool isShow = false;
  String latImage2 = "";
  String longImage2 = "";
  var _remarkfile = null;

  void getCurrentLocation2() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi3 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage2 == null || longImage2 == null) {
      getCurrentLocation2();
    }
    print(latImage2);
    setState(() {
      latImage2 = posi3.latitude.toString();
      longImage2 = posi3.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void submitData(String newString) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    final filee = result.files.first;
    print(result.files.first.name);
    _remarkfile = (result.files.first.name);
    print(_remarkfile);
    if (_remarkfile != null) {
      const String url = 'http://13.234.208.246/api/auth/scaned_details';
//USER ACKNOLEGEMENT
      Map data = {
        "app_form_id": newString,
        "checkpost_officer_id": userId,
        "check_log": "10.647774",
        // "check_log": latImage2,
        "check_lat": "76.816678",
        // "check_lat": longImage2,
        "remark": _remarkfile,
        "user_group": "user"
      };
      print(data);
      var body = json.encode(data);
      print(body);
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "token $sessionToken"
          },
          body: body);
      print(response.body);

      Map<String, dynamic> responseJson = json.decode(response.body);

      print("----------------From Submit-----------------------");

      print(responseJson);
      if (responseJson['message'] != "Data Fetched Successfully.") {
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
          msg: responseJson['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 8,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 18.0);
      setState(() {
        isShow = false;
      });
    }
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 3, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    // Row(children: <Widget>[
                    //   Container(
                    //       child: new ElevatedButton(
                    //     onPressed: _launchURL,
                    //     child: new Text('Show Flutter homepage'),
                    //   ))
                    // ])

                    Text(
                        'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 50),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash',
                                    style: const TextStyle(fontSize: 20));
                              },
                            )),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ElevatedButton(
                          //  style: ButtonStyle(padding: EdgeInsets.only()),
                          onPressed: () async {
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
                                    pageBuilder:
                                        (context, animation, animationTime) {
                                      return acknowUser(
                                        sessionToken: sessionToken,
                                        userName: userName,
                                        userEmail: userEmail,
                                      );
                                    }));
                          },
                          child: const Text('Back',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )

                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //       onPressed: () async {
                      //         await controller?.flipCamera();
                      //         setState(() {});
                      //       },
                      //       child: FutureBuilder(
                      //         future: controller?.getCameraInfo(),
                      //         builder: (context, snapshot) {
                      //           if (snapshot.data != null) {
                      //             return Text(
                      //                 'Camera facing ${describeEnum(snapshot.data)}');
                      //           } else {
                      //             return const Text('loading');
                      //           }
                      //         },
                      //       )),
                      // )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsets.only(top: 4, right: 50, left: 5),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 14),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('start',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: const EdgeInsets.only(right: 25),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.pauseCamera();
                      //     },
                      //     child: const Text('pause',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ElevatedButton(
                          onPressed: () async {
                            getCurrentLocation2();
                            // await launch(result.code);

                            print("----QRURI----");

                            print(result.code);
                            String newString = result.code.substring(39, 42);
                            print(userId);
                            //String newString = result.code.substring(0, result.code.indexOf('/SA'));
                            //    var newString = result.code.substring((result.code.length - 5).clamp(0, result.code.length));
                            print(newString);
                            if (newString != null && latImage2 != "") {
                              await submitData(newString);
                              String requestCode = result.code;
                              String modifiedCode =
                                  requestCode.replaceAll(":8000", "");
                              await launch(modifiedCode);
                              // const String url =
                              //     'http://13.234.208.246/api/auth/scaned_details';
                              // Map data = {
                              //   "app_form_id": newString,
                              //   "checkpost_officer_id": userId,
                              //   "check_log": latImage2,
                              //   "check_lat": longImage2
                              // };
                              // print(data);
                              // var body = json.encode(data);
                              // print(body);
                              // final response = await http.post(Uri.parse(url),
                              //     headers: {
                              //       'Content-Type': 'application/json',
                              //       'Authorization': "token $sessionToken"
                              //     },
                              //     body: body);
                              // print(response.body);

                              // Map<String, dynamic> responseJson =
                              //     json.decode(response.body);

                              // print(
                              //     "----------------From Submit-----------------------");

                              // print(responseJson);
                              // if (responseJson['message'] !=
                              //     "Data Fetched Successfully.") {
                              //   isShow = false;
                              //   Fluttertoast.showToast(
                              //       msg: "Something went wrong",
                              //       toastLength: Toast.LENGTH_SHORT,
                              //       gravity: ToastGravity.CENTER,
                              //       timeInSecForIosWeb: 4,
                              //       backgroundColor: Colors.red,
                              //       textColor: Colors.white,
                              //       fontSize: 18.0);
                              // }
                              // await loginAction();
                              // Fluttertoast.showToast(
                              //     msg: responseJson['message'].toString(),
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 8,
                              //     backgroundColor: Colors.blue,
                              //     textColor: Colors.white,
                              //     fontSize: 18.0);
                              // setState(() {
                              //   isShow = false;
                              // });
                            }
                          },
                          child: Container(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.camera,
                                ),
                                Text("Submit Data \n with Remark"),
                              ],
                            ),
                          ),
                          // child: Text('Scan', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // _launchURL() async {
  //   if (await canLaunchUrl(Uri.parse(result.code))) {
  //     await launchUrl (Uri.parse(result.code));
  //   } else {
  //     throw 'Could not launch ${result.code}';
  //   }
  // }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
