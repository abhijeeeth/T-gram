import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/noctiles.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/sqflite/dbhelper.dart';

class Nocofflinesiteinspection extends StatefulWidget {
  final String appId;

  const Nocofflinesiteinspection({super.key, required this.appId});

  @override
  State<Nocofflinesiteinspection> createState() =>
      _NocofflinesiteinspectionState();
}

class _NocofflinesiteinspectionState extends State<Nocofflinesiteinspection> {
  final picker = ImagePicker();
  bool isLoading = false;

  // Image data
  List<File?> images = List.generate(4, (_) => null);
  List<String> base64Images = List.generate(4, (_) => "");
  List<String> latitudes = List.generate(4, (_) => "");
  List<String> longitudes = List.generate(4, (_) => "");

  Future<void> getLocationAndImage(int index) async {
    setState(() {
      isLoading = true;
    });

    // Check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied");
        setState(() {
          isLoading = false;
        });
        return;
      }
    }

    // Get current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      // Capture image
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        setState(() {
          images[index] = File(pickedFile.path);
          latitudes[index] = position.latitude.toString();
          longitudes[index] = position.longitude.toString();
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<String, dynamic> getFormattedData() {
    return {
      "app_id": widget.appId,
      "location_img1": base64Images[0],
      "location_img2": base64Images[1],
      "location_img3": base64Images[2],
      "location_img4": base64Images[3],
      "image1_lat": latitudes[0],
      "image2_lat": latitudes[1],
      "image3_lat": latitudes[2],
      "image4_lat": latitudes[3],
      "image1_log": longitudes[0],
      "image2_log": longitudes[1],
      "image3_log": longitudes[2],
      "image4_log": longitudes[3],
      "context": context,
    };
  }

  // Remove context from the data map for DB storage
  Map<String, dynamic> getLocationImageData() {
    return {
      "app_id": widget.appId,
      "location_img1":
          images[0] != null ? base64Encode(images[0]!.readAsBytesSync()) : null,
      "location_img2":
          images[1] != null ? base64Encode(images[1]!.readAsBytesSync()) : null,
      "location_img3":
          images[2] != null ? base64Encode(images[2]!.readAsBytesSync()) : null,
      "location_img4":
          images[3] != null ? base64Encode(images[3]!.readAsBytesSync()) : null,
      "image1_lat": latitudes[0],
      "image2_lat": latitudes[1],
      "image3_lat": latitudes[2],
      "image4_lat": latitudes[3],
      "image1_log": longitudes[0],
      "image2_log": longitudes[1],
      "image3_log": longitudes[2],
      "image4_log": longitudes[3],
    };
  }

  Widget buildImageButton(int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: const Icon(Icons.camera_alt),
        title: Text("Location Photo ${index + 1}"),
        trailing: Icon(
          images[index] == null ? Icons.close : Icons.check_circle,
          color: images[index] == null ? Colors.red : Colors.green,
        ),
        onTap: () => getLocationAndImage(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Capture Images",
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
      body: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is SiteInspectionLoaded) {
            // Fluttertoast.showToast(
            //   msg: "Images submitted successfully",
            //   backgroundColor: Colors.green,
            //   textColor: Colors.white,
            // );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => NocApplictaionTiles(
                          sessionToken: ServerHelper.token.toString(),
                        )));
          } else if (state is SiteInspectionFailed) {
            Fluttertoast.showToast(
              msg: "Failed to submit",
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return Container(
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
                    ...List.generate(4, (index) => buildImageButton(index)),
                    const SizedBox(height: 20),
                    if (images.every((img) => img != null))
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 28, 110, 99),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            // First populate the base64Images list from the image files
                            for (int i = 0; i < images.length; i++) {
                              if (images[i] != null) {
                                base64Images[i] =
                                    base64Encode(images[i]!.readAsBytesSync());
                              }
                            }

                            Map<String, dynamic> data = {
                              "app_id": widget.appId,
                              "location_img1": base64Images[0],
                              "location_img2": base64Images[1],
                              "location_img3": base64Images[2],
                              "location_img4": base64Images[3],
                              "image1_lat": latitudes[0],
                              "image2_lat": latitudes[1],
                              "image3_lat": latitudes[2],
                              "image4_lat": latitudes[3],
                              "image1_log": longitudes[0],
                              "image2_log": longitudes[1],
                              "image3_log": longitudes[2],
                              "image4_log": longitudes[3],
                            };

                            // Store to application_location_images table
                            int result = await DbHelper()
                                .insertApplicationLocationImages(data);
                            if (result > 0) {
                              Fluttertoast.showToast(
                                msg: "Images saved locally",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );
                              // Optionally navigate or pop
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => NocApplictaionTiles(
                              //               sessionToken:
                              //                   ServerHelper.token.toString(),
                              //             )));
                            } else {
                              Fluttertoast.showToast(
                                msg: "Failed to save images",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: state is SiteInspectionLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white)
                                : const Text(
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
          );
        },
      ),
    );
  }
}
