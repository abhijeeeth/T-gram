import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
      {required this.userId,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userMobile,
      required this.userAddress});

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
  // Changed from late to nullable to prevent initialization error
  Barcode? result;
  late MobileScannerController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  _QueryPageState(this.userId, this.sessionToken, this.userName, this.userEmail,
      this.userMobile, this.userAddress);

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
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
      appBar: AppBar(
        title: const Text("QR Scanner"),
        elevation: 0,
      ),
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
                  // Modified to handle null result
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.rawValue}')
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
                            await controller.toggleTorch();
                            setState(() {});
                          },
                          // Replace FutureBuilder with a simple Text widget
                          child: const Text('Flash',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Back',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
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
                          child: const Text('Pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 14),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.start();
                          },
                          child: const Text('Start',
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
                              // Add null check before accessing result
                              if (result != null && result!.rawValue != null) {
                                String requestCode = result!.rawValue!;
                                String modifiedCode =
                                    requestCode.replaceAll(":8000", "");

                                // Use launchUrl with correct Uri parsing
                                if (await canLaunchUrl(
                                    Uri.parse(modifiedCode))) {
                                  await launchUrl(Uri.parse(modifiedCode));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Could not launch URL: $modifiedCode')),
                                  );
                                }

                                print("----QRURI----");
                                print(result!.rawValue);

                                // Safely extract substring if possible
                                if (result!.rawValue!.length >= 42) {
                                  String newString =
                                      result!.rawValue!.substring(39, 42);
                                  print(newString);
                                }
                                print(userId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No QR code scanned yet')),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.camera,
                            )),
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

  void _onPermissionSet(
      BuildContext context, MobileScannerController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
