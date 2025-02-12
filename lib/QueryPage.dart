import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QueryPage extends StatefulWidget {
  int userId;
  String sessionToken;
  String userName;

  String userEmail;
  String userMobile;
  String userAddress;
  QueryPage(
      {this.userId,
      this.sessionToken,
      this.userName,
      this.userEmail,
      this.userMobile,
      this.userAddress});

  @override
  _QueryPageState createState() => _QueryPageState(
      userId, sessionToken, userName, userEmail, userMobile, userAddress);
}

class _QueryPageState extends State<QueryPage> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  String userMobile;
  String userAddress;
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  _QueryPageState(this.userId, this.sessionToken, this.userName, this.userEmail,
      this.userMobile, this.userAddress);

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                    // return Text('Flash: ${snapshot.data}',
                                    style: TextStyle(fontSize: 20));
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
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
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: ElevatedButton(
                            onPressed: () async {
                              String requestCode = result.code;
                              String modifiedCode =
                                  requestCode.replaceAll(":8000", "");
                              await launch(modifiedCode);
                              print("----QRURI----");
                              print(result.code);
                              String newString = result.code.substring(39, 42);
                              print(userId);
                              //String newString = result.code.substring(0, result.code.indexOf('/SA'));
                              //    var newString = result.code.substring((result.code.length - 5).clamp(0, result.code.length));
                              print(newString);
                            },
                            child: Icon(
                              Icons.camera,
                            )
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
