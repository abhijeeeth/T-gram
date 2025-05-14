import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tigramnks/checkPostDash.dart';
import 'package:tigramnks/server/serverhelper.dart';

class queryPage extends StatefulWidget {
  int userId;
  String sessionToken;
  String userName;

  String userEmail;
  String userMobile;
  String userAddress;
  String userGroup;
  queryPage(
      {super.key,
      required this.userId,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userMobile,
      required this.userAddress,
      required this.userGroup});

  @override
  _queryPageState createState() => _queryPageState(userId, sessionToken,
      userName, userEmail, userMobile, userAddress, userGroup);
}

class _queryPageState extends State<queryPage> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  String userMobile;
  String userAddress;
  String userGroup;
  Barcode? result; // Change to nullable
  late MobileScannerController controller = MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  _queryPageState(this.userId, this.sessionToken, this.userName, this.userEmail,
      this.userMobile, this.userAddress, this.userGroup);
  bool isShow = false;
  String latImage2 = "";
  String longImage2 = "";
  var _remarkfile;

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
      const String url = '${ServerHelper.baseUrl}auth/scaned_details';
      Map data = {
        "app_form_id": newString,
        "checkpost_officer_id": userId,
        "check_log": "10.131440",
        // "check_log": latImage2,
        "check_lat": "76.352207",
        // "check_lat": longImage2,
        "remark": _remarkfile,
        "user_group": "checkpost officer"
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
      controller.stop();
    }
    controller.start();
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
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.rawValue}')
                  else
                    const Text('Scan a code'),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 50),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.toggleTorch();
                            setState(() {});
                          },
                          child: const Text('Flash',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ElevatedButton(
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
                                      return checkPost(
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
                            await controller.stop();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 14),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.start();
                          },
                          child: const Text('start',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                  Row(
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
                        margin: const EdgeInsets.only(left: 25, top: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            getCurrentLocation2();
                            // await launch(result.code);

                            print("----QRURI----");

                            print(result!.rawValue);
                            String newString =
                                result!.rawValue!.substring(39, 42);
                            print(userId);
                            //String newString = result.code.substring(0, result.code.indexOf('/SA'));
                            //    var newString = result.code.substring((result.code.length - 5).clamp(0, result.code.length));
                            print(newString);
                            if (latImage2 != "") {
                              submitData(newString);
                              // const String url =
                              //     '${ServerHelper.baseUrl}auth/scaned_details';
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
                            child: const Column(
                              children: [
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

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return MobileScanner(
      controller: controller,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        if (barcodes.isNotEmpty) {
          setState(() {
            result = barcodes.first;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
