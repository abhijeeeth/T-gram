// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io' show File;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/Form2.dart';

class FormPage1 extends StatefulWidget {
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String Tree_Proposed_to_cut;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;

  String imageone;
  String imagetwo;
  String imagethree;
  String imagefour;
  String imagelatone;
  String imagelattwo;
  String imagelatthree;
  String imagelatfour;
  String imagelongone;
  String imagelongtwo;
  String imagelongthree;
  String imagelongfour;

  String Purpose;
  List holder_1;
  bool flag1;
  List values;
  FormPage1(
      {super.key,
      required this.sessionToken,
      required this.dropdownValue,
      required this.dropdownValue1,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.Name,
      required this.Address,
      required this.survey_no,
      required this.Tree_Proposed_to_cut,
      required this.village,
      required this.Taluka,
      required this.block,
      required this.District,
      required this.Pincode,
      required this.imageone,
      required this.imagetwo,
      required this.imagethree,
      required this.imagefour,
      required this.imagelatone,
      required this.imagelattwo,
      required this.imagelatthree,
      required this.imagelatfour,
      required this.imagelongone,
      required this.imagelongtwo,
      required this.imagelongthree,
      required this.imagelongfour,
      required this.Purpose,
      required this.holder_1,
      required this.flag1,
      required this.values});
  @override
  _FormPage1State createState() => _FormPage1State(
      sessionToken,
      dropdownValue,
      dropdownValue1,
      userName,
      userEmail,
      userId,
      Name,
      Address,
      survey_no,
      Tree_Proposed_to_cut,
      village,
      Taluka,
      block,
      District,
      Pincode,
      imageone,
      imagetwo,
      imagethree,
      imagefour,
      imagelatone,
      imagelattwo,
      imagelatthree,
      imagelatfour,
      imagelongone,
      imagelongtwo,
      imagelongthree,
      imagelongfour,
      Purpose,
      holder_1,
      flag1);
}

class Item {
  const Item(this.name);
  final String name;
}

class _FormPage1State extends State<FormPage1> {
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String Tree_Proposed_to_cut;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;
  String imageone;
  String imagetwo;
  String imagethree;
  String imagefour;
  String imagelatone;
  String imagelattwo;
  String imagelatthree;
  String imagelatfour;
  String imagelongone;
  String imagelongtwo;
  String imagelongthree;
  String imagelongfour;
  String Purpose;
  List holder_1;
  bool flag1;
  String base64ImageOwn = '';
  var _imageOwn;
  String base64ImageForm = '';
  var _imageForm;
  String base64ImageApprove = '';
  var _imageApprove;
  String base64ImageDeclare = '';
  var _imageDeclare;
  String base64ImageSkechI = '';
  var _imageSkechI;
  String base64ImageTreeOwn = '';
  var _imageTreeOwn;
  String base64ImageIDProof = '';
  var _imageIDProof;
  int exindex = 1;

  _FormPage1State(
      this.sessionToken,
      this.dropdownValue,
      this.dropdownValue1,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name,
      this.Address,
      this.survey_no,
      this.Tree_Proposed_to_cut,
      this.village,
      this.Taluka,
      this.block,
      this.District,
      this.Pincode,
      this.imageone,
      this.imagetwo,
      this.imagethree,
      this.imagefour,
      this.imagelatone,
      this.imagelattwo,
      this.imagelatthree,
      this.imagelatfour,
      this.imagelongone,
      this.imagelongtwo,
      this.imagelongthree,
      this.imagelongfour,
      this.Purpose,
      this.holder_1,
      this.flag1);

  //----------------------
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List values = [];
  Future<Widget> AddMap(BuildContext context) async {
    return await showDialog(
        context: this.context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                insetPadding:
                    EdgeInsets.only(bottom: 30, top: 30, left: 10, right: 10),
                contentPadding: EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    //padding: EdgeInsets.only(top: 75,bottom: 75),
                    initialCameraPosition: CameraPosition(
                        target: LatLng(10.8505, 76.2711), zoom: 14),
                    //polygons: myPolygon(),
                    onMapCreated: onMapCreated,
                    markers: Set<Marker>.of(markers.values),
                    onTap: (latlang) {
                      setState(() {
                        values.clear();
                        final MarkerId markerId = MarkerId('101');
                        Marker marker = Marker(
                          markerId: markerId,
                          draggable: true,
                          position:
                              latlang, //With this parameter you automatically obtain latitude and longitude
                          infoWindow: InfoWindow(
                            title:
                                "Tree Location", //+(values.length +1).toString(),
                            snippet:
                                "( Latitude : ${latlang.latitude.toStringAsPrecision(8)} , Longitude : ${latlang.longitude.toStringAsPrecision(8)})",
                          ),
                          icon: BitmapDescriptor.defaultMarker,
                        );
                        //values.add(latlang.latitude.toStringAsPrecision(8)+" , "+ latlang.longitude.toStringAsPrecision(9));
                        setState(() {
                          markers[markerId] = marker;
                        });
                        print(
                            "---------------------Latitude/longitude----------------------");
                      });
                      values.add(latlang.latitude.toStringAsPrecision(8));
                      values.add(latlang.longitude.toStringAsPrecision(8));

                      print(values);
                      mapController.animateCamera(CameraUpdate.newLatLngZoom(
                          latlang,
                          15.0)); //we will call this function when pressed on the map
                    },
                  ),
                ),
                title: Text('Map'),
                actions: <Widget>[
                  ElevatedButton(
                    // color: Colors.yellow,
                    child: Text(
                      'OK ',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        V = true;
                      });
                      Fluttertoast.showToast(
                          msg: "location feched successfulluy",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 8,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 18.0);
                      Navigator.of(context).pop();
                    },
                  ),
                ]);
          });
        });
  }

  String GetLatLong() {
    return values.toString();
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  //----------------------
  final picker = ImagePicker();
  Future<void> setfilepicgallery() async {
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageForm = File(pickedFile.path);

        base64ImageForm = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepicgalleryOwn() async {
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageOwn = File(pickedFile.path);

        base64ImageOwn = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setApprovepicgallery() async {
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageApprove = File(pickedFile.path);

        base64ImageApprove = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setDeclarepicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageDeclare = File(pickedFile.path);

        base64ImageDeclare = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setSkechIpicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageSkechI = File(pickedFile.path);

        base64ImageSkechI = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setTreeOwnpicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageTreeOwn = File(pickedFile.path);

        base64ImageTreeOwn = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setIDProofpicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageIDProof = File(pickedFile.path);

        base64ImageIDProof = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  //-------------image-Picker-----------//
  void _showpickoptiondialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setfilepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogOwn(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setfilepicgalleryOwn();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogApprove(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setApprovepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogDeclaration(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setDeclarepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogSkechI(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setSkechIpicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogTreeOwn(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setTreeOwnpicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  void _showpickoptiondialogIDProof(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    // InkWell(
                    //   onTap: () async {
                    //     await setfilepiccam();
                    //   },
                    //   splashColor: Colors.blueAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.camera,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Camera',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        await setIDProofpicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {
                    //     await setprofileremove();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.remove_circle,
                    //           color: Colors.redAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Remove',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ));
  }

  // File _Application;
  // final ImagePicker _picker = ImagePicker();
  // void _RevenueApplication(ImageSource source) async {
  //   print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);

  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Application = pickedFile as File;
  //     print("------------------------------Revenue Image--------------");
  //     print(_Application.path);
  //   });
  // }
  // File _Approval;
  // final ImagePicker _picker1 = ImagePicker();
  // void _RevenueApproval(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Approval = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_Approval.path);
  //   });
  // }
  // File _Declaration;
  // final ImagePicker _picker2 = ImagePicker();
  // void Declaration(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Declaration = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_Declaration.path);
  //   });
  // }
  // File _Location;
  // final ImagePicker _picker3 = ImagePicker();
  // void _LocationSketch(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Location = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_Location.path);
  //   });
  // }
  // File _Ownership;
  // final ImagePicker _picker4 = ImagePicker();
  // void _TreeOwnership(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Ownership = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_Ownership.path);
  //   });
  // }
  // File _Proof;
  // final ImagePicker _picker5 = ImagePicker();
  // void _IdProof(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _Proof = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_Proof.path);
  //   });
  // }
  //------------end-image-picker------------//

  //-----------------------------------Geo-Locator------------------------------

  Widget getLag(BuildContext context, List values) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "Latitude : ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        TextSpan(
            text: values.isEmpty ? '' : values[0].toString(),
            style: TextStyle(
              color: Colors.blueAccent[700],
              fontSize: 14,
            )),
      ]),
    );
  }

  /*Widget getTextV(BuildContext context,double girth,double length){
    return  Text((_getVolume(girth, length).toString()).toString());
  }*/
  //-----------------------------------End-GeoLocator---------------------------
  String dropdownValue2 = '';
  String holder = '';
  List<String> IdProof = [
    'Aadhar Card',
    'Driving License',
    'Passport',
    'Government ID',
    'Voter ID',
  ];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
    print("-----------------------$holder");
  }

  String dropdownValue3 = '';
  String spacies_holder = '';

  void getDropDownItem1() {
    setState(() {
      spacies_holder = dropdownValue1;
    });
    print("-----------------------$holder");
  }

  bool flag = true;
  var b = 1;
  int a = 0;
  String selectedPRoof = '';
  List log_details = [];
  List d = [];
  List Species = [];
  List Length = [];
  List Girth = [];
  List Volume = [];
  List Latitude = [];
  List Longitude = [];
  List n_list = [];

  Map<String, String> logs = {};
  final List<TextEditingController> _controllers = [];
  late double v;
  // double _getVolume(double girth, double length) {
  //   v = ((girth * 0.01) / 4) * ((girth * 0.01) / 4) * length;
  //   return v;
  // }
  double _getVolume(double girth, double length) {
    // Convert girth from cm to meters
    double girthInMeters = girth * 0.01;

    // Calculate the radius from the girth
    double radius = girthInMeters / (2 * pi);

    // Calculate the volume of the cylinder
    double volume = pi * pow(radius, 2) * length;

    return volume;
  }

  Widget getTextV(BuildContext context, double girth, double length) {
    return Text((_getVolume(girth, length).toString()).toString());
  }

  bool V = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                          });
                        },
                        items: holder_1
                            .map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: length,
                        validator: (value) {
                          return value != null && value.isNotEmpty
                              ? null
                              : "Enter Height(M)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value != null && value.isNotEmpty
                              ? null
                              : "Enter Girth(cm)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Girth(cm)"),
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Select Tree Location',
                      //     ),
                      //     Spacer(),
                      //     IconButton(
                      //         icon: Icon(Icons.location_on,
                      //             color: Colors.lightBlue),
                      //         onPressed: () async {
                      //           final status = await Permission
                      //               .locationWhenInUse
                      //               .request();
                      //           final serviceEnabled =
                      //               await Geolocator.getCurrentPosition();
                      //           if (status == PermissionStatus.granted) {
                      //             setState(() {
                      //               AddMap(context);
                      //             });
                      //           } else {
                      //             status;
                      //           }
                      //         }),
                      //   ],
                      // ),
                      /*RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Latitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?'':values[0].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Longitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?'':values[1].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),*/
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: const Text(
                    'OK ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.isEmpty) ||
                        (girth.text.isEmpty)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                        "latitude": "00",
                        "longitude": "00"
                      };
                      log_details.add(logs);
                      int n = log_details.length;
                      n_list = [];
                      //
                      //  List n_list =[];
                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }
                      print("----n_list--");
                      print("$n_list" "NLIST");
                      print(Species);
                      print(d);
                      length.clear();
                      girth.clear();
                      Navigator.of(context).pop();
                    }

                    /* if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                    }*/
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> EditInformationDialog(BuildContext context, int index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          dropdownValue3 = log_details[index]['species_of_tree'];
          length.text = log_details[index]['length'];
          girth.text = log_details[index]['breadth'];
          volume.text = log_details[index]['volume'];
          // latitude.text = log_details[index]['latitude'];
          // longitude.text = log_details[index]['longitude'];
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                          });
                        },
                        items: holder_1
                            .map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        //initialValue: log_details[index]['length'],
                        controller: length,
                        validator: (value) {
                          return value != null && value.isNotEmpty
                              ? null
                              : "Enter height";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter height"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value != null && value.isNotEmpty
                              ? null
                              : "Enter Girth";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Girth"),
                      ),
                      /*TextFormField(
                        keyboardType: TextInputType.number,
                        controller: volume,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Volume";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter Volume"),
                      ),*/
                      /*TextFormField(
                        keyboardType: TextInputType.number,
                        controller: latitude,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter Latitude";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter  Latitude"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: longitude,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter  Longitude";
                        },
                        decoration:
                        InputDecoration(hintText: "Please Enter Longitude"),
                      ),*/
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Update Tree Location',
                      //     ),
                      //     Spacer(),
                      //     IconButton(
                      //         icon: Icon(Icons.location_on,
                      //             color: Colors.lightBlue),
                      //         onPressed: () {
                      //           values.clear();
                      //           AddMap(context);
                      //         }),
                      //   ],
                      // ),
                      /* RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Latitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?latitude.text:values[0].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Longitude : ",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: values.length==0?longitude.text:values[1].toString(),
                              style: TextStyle(
                                color: Colors.blueAccent[700],
                                fontSize: 14,
                              )),
                        ]),
                      ),*/
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text(
                    'OK ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.isEmpty) ||
                        (girth.text.isEmpty)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                        // "latitude": values.length == 0
                        //     ? latitude.text
                        //     : values[0].toString(),
                        // "longitude": values.length == 0
                        //     ? longitude.text
                        //     : values[1].toString()
                      };
                      // log_details.elementAt(int.parse(source));
                      log_details[index] = logs;
                      int n = log_details.length;
                      n_list = [];
                      //
                      //  List n_list =[];
                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }
                      print("----n_list--");
                      print(n_list);
                      print(Species);
                      print(d);
                      if (_formKey.currentState?.validate() ?? false) {
                        // Do something like updating SharedPreferences or User Settings etc.
                        length.clear();
                        girth.clear();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            );
          });
        });
  }

//[{},{}]

  //TextEditingController length = TextEditingController();
  /*List<TextEditingController> length1 = [];
  List<TextEditingController>girth2 = [];
  List<TextEditingController> volume3 = [];
  List<TextEditingController> latitude4 = [];
  List<TextEditingController> longitude5 = [];*/

  String A = '';
  Map<String, TextEditingController> textEditingControllers = {};
  TextEditingController length = TextEditingController();
  TextEditingController girth = TextEditingController();
  TextEditingController volume = TextEditingController();
  // TextEditingController latitude = TextEditingController();
  // TextEditingController longitude = TextEditingController();

  /*
  class example {
  String length;
  String girth;
  String volume;
  Strung lat;
  String long;
  }
  single datatable entry field
  List<Object>

  Row()
   */
  Future<bool> _onBackPressed() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to go previous page'),
        content: Text('Changes you made may not be saved.'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    //print(_controllers);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blueGrey,
          title: Text("FORM - I"),

          elevation: 0,
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          Container(
            child: Container(
              child: Column(children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (flag1) {
                      int treeCount = int.tryParse(Tree_Proposed_to_cut) ?? 0;

                      return Column(
                        children: [
                          Column(
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  print(treeCount);
                                  print(n_list.length);

                                  if (n_list.isNotEmpty &&
                                      treeCount > n_list.length) {
                                    return Text(
                                      "Add log details for all trees",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: const <TextSpan>[
                                  TextSpan(
                                    text:
                                        "Please add Log details now, you can update from submitted forms",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.39,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0, 2.0),
                                )
                              ],
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              thickness: 15,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: <Widget>[
                                      DataTable(
                                        columns: [
                                          DataColumn(
                                            label: Text(
                                              'S.No',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Species',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Height (M)',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Girth (cm)',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Volume (Sq m)',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Row(
                                              children: <Widget>[
                                                Text(
                                                  "Add log",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.add_circle,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () async {
                                                    await showInformationDialog(
                                                        context);
                                                    setState(() {
                                                      exindex++;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        rows: List.generate(n_list.length,
                                            (index) {
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                  Text((index + 1).toString())),
                                              DataCell(SizedBox(
                                                width: 180,
                                                child: Text(log_details[index]
                                                        ['species_of_tree']
                                                    .toString()),
                                              )),
                                              DataCell(SizedBox(
                                                width: 100,
                                                child: Text(log_details[index]
                                                        ['length']
                                                    .toString()),
                                              )),
                                              DataCell(SizedBox(
                                                width: 100,
                                                child: Text(log_details[index]
                                                        ['breadth']
                                                    .toString()),
                                              )),
                                              DataCell(SizedBox(
                                                width: 100,
                                                child: Text(log_details[index]
                                                        ['volume']
                                                    .toString()),
                                              )),
                                              DataCell(Row(
                                                children: <Widget>[
                                                  Text("Remove"),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        log_details
                                                            .removeAt(index);
                                                        n_list.removeLast();
                                                      });
                                                    },
                                                  ),
                                                  Text("Edit"),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.edit_rounded,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () async {
                                                      await EditInformationDialog(
                                                          context, index);
                                                      setState(() {});
                                                    },
                                                  )
                                                ],
                                              )),
                                            ],
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(color: Colors.white);
                    }
                  },
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialogOwn(context);
                          //  takePhoto(ImageSource.gallery);
                        });
                      },
                      label: Text("Proof of ownership"),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: (_imageOwn) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialog(context);
                        });
                        //  _RevenueApplication(ImageSource.gallery);
                      },
                      label: Text("Revenue Application "),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: (_imageForm) == null ? Colors.red : Colors.green,
                      //  color: (_Application?.path) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialogApprove(context);
                        });
                        // _RevenueApproval(ImageSource.gallery);
                      },
                      label: Text("Revenue Approval"),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color:
                          (_imageApprove) == null ? Colors.red : Colors.green,
                      //  color: (_Approval?.path) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialogDeclaration(context);
                          //  takePhoto(ImageSource.gallery);
                        });
                        // Declaration(ImageSource.gallery);
                      },
                      label: Text("Declaration"),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color:
                          (_imageDeclare) == null ? Colors.red : Colors.green,
                      //color: (_Declaration?.path) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialogSkechI(context);
                          //  takePhoto(ImageSource.gallery);
                        });
                        // _LocationSketch(ImageSource.gallery);
                      },
                      label: Text("Location Sketch"),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: (_imageSkechI) == null ? Colors.red : Colors.green,
                      // color: (_Location?.path) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 20, top: 10, bottom: 0),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialogTreeOwn(context);
                          //  takePhoto(ImageSource.gallery);
                        });
                        // _TreeOwnership(ImageSource.gallery);
                      },
                      label: Text("Tree Ownership Details"),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color:
                          (_imageTreeOwn) == null ? Colors.red : Colors.green,
                      //color: (_Ownership?.path) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 0),
                  child: DropdownButton<String>(
                    value: dropdownValue2,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    hint: Text("Select Photo Identity Proof"),
                    /*underline: Container(
                             height: 2,
                             color: Colors.grey,
                           ),*/
                    onChanged: (String? data) {
                      setState(() {
                        dropdownValue2 = data!;
                        selectedPRoof = dropdownValue2;
                      });
                      print(selectedPRoof);
                    },
                    items:
                        IdProof.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 15, left: 15, right: 15, bottom: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 15, top: 10, bottom: 5),
                  child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    TextButton.icon(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          _showpickoptiondialogIDProof(context);
                          //  takePhoto(ImageSource.gallery);
                        });
                        //  _IdProof(ImageSource.gallery);
                      },
                      label: Text("Upload Photo ID Proof"),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color:
                          (_imageIDProof) == null ? Colors.red : Colors.green,
                      // color: (_Proof?.path) == null ? Colors.red : Colors.green,
                      size: 28.0,
                    ),
                  ]),
                ),
              ]),
            ),
          )
        ]))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          backgroundColor: HexColor("#0499f2"),
          onPressed: () {
            if (base64ImageOwn == "") {
              Fluttertoast.showToast(
                  msg: "Please add proof of ownership",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (base64ImageForm == "") {
              Fluttertoast.showToast(
                  msg: "Please add revenue application",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (base64ImageApprove == "") {
              Fluttertoast.showToast(
                  msg: "Please add revenue approval",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (base64ImageDeclare == "") {
              Fluttertoast.showToast(
                  msg: "Please add declaration",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (base64ImageSkechI == "") {
              Fluttertoast.showToast(
                  msg: "Please add location skech",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (base64ImageTreeOwn == "") {
              Fluttertoast.showToast(
                  msg: "Please add tree ownership",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if ((base64ImageIDProof != '') && (dropdownValue2 == null)
                // (base64ImageForm == 'empty')
                // (base64ImageApprove == 'empty') ||
                // (base64ImageDeclare == 'empty') ||
                // (base64ImageSkechI == 'empty') ||
                // (base64ImageTreeOwn == 'empty') ||
                // (dropdownValue2 == null) ||
                // (base64ImageIDProof == 'empty')

                ) {
              Fluttertoast.showToast(
                  msg: "Please select type of ID proof",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (base64ImageIDProof == "") {
              Fluttertoast.showToast(
                  msg: "Please add Id proof",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 400),
                    transitionsBuilder:
                        (context, animation, animationTime, child) {
                      return ScaleTransition(
                        alignment: Alignment.topCenter,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, animationTime) {
                      if (log_details.isNotEmpty) {
                        String log = json.encode(log_details);
                        print("FFFFFF$log");
                      }
                      return Form2(
                          sessionToken: sessionToken,
                          dropdownValue: dropdownValue,
                          dropdownValue1: dropdownValue1,
                          userName: userName,
                          userEmail: userEmail,
                          userId: userId,
                          Name: Name,
                          Address: Address,
                          survey_no: survey_no,
                          Tree_Proposed_to_cut: Tree_Proposed_to_cut,
                          village: village,
                          Taluka: Taluka,
                          block: block,
                          District: District,
                          Pincode: Pincode,
                          imageone: imageone,
                          imagetwo: imagetwo,
                          imagethree: imagethree,
                          imagefour: imagefour,
                          imagelatone: imagelatone,
                          imagelattwo: imagelattwo,
                          imagelatthree: imagelatthree,
                          imagelatfour: imagelatfour,
                          imagelongone: imagelongone,
                          imagelongtwo: imagelongtwo,
                          imagelongthree: imagelongthree,
                          imagelongfour: imagelongfour,
                          Purpose: Purpose,
                          holder_1: holder_1,
                          Ownership: base64ImageOwn,
                          Application: base64ImageForm,
                          Approval: base64ImageApprove,
                          Declaration: base64ImageDeclare,
                          Location: base64ImageSkechI,
                          TreeOwnership: base64ImageTreeOwn,
                          IdProof: base64ImageIDProof,
                          log_details: log_details,
                          selectedPRoof: selectedPRoof);
                    }),
              );
              setState(() {});
            }
          },
          // isExtended: true,
          child: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}

class table extends StatefulWidget {
  const table({super.key});

  @override
  _tableState createState() => _tableState();
}

class _tableState extends State<table> {
  bool flag = true;
  List tcount = [1];
  late List b;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text(
                  'S.No',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  'Species  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  ' Length   ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  '  Girth  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  ' Volume   ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  'Latitude ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  'longitude',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
                DataColumn(
                    label: Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )),
              ],
              rows:
                  tcount // Loops through dataColumnText, each iteration assigning the value to element
                      .map(((index) => DataRow(cells: [
                            DataCell((Text(tcount.length.toString()))),
                            DataCell(TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            )),
                            DataCell(TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            )),
                            DataCell(TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            )),
                            DataCell(TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            )),
                            DataCell(TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            )),
                            DataCell(TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            )),
                            DataCell(Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    int a = 1;
                                    setState(() {
                                      a = a++;
                                    });
                                    tcount.add(a);
                                    print("-------------Total-log------------");
                                    print(tcount);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    print("-------------Total-log------------");
                                    print(tcount);
                                    setState(() {
                                      if (tcount.length > 1) {
                                        tcount.removeLast();
                                      }
                                    });
                                  },
                                )
                              ],
                            )),
                          ])))
                      .toList(),
            ),
          ),
        ));
  }
}
