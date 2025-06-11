import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tigramnks/bloc/main_bloc.dart';

class Deputyfileupload extends StatefulWidget {
  final String? ids;
  const Deputyfileupload({super.key, required this.ids});

  @override
  State<Deputyfileupload> createState() => _DeputyfileuploadState();
}

class _DeputyfileuploadState extends State<Deputyfileupload> {
  String? latitude;
  String? longitude;
  File? inspectionReport;
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

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String base64File = base64Encode(await file.readAsBytes());

        setState(() {
          if (type == 'inspection') {
            inspectionReport = file;
            latitude = position.latitude.toString();
            longitude = position.longitude.toString();
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
      "app_id": widget.ids ?? "",
      "inspection_report": {
        "mime": "image/jpeg",
        "data": inspectionReport != null
            ? base64Encode(inspectionReport!.readAsBytesSync())
            : null,
      },
    };
  }

  Widget buildFileButton(String title, String type, File? file) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 28, 110, 99)),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 28, 110, 99).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.upload_file,
              color: Color.fromARGB(255, 28, 110, 99)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          file != null ? 'File selected' : 'Tap to select file',
          style: TextStyle(
            color: file != null ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          file == null ? Icons.add_circle_outline : Icons.check_circle,
          color: file == null
              ? const Color.fromARGB(255, 28, 110, 99)
              : Colors.green,
          size: 28,
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
            fontSize: 20,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 28, 110, 99).withOpacity(0.1),
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upload Inspection Report",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 28, 110, 99),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Please upload the inspection report in JPG, PNG, or PDF format.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                buildFileButton(
                    'Inspection Report', 'inspection', inspectionReport),
                const SizedBox(height: 20),
                if (inspectionReport != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 28, 110, 99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 2,
                      ),
                      onPressed: () {
                        final data = prepareData();
                        context
                            .read<MainBloc>()
                            .add(DeputyFileUpload(data: data));
                        print(data);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Submit Report",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
