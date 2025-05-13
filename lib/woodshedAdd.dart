import 'dart:convert';
import 'dart:core';
import 'dart:io' show File, HttpHeaders;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/tigramWoodShed.dart';

class woodshedAdd extends StatefulWidget {
  final int userId;
  final String sessionToken;
  final String userName;
  final String userEmail;

  const woodshedAdd({
    super.key,
    required this.userId,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
  });
  @override
  State<woodshedAdd> createState() =>
      _woodshedAddState(userId, sessionToken, userName, userEmail);
}

class _woodshedAddState extends State<woodshedAdd> {
  int userId;
  String sessionToken;
  String userName;
  String userEmail;
  _woodshedAddState(
      this.userId, this.sessionToken, this.userName, this.userEmail);

  String? dropdownValue2;
  String holder = '';
  List<String> specias = [
    "Rosewood (Dalbergia latifolia)",
    "Teak (Tectona grandis)",
    "Thempavu (Terminalia tomantosa)",
    "Chadachi (Grewia tiliaefolia)",
    "Chandana vempu(Cedrela toona)",
    "Vellakil (Dysoxylum malabaricum)",
    "Irul (Xylia xylocarpa)",
    "Ebony (Diospyrus sp.)",
    "Kampakam (Hopea Parviflora)"
  ];

  // Map<String, bool> List = {
  //   'Rosewood(Dalbergia latifolia)': false,
  //   'Teak(Tectona grandis) ': false,
  //   'Thempavu(Terminalia tomantosa)': false,
  //   'Chadachi(Grewia tiliaefolia)': false,
  //   'Chandana vempu(Cedrela toona)': false,
  //   'Vellakil(Dysoxylum malabaricum)': false,
  //   'Irul(Xylia xylocarpa)': false,
  //   'Ebony(Diospyrus sp.)': false,
  //   'Kampakam(Hopea Parviflora)': false,
  // };
  var holder_1 = [];
  bool isShow = false;
  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  // getItems() {
  //   List.forEach((key, value) {
  //     if (value == true) {
  //       holder_1.add(key);
  //     }
  //   });

  //   print(holder_1);
  // }

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController quntity = TextEditingController();
  TextEditingController timber_name_id = TextEditingController();
  String base64Image = 'empty';
  var _image;
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
        _image = File(pickedFile.path);

        base64Image = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  String? dropdownValue;
  String? selectedDistrict;
  String? DD;
  List<String> Rname = [];
  int RL = 0;
  List<String> Dname = [];

  List<String> district = [];
  LoadDistric() async {
    int RL = 0;

    String url = 'https://timber.forest.kerala.gov.in/api/auth/ListDistrict';

    //  Map<String, String> headers = {
    //  'Content-Type': 'application/json',
    //  'Authorization': 'token $sessionToken'
    //  };
    var response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'token $sessionToken',
        'Content-Type': 'application/json'
      },
    );
    print(response.body);
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

  @override
  void initState() {
    super.initState();
    setState(() {
      ListRange();
      //ListDivision();
      LoadDistric();
    });
  }

  ListRange() async {
    const String url = 'https://timber.forest.kerala.gov.in/api/auth/ListRange';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    print(response.body);
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print("-----------------------------Range-----------------------");
    print(responseJSON);
    setState(() {
      RL = responseJSON["data"].length;
    });
    for (int i = 0; i < RL; i++) {
      Rname.add(responseJSON["data"][i]['name']);
    }
    print(Rname);
  }

  void _showpickoptiondialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    InkWell(
                      onTap: () async {
                        await setfilepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: const Row(
                        children: [
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
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Add Timber",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        //backgroundColor: ColorLinearGradient(colors: [HexColor("#26f596"),HexColor("#0499f2")]),

        elevation: 0,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                child: RichText(
                  textAlign: TextAlign.right,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text:
                            "Division                                District",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ]),
                ),
              ),
            ]),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8, left: 15, right: 15),
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
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Division",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " * ",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 16,
                          )),
                    ]),
                  ),
                  /*underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),*/
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValue = data!;
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
                  value: selectedDistrict,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select District",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " * ",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 16,
                          )),
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
                    print(selectedDistrict);
                  },
                  items: district.map<DropdownMenuItem<String>>((String value) {
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
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                hint: const Text(" Select Species of tree :"),
                /*underline: Container(
                           height: 2,
                           color: Colors.grey,
                         ),*/
                onChanged: (String? data) {
                  setState(() {
                    dropdownValue2 = data!;
                  });
                },
                items: specias.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
                      labelText: 'Name',
                      hintText: 'Enter Your Name'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                  controller: Address,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Enter Your Address'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: phone,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  ),
                  labelText: 'Phone Number ',
                ),
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
                      _showpickoptiondialog(context);
                      //  takePhoto(ImageSource.gallery);
                    });
                  },
                  label: const Text("Timber image"),
                ),
                Icon(
                  Icons.check_circle,
                  color: (_image) == null ? Colors.red : Colors.green,
                  size: 28.0,
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: quntity,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    labelText: 'Quantity',
                    hintText: 'Enter Required Number of timber'),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Visibility(
              visible: isShow,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                strokeWidth: 8,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                onPressed: () async {
                  if ((Name.text.isEmpty) ||
                      (Address.text.isEmpty) ||
                      (phone.text.isEmpty) ||
                      (base64Image == null)) {
                    Fluttertoast.showToast(
                        msg: "Please select and fill all Field",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 4,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else {
                    setState(() {
                      isShow = true;
                    });
                    const String url =
                        'https://timber.forest.kerala.gov.in/api/auth/Add_Timber_Details';
                    Map data = {
                      "name": Name.text,
                      "division": dropdownValue.toString(),
                      "dist": selectedDistrict.toString(),
                      "quantity": quntity.text,
                      "address": Address.text,
                      "phone": phone.text,
                      "timber_name": dropdownValue2.toString(),
                      "by_user_id": userId,
                      "timber_image": {"type": ".png", "image": base64Image}
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
                    Map<String, dynamic> responseJson =
                        json.decode(response.body);
                    print("----------------From Submit-----------------------");
                    print(responseJson);
                    if (responseJson['message'] != "Data Saved Successfully.") {
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

                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 250),
                            transitionsBuilder:
                                (context, animation, animationTime, child) {
                              return ScaleTransition(
                                alignment: Alignment.topCenter,
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (context, animation, animationTime) {
                              return tigramWoodShed(
                                sessionToken: sessionToken,
                                userName: userName,
                                userEmail: userEmail,
                                userId: userId,
                                userCato: "user",
                              );
                            }));
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
