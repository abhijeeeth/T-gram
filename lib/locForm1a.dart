import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/locForm1b.dart';

class locForm1a extends StatefulWidget {
  String sessionToken;
  int userId;
  int id;

  String Type;
  String userName;
  String userEmail;

  String App_no;
  String Division;
  String Range;
  String District;
  String Taluk;
  String Village;
  String address;
  String survay;
  String treePCut;
  String blockL;
  String pin;
  String imageA;
  String imageB;
  String imageC;
  String imageD;
  String image1lat;
  String image2lat;
  String image3lat;
  String image4lat;
  String image1log;
  String image2log;
  String image3log;
  String image4log;
  String treespecies;
  String purposecut;
  String drivername;
  String vechclereg;
  String mode;
  String phone;
  String destAddress;
  String destState;
  String licenceImg;
  String ownerProof;
  String revenApplication;
  String revenApprove;
  String declaration;
  String locationSkch;
  String treeOwnership;
  String aadarcard;
  String signatureImg;
  String selectProof;
  String logData;

  locForm1a(
      {super.key,
      required this.sessionToken,
      required this.userId,
      required this.id,
      required this.Type,
      required this.userName,
      required this.userEmail,
      required this.App_no,
      required this.Division,
      required this.Range,
      required this.District,
      required this.Taluk,
      required this.Village,
      required this.address,
      required this.survay,
      required this.treePCut,
      required this.blockL,
      required this.pin,
      required this.imageA,
      required this.imageB,
      required this.imageC,
      required this.imageD,
      required this.image1lat,
      required this.image2lat,
      required this.image3lat,
      required this.image4lat,
      required this.image1log,
      required this.image2log,
      required this.image3log,
      required this.image4log,
      required this.treespecies,
      required this.purposecut,
      required this.drivername,
      required this.vechclereg,
      required this.mode,
      required this.phone,
      required this.destAddress,
      required this.destState,
      required this.licenceImg,
      required this.ownerProof,
      required this.revenApplication,
      required this.revenApprove,
      required this.declaration,
      required this.locationSkch,
      required this.treeOwnership,
      required this.aadarcard,
      required this.signatureImg,
      required this.selectProof,
      required this.logData});
  @override
  State<locForm1a> createState() => _locForm1aState(
      sessionToken,
      userId,
      id,
      Type,
      userName,
      userEmail,
      App_no,
      Division,
      Range,
      District,
      Taluk,
      Village,
      address,
      survay,
      treePCut,
      blockL,
      pin,
      imageA,
      imageB,
      imageC,
      imageD,
      image1lat,
      image2lat,
      image3lat,
      image4lat,
      image1log,
      image2log,
      image3log,
      image4log,
      treespecies,
      purposecut,
      drivername,
      vechclereg,
      mode,
      phone,
      destAddress,
      destState,
      licenceImg,
      ownerProof,
      revenApplication,
      revenApprove,
      declaration,
      locationSkch,
      treeOwnership,
      aadarcard,
      signatureImg,
      selectProof,
      logData);
}

class _locForm1aState extends State<locForm1a> {
  @override
  void initState() {
    super.initState();
    ListRange();
    LoadDistric();
    viewData();
  }

  void viewData() async {
    if (App_no != "") {
      Name.text = App_no.toString();
    }
    if (Division != "") {
      _selectedDiv = Division.toString();
      ListDivision();
    }
    if (Range != "") {
      _selectedRange = Range.toString();
    }
    if (District != "") {
      _selectedDistrict = District.toString();
      LoadTaluka();
    }
    if (Taluk != "") {
      _selectedTaluke = Taluk.toString();
      LoadVillage();
    }
    if (Village != "") {
      _selectedVillage = Village.toString();
    }
    if (address != "") {
      Address.text = address.toString();
    }
    if (treePCut != "") {
      Tree_Proposed_to_cut.text = treePCut.toString();
    }
    if (survay != "") {
      survey_no.text = survay.toString();
    }
    if (blockL != "") {
      block.text = blockL.toString();
    }
    if (pin != "") {
      Pincode.text = pin.toString();
    }
    if (imageA != "") {
      IMG1 = "fill";
    }
    if (imageB != "") {
      IMG2 = "fill";
    }
    if (imageC != "") {
      IMG3 = "fill";
    }
    if (imageD != "") {
      IMG4 = "fill";
    }
  }

  String sessionToken;
  int userId;
  int id;
  String Type;
  String userName;
  String userEmail;
  String App_no;
  String Division;
  String Range;
  String District;
  String Taluk;
  String Village;
  String address;
  String survay;
  String treePCut;
  String blockL;
  String pin;
  String imageA;
  String imageB;
  String imageC;
  String imageD;
  String image1lat;
  String image2lat;
  String image3lat;
  String image4lat;
  String image1log;
  String image2log;
  String image3log;
  String image4log;
  String treespecies;
  String purposecut;
  String drivername;
  String vechclereg;
  String mode;
  String phone;
  String destAddress;
  String destState;
  String licenceImg;
  String ownerProof;
  String revenApplication;
  String revenApprove;
  String declaration;
  String locationSkch;
  String treeOwnership;
  String aadarcard;
  String signatureImg;
  String selectProof;
  String logData;

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController villageC = TextEditingController();
  TextEditingController TalukC = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController DistrictC = TextEditingController();
  TextEditingController Pincode = TextEditingController();
  String IMG1 = '';
  String IMG2 = '';
  String IMG3 = '';
  String IMG4 = '';
  String _selectedDiv = '';
  String _selectedRange = '';
  String _selectedDistrict = '';
  String _selectedTaluke = '';
  String _selectedVillage = '';
  final List<String> _values = [];
  List<String> Dname = [];

  _locForm1aState(
      this.sessionToken,
      this.userId,
      this.id,
      this.Type,
      this.userName,
      this.userEmail,
      this.App_no,
      this.Division,
      this.Range,
      this.District,
      this.Taluk,
      this.Village,
      this.address,
      this.survay,
      this.treePCut,
      this.blockL,
      this.pin,
      this.imageA,
      this.imageB,
      this.imageC,
      this.imageD,
      this.image1lat,
      this.image2lat,
      this.image3lat,
      this.image4lat,
      this.image1log,
      this.image2log,
      this.image3log,
      this.image4log,
      this.treespecies,
      this.purposecut,
      this.drivername,
      this.vechclereg,
      this.mode,
      this.phone,
      this.destAddress,
      this.destState,
      this.licenceImg,
      this.ownerProof,
      this.revenApplication,
      this.revenApprove,
      this.declaration,
      this.locationSkch,
      this.treeOwnership,
      this.aadarcard,
      this.signatureImg,
      this.selectProof,
      this.logData);
  List<String> district = [];
  List<String> Rname = [];
  int RL = 0;
  void ListRange() async {
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

  ListDivision() async {
    int DL = 0;
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/LoadDivision';
    Map data = {
      "range_area": _selectedDiv ?? "",
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

    print(Dname);
  }

  LoadDistric() async {
    int RL = 0;

    String url = 'https://timber.forest.kerala.gov.in/api/auth/ListDistrict';

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

  List<String> taluka = [];
  LoadTaluka() async {
    int RL = 0;
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/LoadTaluka';

    Map data = {
      "district": _selectedDistrict ?? "",
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

  List<String> VillageL = [];
  LoadVillage() async {
    int RL = 0;
    const String url =
        'https://timber.forest.kerala.gov.in/api/auth/LoadVillage';
    Map data = {"taluka": _selectedTaluke ?? ""};
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
        VillageL.add(responseJson["data"][i]['village_name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Form 1"),
        elevation: 0,
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
                  value: _selectedDiv,
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
                      _selectedDiv = data!;
                      _selectedRange == null;
                      ListDivision();
                    });
                    print(_selectedDiv);
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
                  value: _selectedRange,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Range",
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
                      _selectedRange = data!;
                    });
                    print(_selectedRange);
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
                      labelText: 'Name',
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
                    labelText: 'Address',
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
                    labelText: 'Survey Number',
                    hintText: 'Enter Survey Number'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Visibility(
              visible: Type == "form1",
              child: Padding(
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
                      labelText: 'Trees Proposed to be cut',
                      hintText: 'Enter Number of Trees'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
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
                  value: _selectedDistrict,
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
                      _selectedDistrict = data!;
                      _selectedTaluke == null;
                      LoadTaluka();
                    });
                    print(_selectedDistrict);
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
                  value: _selectedTaluke,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  hint: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: "Select Taluka",
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
                      _selectedTaluke = data!;
                      _selectedVillage == null;
                      LoadVillage();
                    });
                    print(_selectedTaluke);
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
              margin: const EdgeInsets.only(top: 8, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 0),
              child: DropdownButton<String>(
                value: _selectedVillage,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                hint: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: "Select Village",
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
                onChanged: (String? data) {
                  setState(() {
                    _selectedVillage = data!;
                  });
                  print(_selectedVillage);
                },
                items: VillageL.map<DropdownMenuItem<String>>((String value) {
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      ),
                      labelText: 'Pincode',
                      hintText: 'Enter Your Pincode'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
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
                      // getCurrentLocation1();
                      // _showpickoptiondialogImg1(context);
                    });
                  },
                  label: const Text("Location site photograph 1"),
                ),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color: (IMG1) == null ? Colors.red : Colors.green,
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
                      // getCurrentLocation2();
                      // _showpickoptiondialogImg2(context);
                    });
                  },
                  label: const Text("Location site photograph 2"),
                ),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color: IMG2 == null ? Colors.red : Colors.green,
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
                      // getCurrentLocation3();
                      // _showpickoptiondialogImg3(context);
                    });
                  },
                  label: const Text("Location site photograph 3"),
                ),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color: (IMG3) == null ? Colors.red : Colors.green,
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
                      // getCurrentLocation4();
                      // _showpickoptiondialogImg4(context);
                    });
                  },
                  label: const Text("Location site photograph 4"),
                ),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color: (IMG4) == null ? Colors.red : Colors.green,
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
          // if ((dropdownValue == null)
          //     // (dropdownValue1 == null) ||
          //     // (Name.text.length == 0) ||
          //     // (Address.text.length == 0) ||
          //     // (survey_no.text.length == 0) ||
          //     // (Tree_Proposed_to_cut.text.length == 0) ||
          //     // (SelectedVillage == null) ||
          //     // (selectedDistrict == null) ||
          //     // (selectedTaluka == null) ||
          //     // (_image1 == null) ||
          //     // (latImage1.length == 0) ||
          //     // (longImage1.length == 0) ||
          //     // (_image2 == null) ||
          //     // (latImage2.length == 0) ||
          //     // (longImage2.length == 0) ||
          //     // (_image3 == null) ||
          //     // (latImage3.length == 0) ||
          //     // (longImage3.length == 0) ||
          //     // (_image4 == null) ||
          //     // (latImage4.isEmpty) ||
          //     // (longImage4.length == 0)
          //     ) {
          //   // if ((Name.text.length == 0) ||
          //   //     (Address.text.length == 0) ||
          //   //     (survey_no.text.length == 0)
          //   // // (Tree_Proposed_to_cut.text.length == 0)

          //   // ) {
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
                    print("LOGGGLOC$logData");
                    return locForm1b(
                        sessionToken: sessionToken,
                        userId: userId,
                        id: id,
                        Type: Type,
                        userName: userName,
                        userEmail: userEmail,
                        App_no: Name.text,
                        Division: _selectedDiv,
                        Range: _selectedRange,
                        District: _selectedDistrict,
                        Taluke: _selectedTaluke,
                        Village: _selectedVillage,
                        address: Address.text,
                        survay: survey_no.text,
                        treePCut: Tree_Proposed_to_cut.text,
                        blockL: block.text,
                        pin: Pincode.text,
                        imageA: imageA,
                        imageB: imageA,
                        imageC: imageC,
                        imageD: imageD,
                        image1lat: image1lat,
                        image2lat: image2lat,
                        image3lat: image3lat,
                        image4lat: image4lat,
                        image1log: image1log,
                        image2log: image2log,
                        image3log: image3log,
                        image4log: image4log,
                        treespecies: treespecies,
                        purposecut: purposecut,
                        drivername: drivername,
                        vechclereg: vechclereg,
                        mode: mode,
                        phone: phone,
                        destAddress: destAddress,
                        destState: destState,
                        licenceImg: licenceImg,
                        ownerProof: ownerProof,
                        revenApplication: revenApplication,
                        revenApprove: revenApprove,
                        declaration: declaration,
                        locationSkch: locationSkch,
                        treeOwnership: treeOwnership,
                        aadarcard: aadarcard,
                        signatureImg: signatureImg,
                        selectProof: selectProof,
                        logData: logData);
                  }));

          setState(() {});
          // print(sessionToken + dropdownValue1 + userName);
          // }
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
