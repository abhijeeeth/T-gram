import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/noc_Form1.dart';
import 'package:tigramnks/server/serverhelper.dart';

class NocForm extends StatefulWidget {
  String sessionToken;
  String userName;
  String userEmail;
  int userId;

  NocForm(
      {super.key,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userId});
  @override
  _NocFormState createState() =>
      _NocFormState(sessionToken, userName, userEmail, userId);
}

class _NocFormState extends State<NocForm> {
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  _NocFormState(this.sessionToken, this.userName, this.userEmail, this.userId);

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController Taluka = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController District = TextEditingController();
  TextEditingController Pincode = TextEditingController();

  String dropdownValue = '';
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

  String dropdownValue1 = '';
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
      //  ListDivision();
      LoadDistric();
    });
  }

  //------------------------------Taluka & Distric------------------------------
  String selectedTaluka = '';
  String selectedDistrict = '';
  //----------------------------District----------------------------------
  List<String> district = [];
  LoadDistric() async {
    int RL = 0;
    const String url = '${ServerHelper.baseUrl}auth/ListDistrict';
    var response = await http.get(Uri.parse(url), headers: <String, String>{
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
  List<String> taluka = [];
  LoadTaluka() async {
    // taluka.clear();
    int RL = 0;
    const String url = '${ServerHelper.baseUrl}auth/LoadTaluka';
    Map data = {
      "district": selectedDistrict,
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
        taluka.add(responseJson["data"][i]['taluka_name']);
      }
    });
  }

  //----------------------------------Village--------------------------------
  String SelectedVillage = '';
  List<String> Village = [];
  LoadVillage() async {
    int RL = 0;
    const String url = '${ServerHelper.baseUrl}auth/LoadVillage';
    Map data = {"taluka": selectedTaluka};
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
    const String url = '${ServerHelper.baseUrl}auth/ListRange';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
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

  String DD = '';
  List<String> Dname = [];

  int DL = 0;
  ListDivision() async {
    const String url = '${ServerHelper.baseUrl}auth/LoadDivision';
    Map data = {
      "range_area": dropdownValue,
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
      DL = responseJson["data"].length;
    });
    for (int i = 0; i < DL; i++) {
      Dname.add(responseJson["data"][i]['name']);
    }
    //   Dname.insert(0,responseJson["data"][0]['name']);
    //   if(Dname.length>2){
    //     Dname.removeLast();
    //   }
    // });
    print(Dname);
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = Pincode.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '';
    } else if (text.length < 6) {
      return 'Please input valid pincode';
    }
    // return null if the text is valid
    return '';
  }
//--------------------------------End DropDown Api Connection-------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NOC Form",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),

        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Division*",
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
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Range*",
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
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValue1 = data!;
                    });
                    print(dropdownValue1);
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
                  }).toList(),
                ),
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
                      labelText: 'Name *',
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
                    labelText: 'Address *',
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
                    labelText: 'Survey Number *',
                    hintText: 'Enter Survey Number'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Tree_Proposed_to_cut,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    labelText: 'Trees Proposed to be cut *',
                    hintText: 'Enter Number of Trees'),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
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
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select District *",
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
                  onChanged: (String? data) {
                    setState(() {
                      selectedDistrict = data!;
                      LoadTaluka();
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
                const Spacer(),
                DropdownButton<String>(
                  value: selectedTaluka,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Taluka *",
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
                  onChanged: (String? data) {
                    setState(() {
                      selectedTaluka = data!;
                      LoadVillage();
                    });
                    print(selectedTaluka);
                  },
                  items: taluka.map<DropdownMenuItem<String>>((String value) {
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
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: "Select Village *",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
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
                      labelText: 'Block *',
                      hintText: 'Enter Your Block'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  controller: Pincode,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      labelText: 'Pincode *',
                      hintText: 'Enter Your Pincode',
                      errorText: _errorText),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
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
          } else if (Tree_Proposed_to_cut.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please add Tree Proposed to cut ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          } else if (block.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please add Block ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          } else if (Pincode.text.length != 6) {
            Fluttertoast.showToast(
                msg: "Please add valid pincode ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          } else {
            // if ((dropdownValue == null) ||
            //     (dropdownValue1 == null) ||
            //     (Name.text.length == 0) ||
            //     (Address.text.length == 0) ||
            //     (survey_no.text.length == 0) ||
            //     (Tree_Proposed_to_cut.text.length == 0) ||
            //     (SelectedVillage == null) ||
            //     (selectedDistrict == null) ||
            //     (selectedTaluka == null)) {
            //   Fluttertoast.showToast(
            //       msg: "Please select and fill all Field",
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.CENTER,
            //       timeInSecForIosWeb: 1,
            //       backgroundColor: Colors.red,
            //       textColor: Colors.white,
            //       fontSize: 18.0);
            // } else {
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
                      return noc_Form1(
                        sessionToken: sessionToken,
                        dropdownValue: dropdownValue1,
                        dropdownValue1: dropdownValue,
                        userName: userName,
                        userEmail: userEmail,
                        userId: userId,
                        Name: Name.text,
                        Address: Address.text,
                        survey_no: survey_no.text,
                        Tree_Proposed_to_cut: Tree_Proposed_to_cut.text,
                        village: SelectedVillage,
                        Taluka: selectedTaluka,
                        block: block.text,
                        District: selectedDistrict,
                        Pincode: Pincode.text,
                      );
                    }));
            setState(() {});
          }
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
