import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/Form2Page2.dart';

class Form2Page1 extends StatefulWidget {
  String sessionToken;
  String userName;
  String userEmail;
  int userId;

  Form2Page1({
    super.key,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
    required this.userId,
  });
  @override
  _Form2Page1State createState() =>
      _Form2Page1State(sessionToken, userName, userEmail, userId);
}

class _Form2Page1State extends State<Form2Page1> {
  String sessionToken;
  String userName;
  String userEmail;
  int userId;

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController Taluka = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController District = TextEditingController();
  TextEditingController Pincode = TextEditingController();

  //----------------------end-Controller-------------------

  String base64ImagePic1 = "";
  var _image1;
  String base64ImagePic2 = "";
  var _image2;
  String base64ImagePic3 = "";
  var _image3;
  String base64ImagePic4 = "";
  var _image4;
  String latImage1 = "";
  String longImage1 = "";
  String latImage2 = "";
  String longImage2 = "";
  String latImage3 = "";
  String longImage3 = "";
  String latImage4 = "";
  String longImage4 = "";
  // File _imageFile;
  // final ImagePicker _picker = ImagePicker();
  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _imageFile = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_imageFile.path);
  //   });
  // }

  late String dropdownValue;
  String range_holder = '';
  List<String> range = [
    'Paruthippally',
    'Kulathupuzha',
    'Palode',
  ];
  void getDropDownItem() {
    setState(() {
      range_holder = dropdownValue;
    });
    print(range_holder);
  }

  late String dropdownValue1;
  String division_holder = '';
  List<String> Division = [
    'Trivandrum',
  ];
  void getDropDownItem1() {
    setState(() {
      division_holder = dropdownValue1;
    });
    print("------------$division_holder");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      ListRange();
      LoadDistric();
      //ListDivision();
    });
  }

  //------------------------------Taluka & Distric------------------------------
  late String selectedTalukaF1;
  late String selectedDistrict;
  //----------------------------District----------------------------------
  List<String> district = [];
  LoadDistric() async {
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/ListDistrict';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
      for (int i = 0; i < RL; i++) {
        district.add(responseJSON["data"][i]['district_name']);
      }
    });
  }

  //-----------------taluka----------------------
  List<String> taluka1 = [];
  LoadTaluka() async {
    int RL = 0;
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/LoadTaluka';

    Map data = {
      "district": selectedDistrict ?? "",
    };
    print(data);
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJson);
    setState(() {
      RL = responseJson["data"].length;
      for (int i = 0; i < RL; i++) {
        taluka1.add(responseJson["data"][i]['taluka_name']);
      }
    });
  }

  //----------------------------------Village--------------------------------
  late String SelectedVillage;
  List<String> Village = [];
  LoadVillage() async {
    int RL = 0;
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/LoadVillage';
    Map data = {"taluka": selectedTalukaF1 ?? ""};
    print(data);
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("----------------------------Village-----------------------");
    print(responseJson);
    setState(() {
      RL = responseJson["data"].length;
      for (int i = 0; i < RL; i++) {
        Village.add(responseJson["data"][i]['village_name']);
      }
    });
  }

  //---------------------------------End-Village-----------------------------

  //-----------------------------End-Taluka & Distric---------------------------
//---------------------------------DropDownList Api Connection------------------
  List<String> Rname = [];
  int RL = 0;
  ListRange() async {
    const String url = 'https://timber.forest.kerala.gov.in/api/auth/ListRange';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
      for (int i = 0; i < RL; i++) {
        Rname.add(responseJSON["data"][i]['name']);
      }
    });
    Rname.toSet().toList();
    print(Rname);
  }

  late String DD;
  List<String> Dname = [];

  int DL = 0;
  ListDivision() async {
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/LoadDivision';
    Map data = {
      "range_area": dropdownValue ?? "",
    };
    print(data);
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJson);

    setState(()
        //   Dname.insert(0, responseJson["data"][0]['name']);
        //   if (Dname.length > 2) {
        //     Dname.removeLast();
        //   }
        // });

        {
      DL = responseJson["data"].length;
    });
    for (int i = 0; i < DL; i++) {
      Dname.add(responseJson["data"][i]['name']);
    }

    print(Dname);
  }

  final picker = ImagePicker();

  void getCurrentLocation1() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi2 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage1 == "" || longImage1 == "") {
      getCurrentLocation1();
    }
    print(latImage1);
    setState(() {
      latImage1 = posi2.latitude.toString();
      longImage1 = posi2.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

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
    if (latImage2 == "" || longImage2 == "") {
      getCurrentLocation2();
    }
    print(latImage2);
    setState(() {
      latImage2 = posi3.latitude.toString();
      longImage2 = posi3.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation3() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi4 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage3 == "" || longImage3 == "") {
      getCurrentLocation3();
    }
    print(latImage3);
    setState(() {
      latImage3 = posi4.latitude.toString();
      longImage3 = posi4.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  void getCurrentLocation4() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    if (latImage4 == "" || longImage4 == "") {
      getCurrentLocation4();
    }
    print(latImage4);
    setState(() {
      latImage4 = posi1.latitude.toString();
      longImage4 = posi1.longitude.toString();
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  Future<void> setfilepiccam() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image1 = File(pickedFile.path);
        base64ImagePic1 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic2() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image2 = File(pickedFile.path);
        base64ImagePic2 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic3() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image3 = File(pickedFile.path);
        base64ImagePic3 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccampic4() async {
    print('object');
    var camimage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image4 = File(pickedFile.path);
        base64ImagePic4 = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showpickoptiondialogImg1(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccam();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
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
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
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

  void _showpickoptiondialogImg2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic2();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
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
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
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

  void _showpickoptiondialogImg3(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic3();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
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
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
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

  void _showpickoptiondialogImg4(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepiccampic4();
                      },
                      splashColor: Colors.blueAccent,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Camera',
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
                    //     await setfilepicgallery();
                    //   },
                    //   splashColor: Colors.greenAccent,
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Icon(
                    //           Icons.image,
                    //           color: Colors.blueAccent,
                    //         ),
                    //       ),
                    //       Text(
                    //         'Gallery',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
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

  _Form2Page1State(
      this.sessionToken, this.userName, this.userEmail, this.userId);

  Future<bool> _onBackPressed() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go previous page'),
        content: const Text('Changes you made may not be saved.'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: const Text("YES"),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = Pincode.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '';
    }
    if (text.length < 6) {
      return 'Please input valid pincode';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "FORM - II",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          //backgroundColor: ColorLinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),

          elevation: 0,
          //automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Division                                Range",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ]),
                ),
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
                    left: 10.0, right: 10, top: 10, bottom: 0),
                child: Row(children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Select Division",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        // TextSpan(
                        //     text: " * ",
                        //     style: TextStyle(
                        //       color: Colors.red[700],
                        //       fontSize: 16,
                        //     )),
                      ]),
                    ),
                    /*underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),*/
                    onChanged: (String? data) {
                      setState(() {
                        dropdownValue = data!;
                        ListDivision();
                      });
                      print(dropdownValue);
                    },
                    items: Rname.toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  DropdownButton<String>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      hint: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select Range",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          // TextSpan(
                          //     text: " * ",
                          //     style: TextStyle(
                          //       color: Colors.red[700],
                          //       fontSize: 16,
                          //     )),
                        ]),
                      ),
                      /*underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),*/
                      onChanged: (String? data) {
                        setState(() {
                          dropdownValue1 = data!;
                        });
                      },
                      items: Dname.toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList()),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                    controller: Name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        ),
                        // border: OutlineInputBorder(),
                        labelText: 'Name*',
                        hintText: 'Enter Your Name'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: Address,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      labelText: 'Address*',
                      hintText: 'Enter Your Address'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: survey_no,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      labelText: 'Survey Number*',
                      hintText: 'Enter Survey Number'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "District                                Taluke",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ]),
                ),
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
                    left: 10.0, right: 10, top: 10, bottom: 0),
                child: Row(children: <Widget>[
                  DropdownButton<String>(
                    value: selectedDistrict,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Select District",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        // TextSpan(
                        //     text: " * ",
                        //     style: TextStyle(
                        //       color: Colors.red[700],
                        //       fontSize: 16,
                        //     )),
                      ]),
                    ),
                    /*underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),*/
                    onChanged: (String? data) {
                      setState(() {
                        selectedDistrict = data!;
                      });
                      LoadTaluka();
                      print(selectedDistrict);
                    },
                    items:
                        district.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  // DropdownButton<String>(
                  //   value: selectedTaluka,
                  //   icon: Icon(Icons.arrow_drop_down),
                  //   iconSize: 24,
                  //   elevation: 16,
                  //   style: TextStyle(color: Colors.black, fontSize: 18),
                  //   hint:  RichText(
                  //     textAlign: TextAlign.center,
                  //     text: TextSpan(children: <TextSpan>[
                  //       TextSpan(
                  //           text: "Select Taluka",
                  //           style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  //       TextSpan(
                  //           text: " * ",
                  //           style: TextStyle(
                  //             color: Colors.red[700],
                  //             fontSize: 16,
                  //           )),
                  //     ]),
                  //   ),
                  //   /*underline: Container(
                  //     height: 2,
                  //     color: Colors.grey,
                  //   ),*/
                  //   onChanged: (String data) {
                  //     setState(() {
                  //       selectedTaluka = data;
                  //     });
                  //     LoadVillage();
                  //     print(selectedTaluka);
                  //   },
                  //   items: taluka.map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                  //     );
                  //   }).toList(),
                  // ),
                  DropdownButton<String>(
                    value: selectedTalukaF1,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    hint: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Select Taluka",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        // TextSpan(
                        //     text: " * ",
                        //     style: TextStyle(
                        //       color: Colors.red[700],
                        //       fontSize: 16,
                        //     )),
                      ]),
                    ),
                    /*underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),*/
                    onChanged: (String? data) {
                      setState(() {
                        selectedTalukaF1 = data!;
                        LoadVillage();
                      });
                      print(selectedTalukaF1);
                    },
                    items:
                        taluka1.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Village",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ]),
                ),
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
                    left: 10.0, right: 10, top: 10, bottom: 0),
                child: DropdownButton<String>(
                  value: SelectedVillage,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Select Village",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      // TextSpan(
                      //     text: " * ",
                      //     style: TextStyle(
                      //       color: Colors.red[700],
                      //       fontSize: 16,
                      //     )),
                    ]),
                  ),
                  /*underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),*/
                  onChanged: (String? data) {
                    setState(() {
                      SelectedVillage = data!;
                    });
                    print(SelectedVillage);
                  },
                  items: Village.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    controller: block,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        ),
                        labelText: 'Block',
                        hintText: 'Enter Your Block'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
              /*Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
    
                child:
               child: TextField(
                  controller: District,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide( width: 2),
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(14.0)),
                      ),
                      labelText: 'District',
                      hintText: 'Enter Your District'),
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    controller: Pincode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                        ),
                        labelText: 'Pincode',
                        hintText: 'Enter Your Pincode',
                        errorText: _errorText),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text:
                            "Please add location site photographs now, you can't update it later.",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ]),
                ),
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
                    left: 10.0, right: 0, top: 10, bottom: 0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation1();
                        _showpickoptiondialogImg1(context);
                      });
                    },
                    label: const Text("Location site photograph 1"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image1) == null && latImage1 == "")
                        ? Colors.red
                        : Colors.green,
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
                    left: 10.0, right: 0, top: 10, bottom: 0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation2();
                        _showpickoptiondialogImg2(context);
                      });
                    },
                    label: const Text("Location site photograph 2"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image2) == null && latImage2 == "")
                        ? Colors.red
                        : Colors.green,
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
                    left: 10.0, right: 0, top: 10, bottom: 0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation3();
                        _showpickoptiondialogImg3(context);
                      });
                    },
                    label: const Text("Location site photograph 3"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image3) == null && latImage3 == "")
                        ? Colors.red
                        : Colors.green,
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
                    left: 10.0, right: 0, top: 10, bottom: 0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      setState(() {
                        getCurrentLocation4();
                        _showpickoptiondialogImg4(context);
                      });
                    },
                    label: const Text("Location site photograph 4"),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: ((_image4) == null && latImage4 == "")
                        ? Colors.red
                        : Colors.green,
                    size: 28.0,
                  ),
                ]),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          backgroundColor: HexColor("#0499f2"),
          onPressed: () async {
            if (Name.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Please add name ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (Address.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Please add Address ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if (survey_no.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Please add survay number ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else if ((_image1 == null) ||
                (latImage1.isEmpty) ||
                (longImage1.isEmpty) ||
                (_image2 == null) ||
                (latImage2.isEmpty) ||
                (longImage2.isEmpty) ||
                (_image3 == null) ||
                (latImage3.isEmpty) ||
                (longImage3.isEmpty) ||
                (_image4 == null) ||
                (latImage4.isEmpty) ||
                (longImage4.isEmpty)) {
              Fluttertoast.showToast(
                  msg: "Please take Location Images ",
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
                      transitionDuration: const Duration(milliseconds: 400),
                      transitionsBuilder:
                          (context, animation, animationTime, child) {
                        return ScaleTransition(
                          alignment: Alignment.topCenter,
                          scale: animation,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return Form2Page2(
                          sessionToken: sessionToken,
                          dropdownValue: dropdownValue1,
                          dropdownValue1: dropdownValue,
                          userName: userName,
                          userEmail: userEmail,
                          userId: userId,
                          Name: Name.text,
                          Address: Address.text,
                          survey_no: survey_no.text,
                          village: SelectedVillage,
                          Taluka: selectedTalukaF1,
                          block: block.text,
                          District: selectedDistrict,
                          Pincode: Pincode.text,
                          imageone: base64ImagePic1,
                          imagetwo: base64ImagePic2,
                          imagethree: base64ImagePic3,
                          imagefour: base64ImagePic4,
                          imagelatone: latImage1,
                          imagelattwo: latImage2,
                          imagelatthree: latImage3,
                          imagelatfour: latImage4,
                          imagelongone: longImage1,
                          imagelongtwo: longImage2,
                          imagelongthree: longImage3,
                          imagelongfour: longImage4,
                          Ownership: '', // Add the required Ownership argument
                        );
                      }));
              setState(() {});
            }
          },
          child: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
