import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Deputyfileupload extends StatefulWidget {
  const Deputyfileupload({super.key});

  @override
  State<Deputyfileupload> createState() => _DeputyfileuploadState();
}

class _DeputyfileuploadState extends State<Deputyfileupload> {
  File? inspectionReport;
  File? surveyReport;
  File? surveySketch;

  String? ids;
  bool isLoading = false;

  Future<void> pickFile(String type) async {
    setState(() {
      isLoading = true;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          switch (type) {
            case 'inspection':
              inspectionReport = file;
              break;
            case 'survey':
              surveyReport = file;
              break;
            case 'sketch':
              surveySketch = file;
              break;
          }
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<String, dynamic> prepareData() {
    return {
      "app_id": ids,
      "location_img1": {
        "mime": "image/jpeg",
        "data": inspectionReport != null
            ? base64Encode(inspectionReport!.readAsBytesSync())
            : null
      },
      "location_img2": {
        "mime": "image/jpeg",
        "data": surveyReport != null
            ? base64Encode(surveyReport!.readAsBytesSync())
            : null
      },
      "location_img3": {
        "mime": "image/jpeg",
        "data": surveySketch != null
            ? base64Encode(surveySketch!.readAsBytesSync())
            : null
      },
    };
  }

  Widget buildFileButton(String title, String type, File? file) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: const Icon(Icons.upload_file),
        title: Text(title),
        trailing: Icon(
          file == null ? Icons.close : Icons.check_circle,
          color: file == null ? Colors.red : Colors.green,
        ),
        onTap: () => pickFile(type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Files',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 28, 110, 99),
                Color.fromARGB(207, 28, 110, 99),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(0, 28, 110, 99),
              Color.fromARGB(36, 0, 105, 91),
              Color.fromARGB(34, 105, 138, 132),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 20),
                buildFileButton(
                    'Inspection Report', 'inspection', inspectionReport),
                buildFileButton('Survey Report', 'survey', surveyReport),
                buildFileButton('Survey Sketches', 'sketch', surveySketch),
                const SizedBox(height: 20),
                if (inspectionReport != null &&
                    surveyReport != null &&
                    surveySketch != null)
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 28, 110, 99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        final data = prepareData();
                        print(data);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isLoading)
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color.fromARGB(73, 255, 255, 255),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 28, 110, 99),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
