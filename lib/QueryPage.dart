import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QueryPage extends StatefulWidget {
  int userId;
  String sessionToken;
  String userName;

  String userEmail;
  String userMobile;
  String userAddress;
  QueryPage(
      {super.key,
      required this.userId,
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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (result != null)
                    Text(
                      'Type: ${describeEnum(result!.format)}\nData: ${result!.rawValue}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    )
                  else
                    const Text(
                      'Scan a QR code',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await controller.toggleTorch();
                          setState(() {});
                        },
                        icon: const Icon(Icons.flash_on),
                        label: const Text('Flash'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await controller.stop();
                        },
                        icon: const Icon(Icons.pause),
                        label: const Text('Pause'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await controller.start();
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start'),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (result != null && result!.rawValue != null) {
                        String requestCode = result!.rawValue!;
                        String modifiedCode =
                            requestCode.replaceAll(":8000", "");

                        if (await canLaunchUrl(Uri.parse(modifiedCode))) {
                          await launchUrl(Uri.parse(modifiedCode));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Could not launch URL: $modifiedCode'),
                            ),
                          );
                        }

                        print("----QRURI----");
                        print(result!.rawValue);

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
                    icon: const Icon(Icons.camera),
                    label: const Text('Process QR'),
                  ),
                ],
              ),
            ),
          ),
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
