import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io' as Io;

import 'package:tigramnks/homePage.dart';
import 'package:tigramnks/sqflite/DatabaseHelper.dart';
import 'package:tigramnks/sqflite/formModel.dart';

class Form2Page4 extends StatefulWidget {
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;
  String Ownership;
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
  String Application;
  String Approval;
  String Declaration;
  String Location;
  String TreeOwnership;
  String IdProof;
  List log_details;
  String selectedPRoof;
  Form2Page4(
      {this.sessionToken,
      this.dropdownValue,
      this.dropdownValue1,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name,
      this.Address,
      this.survey_no,
      this.village,
      this.Taluka,
      this.block,
      this.District,
      this.Pincode,
      this.Ownership,
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
      this.Application,
      this.Approval,
      this.Declaration,
      this.Location,
      this.TreeOwnership,
      this.IdProof,
      this.log_details,
      this.selectedPRoof});
  @override
  _Form2Page4State createState() => _Form2Page4State(
      sessionToken,
      dropdownValue,
      dropdownValue1,
      userName,
      userEmail,
      userId,
      Name,
      Address,
      survey_no,
      village,
      Taluka,
      block,
      District,
      Pincode,
      Ownership,
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
      Application,
      Approval,
      Declaration,
      Location,
      TreeOwnership,
      IdProof,
      log_details,
      selectedPRoof);
}

class _Form2Page4State extends State<Form2Page4> {
  final dbHelper = DatabaseHelper.instance;
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;
  String Ownership;
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
  String Application;
  String Approval;
  String Declaration;
  String Location;
  String TreeOwnership;
  String IdProof;
  List log_details;
  String selectedPRoof;
  var _imageLisence;
  String base64ImageLisence = '';
  var _imageSignature;
  String base64ImageSignature = '';

  // //
  // var _razorpay = Razorpay();
  // @override
  // void initState() {
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //   super.initState();
  // }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   print("Paymeny Success");
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   print("Paymeny Failure");
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  // }

  _Form2Page4State(
      this.sessionToken,
      this.dropdownValue,
      this.dropdownValue1,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name,
      this.Address,
      this.survey_no,
      this.village,
      this.Taluka,
      this.block,
      this.District,
      this.Pincode,
      this.Ownership,
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
      this.Application,
      this.Approval,
      this.Declaration,
      this.Location,
      this.TreeOwnership,
      this.IdProof,
      this.log_details,
      this.selectedPRoof);
  List logDataF;
  final picker = ImagePicker();
  String log;
  Future<void> setLisencepicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageLisence = File(pickedFile.path);

        base64ImageLisence = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setSignaturepicgallery() async {
    // print(Name+" "+Address+" "+survey_no+" "+Tree_Proposed_to_cut+" "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership);
    print('object');

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    print('object');
    if (pickedFile != null) {
      print('done ennakiyal');
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _imageSignature = File(pickedFile.path);

        base64ImageSignature = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  // File _License;
  // final ImagePicker _picker = ImagePicker();
  // void License(ImageSource source) async {
  //   print(Name+" "+Address+" "+survey_no+"  "+village+" "+Taluka+" "+block+" "+District+" "+Purpose+" "+holder_1.toString()+" "+Ownership+" "+Application+" "+Approval+" "+Declaration+" "+" "+Location+" "+TreeOwnership+" "+IdProof);
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   // final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _License = pickedFile as File;
  //     print("------------------------------Profile Image--------------");
  //     print(_License.path);
  //   });
  // }
  void _showpickoptiondialogSignature(BuildContext context) {
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
                        await setSignaturepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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

  int valk = 1;
  String keys = 'Id';

  void logupdate() {
    int index = 0;
    for (int i = 0; i < log_details.length; i++) {
      if (log_details[i]["species_of_tree"] ==
          "Rosewood (Dalbergia latifolia)") {
        dynamic value = 1;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Teak (Tectona grandis) ") {
        dynamic value = 2;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] ==
          "Thempavu (Terminalia tomantosa)") {
        dynamic value = 3;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] ==
          "Chadachi (Grewia tiliaefolia)") {
        dynamic value = 4;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] ==
          "Chandana vempu(Cedrela toona)") {
        dynamic value = 5;
        log_details[i][keys] = value;
      }

      if (log_details[i]["species_of_tree"] ==
          "Vellakil (Dysoxylum malabaricum)") {
        dynamic value = 6;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Irul (Xylia xylocarpa)") {
        dynamic value = 7;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Ebony (Diospyrus sp.)") {
        dynamic value = 8;
        log_details[i][keys] = value;
      }
      if (log_details[i]["species_of_tree"] == "Kampakam(Hopea Parviflora)") {
        dynamic value = 9;
        log_details[i][keys] = value;
      }
    }
    logDataF = log_details;
    print("LOOOGGGGGGG$logDataF");
  }

  void _showpickoptiondialogLisence(BuildContext context) {
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
                        await setLisencepicgallery();
                      },
                      splashColor: Colors.greenAccent,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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

  TextEditingController destination_add = TextEditingController();
  TextEditingController vehical_reg_no = TextEditingController();
  TextEditingController driver_name = TextEditingController();
  TextEditingController driver_phone = TextEditingController();
  TextEditingController mode_transport = TextEditingController();
  //--Code For radio button--
  int _radioValue = 0;
  String maintenance;
  int maintenance_cost;
  int estimatedMaintenanceCost;
  bool isEnabled;
  bool flag = false;
  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'YES';
        setState(() {
          flag = true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'NO';
        setState(() {
          flag = false;
        });
      }
    });
  }

  //--end radio button--
  //--------------------------------Image-Base64--------------------------------
  // String ImageLicence(){
  //   if(_imageLisence==null){
  //     return '';
  //   }else {
  //     final bytes = Io.File(_License.path).readAsBytesSync();
  //     String license_base = _License != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
  //     print('------------1--------------');
  //     print(license_base);
  //     return license_base;
  //   }
  // }
  String ImageLicence() {
    if (_imageLisence != null) {
      return base64ImageLisence;
    } else {
      return " ";
    }
  }

  String ImageOwnership() {
    final bytes = Io.File(Ownership).readAsBytesSync();
    String ownership_base =
        Ownership != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
    print('------------2--------------');
    print(ownership_base);
    return ownership_base;
  }

  String ImageRevenueApp() {
    final bytes1 = Io.File(Application).readAsBytesSync();
    String application_base = Application != null
        ? 'data:image/png;base64,' + base64Encode(bytes1)
        : '';
    print('------------3--------------');
    print(application_base);
    return application_base;
  }

  String ImageRevenueApproval() {
    final bytes2 = Io.File(Approval).readAsBytesSync();
    String approval_base =
        Approval != null ? 'data:image/png;base64,' + base64Encode(bytes2) : '';
    print('------------4--------------');
    print(approval_base);
    return approval_base;
  }

  String ImageDecleration() {
    final bytes5 = Io.File(Declaration).readAsBytesSync();
    String declaration_base = Declaration != null
        ? 'data:image/png;base64,' + base64Encode(bytes5)
        : '';
    print('------------5--------------');
    print(declaration_base);
    return declaration_base;
  }

  String ImageLocation() {
    final bytes4 = Io.File(Location).readAsBytesSync();
    String Location_base =
        Location != null ? 'data:image/png;base64,' + base64Encode(bytes4) : '';
    print('------------6--------------');
    print(Location_base);
    return Location_base;
  }

  String ImageTreeOwnership() {
    final bytes3 = Io.File(TreeOwnership).readAsBytesSync();
    String TreeOwnership_base = TreeOwnership != null
        ? 'data:image/png;base64,' + base64Encode(bytes3)
        : '';
    print('------------7--------------');
    print(TreeOwnership_base);
    return TreeOwnership_base;
  }

  String ImageAadhar() {
    final bytes6 = Io.File(IdProof).readAsBytesSync();
    String aadhar_base =
        IdProof != null ? 'data:image/png;base64,' + base64Encode(bytes6) : '';
    print('------------8--------------');
    print(aadhar_base);
    return aadhar_base;
  }
  // String ImageSignature(){
  //   final bytes7 = Io.File(_Signature.path).readAsBytesSync();
  //   String sign_base = _Signature.path != null ? 'data:image/png;base64,' + base64Encode(bytes7) : '';
  //   print('------------8--------------');
  //   print(sign_base);
  //   return sign_base;
  // }
  //--------------------------------End-Image-Base64----------------------------

  //-------------------------------Progress bar---------------------------------
  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 1));
    return true;
  }

  //------------------------------End-Progress-Bar------------------------------
  //----------------------------------Other-State-------------------------------
  String selectedState;
  List<String> State = [
    "Andhra Pradesh",
    "Andaman and Nicobar Islands",
    "Arunachal Pradesh",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadar and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu & Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttar Pradesh",
    "West Bengal"
  ];

  bool isShow = false;
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Do you want to go previous page'),
            content: new Text('Changes you made may not be saved.'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = driver_phone.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code

    if (text.length < 10) {
      return 'Please add valid number';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text("FORM - II"),
          gradient: LinearGradient(
              colors: [HexColor("#26f596"), HexColor("#0499f2")]),
          //backgroundColor: Colors.blueGrey,
          elevation: 0,
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10, bottom: 0),
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Destination State",
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
                    decoration: new BoxDecoration(
                        border: new Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 10, bottom: 0),
                    child: DropdownButton<String>(
                      value: selectedState,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      hint: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Select State",
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
                      onChanged: (String data) {
                        setState(() {
                          selectedState = data;
                        });

                        print(selectedState);
                      },
                      items:
                          State.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: destination_add,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(14.0)),
                        ),
                        labelText: 'Destination',
                        hintText: 'Destination Details',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 15),
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: new Text(
                              'Enter Vehicle Details',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                'Yes',
                                style: TextStyle(fontFamily: 'Lato'),
                              ),
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                'No',
                                style: TextStyle(fontFamily: 'Lato'),
                              ),
                              value: 2,
                              groupValue: _radioValue,
                              onChanged: _handleRadioValueChange,
                            ),
                          ),
                        ]),
                        LayoutBuilder(builder: (context, constraints) {
                          if (flag == true) {
                            return Container(
                                child: Column(children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 10, bottom: 0),
                                  child: TextField(
                                    controller: vehical_reg_no,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(14.0)),
                                      ),
                                      labelText: "Vehicle Registration Number",
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, top: 15, bottom: 0),
                                //padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: driver_name,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(14.0)),
                                    ),
                                    labelText: 'Name of the driver',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, top: 15, bottom: 0),
                                //padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: driver_phone,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(14.0)),
                                      ),
                                      labelText: 'Phone Number of the Driver',
                                      errorText: _errorText),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0,
                                    top: 15,
                                    bottom:
                                        0), //padding: EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: mode_transport,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(14.0)),
                                    ),
                                    labelText: 'Vehicle Used',
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.only(top: 15, right: 15),
                                decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(14)),
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 0, top: 10, bottom: 0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      TextButton.icon(
                                        icon: Icon(Icons.image),
                                        onPressed: () {
                                          setState(() {
                                            _showpickoptiondialogLisence(
                                                context);
                                          });
                                          // License(ImageSource.gallery);
                                        },
                                        label: Text("Driver License"),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.check_circle,
                                        color: (_imageLisence) == null
                                            ? Colors.red
                                            : Colors.green,
                                        size: 28.0,
                                      ),
                                    ]),
                              ),
                            ]));
                          } else if (flag == false) {
                            return Container(
                              color: Colors.white,
                            );
                          }
                        }),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15, right: 15),
                          decoration: new BoxDecoration(
                              border: new Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 0, top: 10, bottom: 0),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                TextButton.icon(
                                  icon: Icon(Icons.image),
                                  onPressed: () {
                                    setState(() {
                                      _showpickoptiondialogSignature(context);
                                    });
                                    // Signature(ImageSource.gallery);
                                    //   print(_Signature.path);
                                  },
                                  label: Text("Digital Signature"),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.check_circle,
                                  color: (_imageSignature) == null
                                      ? Colors.red
                                      : Colors.green,
                                  size: 28.0,
                                ),
                              ]),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                        //   child: Container(
                        //     child: CupertinoButton(
                        //       color: Colors.grey,
                        //       child: Text("Pay Amound"),
                        //       onPressed: () {},
                        //     ),
                        //   ),
                        // ),
                        Visibility(
                          visible: isShow,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
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
                            onPressed: () {
                              if (log_details.length != 0) {
                                logupdate();
                              }
                              String formtype = "form2";
                              String name = Name;
                              String selDivision = dropdownValue1;
                              String selRange = dropdownValue;
                              String selDistrict = District;
                              String selTaluk = Taluka;
                              String selVillage = village;
                              String survay = survey_no;
                              String address = Address;
                              String treePCut = "";
                              String blockL = block;
                              String pin = Pincode;
                              String locImageA = imageone;
                              String locImageB = imagetwo;
                              String locImageC = imagethree;
                              String locImageD = imagefour;
                              String image1_lat = imagelatone;
                              String image2_lat = imagelattwo;
                              String image3_lat = imagelatthree;
                              String image4_lat = imagelatfour;
                              String image1_log = imagelongone;
                              String image2_log = imagelongtwo;
                              String image3_log = imagelongthree;
                              String image4_log = imagelongfour;
                              String tree_species = holder_1.toString();
                              String purpose_cut = Purpose;
                              String driver_nameLoc = driver_name.text;
                              String vehicel_reg = vehical_reg_no.text;
                              String phone = driver_phone.text;
                              String mode = mode_transport.text;
                              String destination_address = destination_add.text;
                              String destination_state = selectedState;
                              String licenceImg = base64ImageLisence;
                              String ownership_proof_img = Ownership;
                              String revenue_application_img = Application;
                              String revenue_approval_img = Approval;
                              String declaration_img = Declaration;
                              String location_sketch_img = Location;
                              String tree_ownership_img = TreeOwnership;
                              String aadhar_card_img = IdProof;
                              String signature_img = base64ImageSignature;
                              String selectProof = selectedPRoof;
                              if (logDataF.length != 0) {
                                log = json.encode(logDataF);
                                print("LOOOGGG$log");
                              }
                              String logData = log;
                              isShow = true;
                              _insert(
                                  (formtype == null) ? "" : formtype,
                                  (name == null) ? "" : name,
                                  (selDivision == null) ? "" : selDivision,
                                  (selRange == null) ? "" : selRange,
                                  (selDistrict == null) ? "" : selDistrict,
                                  (selTaluk == null) ? "" : selTaluk,
                                  (selVillage == null) ? "" : selVillage,
                                  (survay == null) ? "" : survay,
                                  (address == null) ? "" : address,
                                  (treePCut == null) ? "" : treePCut,
                                  (blockL == null) ? "" : blockL,
                                  (pin == null) ? "" : pin,
                                  (locImageA == null) ? "" : locImageA,
                                  (locImageB == null) ? "" : locImageB,
                                  (locImageC == null) ? "" : locImageC,
                                  (locImageD == null) ? "" : locImageD,
                                  (image1_lat == null) ? "" : image1_lat,
                                  (image2_lat == null) ? "" : image2_lat,
                                  (image3_lat == null) ? "" : image3_lat,
                                  (image4_lat == null) ? "" : image4_lat,
                                  (image1_log == null) ? "" : image1_log,
                                  (image2_log == null) ? "" : image2_log,
                                  (image3_log == null) ? "" : image3_log,
                                  (image4_log == null) ? "" : image4_log,
                                  (tree_species == null) ? "" : tree_species,
                                  (purpose_cut == null) ? "" : purpose_cut,
                                  (driver_nameLoc == null)
                                      ? ""
                                      : driver_nameLoc,
                                  (vehicel_reg == null) ? "" : vehicel_reg,
                                  (phone == null) ? "" : phone,
                                  (mode == null) ? "" : mode,
                                  (destination_address == null)
                                      ? ""
                                      : destination_address,
                                  (destination_state == null)
                                      ? ""
                                      : destination_state,
                                  (licenceImg == null) ? "" : licenceImg,
                                  (ownership_proof_img == null)
                                      ? ""
                                      : ownership_proof_img,
                                  (revenue_application_img == null)
                                      ? ""
                                      : revenue_application_img,
                                  (revenue_approval_img == null)
                                      ? ""
                                      : revenue_approval_img,
                                  (declaration_img == null)
                                      ? ""
                                      : declaration_img,
                                  (location_sketch_img == null)
                                      ? ""
                                      : location_sketch_img,
                                  (tree_ownership_img == null)
                                      ? ""
                                      : tree_ownership_img,
                                  (aadhar_card_img == null)
                                      ? ""
                                      : aadhar_card_img,
                                  (signature_img == null) ? "" : signature_img,
                                  (selectProof == null) ? "" : selectProof,
                                  (logData == null) ? "" : logData);
                            },
                            child: Text('Insert Details'),
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
                              if ((Name.isEmpty) ||
                                  (dropdownValue1 == null) ||
                                  (Address.isEmpty) ||
                                  (base64ImageSignature == "") ||
                                  (survey_no.isEmpty) ||

                                  // (village.length == 0) ||
                                  (destination_add.text == "") ||
                                  (Ownership == "") ||
                                  (IdProof == "") ||
                                  (Application == "") ||
                                  (TreeOwnership == "")) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please select and fill all Field \n or You can save form for future submission",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if ((vehical_reg_no.text.isEmpty) ||
                                  (driver_name.text.isEmpty) ||
                                  (driver_phone.text.isEmpty) ||
                                  (mode_transport.text.isEmpty) ||
                                  (base64ImageLisence == "")) {
                                Fluttertoast.showToast(
                                    msg: "Please add all vechicle details ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                setState(() {
                                  isShow = true;
                                  if (log_details.length != 0) {
                                    logupdate();
                                  }
                                });
                                const String url =
                                    'http://13.234.208.246/api/auth/Formtwophaseone';
                                Map data = {
                                  "name": Name,
                                  "address": Address,
                                  "survey_no": survey_no,
                                  "tree_proposed": log_details.length,
                                  "village": village,
                                  "district": District,
                                  "area_range": dropdownValue,
                                  "division": dropdownValue1,
                                  "destination_address": destination_add.text,
                                  "destination_state": selectedState,
                                  "pincode": Pincode,
                                  "block": block,
                                  "taluka": Taluka,
                                  "licence_img": ImageLicence() == ""
                                      ? ""
                                      : {
                                          "type": ".png",

                                          // "image": ""
                                          "image": base64ImageLisence
                                        },
                                  "ownership_proof_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": Ownership
                                  },
                                  "revenue_application_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": Application
                                  },
                                  "revenue_approval_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": Approval
                                  },
                                  "declaration_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": Declaration
                                  },
                                  "location_sketch_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": Location
                                  },
                                  "tree_ownership_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": TreeOwnership
                                  },
                                  "aadhar_card_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": IdProof
                                  },
                                  "signature_img": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": base64ImageSignature
                                  },
                                  "location_img1": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imageone
                                  },
                                  "location_img2": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imagetwo
                                  },
                                  "location_img3": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imagethree
                                  },
                                  "location_img4": {
                                    "type": ".png",
                                    // "image": ""
                                    "image": imagefour
                                  },
                                  "image1_lat": "11.815342",
                                  "image1_log": "76.083107",
                                  "image2_lat": "11.815132",
                                  "image2_log": "76.083268",
                                  "image3_lat": "11.815363",
                                  "image3_log": "76.083943",
                                  "image4_lat": "11.815899",
                                  "image4_log": "76.083697",
                                  // "image1_lat": imagelatone,
                                  // "image2_lat": imagelattwo,
                                  // "image3_lat": imagelatthree,
                                  // "image4_lat": imagelatfour,
                                  // "image1_log": imagelongone,
                                  // "image2_log": imagelongtwo,
                                  // "image3_log": imagelongthree,
                                  // "image4_log": imagelongfour,

                                  "tree_species": holder_1.toString(),
                                  "purpose_cut": Purpose,
                                  "vehicle_detail": flag,
                                  "vehicel_reg": vehical_reg_no.text,
                                  "driver_name": driver_name.text,
                                  "phone": driver_phone.text,
                                  "mode": mode_transport.text,
                                  "trees_cutted": "2",
                                  "spec_details": logDataF ?? ""
                                  //[{"species_of_tree":"5","latitude":"10.846685","longitude":"76.271049"}]
                                  //[{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"},{"species":"test","length":"25","breadth":"650","latitude":"85.25","longitude":"8580.2"}]
                                };
                                // print(data);
                                var body = json.encode(data);
                                // print(body);
                                final response = await http.post(Uri.parse(url),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      'Authorization': "token $sessionToken"
                                    },
                                    body: body);
                                Map<String, dynamic> responseJson =
                                    json.decode(response.body);
                                print(
                                    "----------------From Submit-----------------------");
                                print(responseJson);

                                Fluttertoast.showToast(
                                    msg: responseJson['message'].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                                destination_add.clear();
                                setState(() {
                                  isShow = false;
                                });
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 250),
                                        transitionsBuilder: (context, animation,
                                            animationTime, child) {
                                          return ScaleTransition(
                                            alignment: Alignment.topCenter,
                                            scale: animation,
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return HomePage(
                                            sessionToken: sessionToken,
                                            userName: userName,
                                            userEmail: userEmail,
                                            userId: userId,
                                          );
                                        }));
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'Cairo',
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _razorpay.clear();
    super.dispose();
  }

  void _insert(
      formtype,
      name,
      selDivision,
      selRange,
      selDistrict,
      selTaluk,
      selVillage,
      survay,
      address,
      treePCut,
      block,
      pin,
      imageA,
      imageB,
      imageC,
      imageD,
      image1lat,
      image2lat,
      image3lat,
      image4lat,
      image1long,
      image2long,
      image3long,
      image4long,
      treespecies,
      purposecut,
      drivernameLoc,
      vehicelreg,
      phone,
      mode,
      destinationaddress,
      destinationstate,
      licenceImg,
      ownershipproofimg,
      revenueapplicationimg,
      revenueapprovalimg,
      declarationimg,
      locationsketchimg,
      treeownershipimg,
      aadharcardimg,
      signatureimg,
      selectProof,
      logData) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnFormtype: formtype,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnDivision: selDivision,
      DatabaseHelper.columnRange: selRange,
      DatabaseHelper.columnDistrict: selDistrict,
      DatabaseHelper.columnTaluke: selTaluk,
      DatabaseHelper.columnVillage: selVillage,
      DatabaseHelper.columnsurvay: survay,
      DatabaseHelper.columnaddress: address,
      DatabaseHelper.columntreePCut: treePCut,
      DatabaseHelper.columnblockL: block,
      DatabaseHelper.columnpin: pin,
      DatabaseHelper.columnlocImageA: imageA,
      DatabaseHelper.columnlocImageB: imageB,
      DatabaseHelper.columnlocImageC: imageC,
      DatabaseHelper.columnlocImageD: imageD,
      DatabaseHelper.columnimage1_lat: image1lat,
      DatabaseHelper.columnimage2_lat: image2lat,
      DatabaseHelper.columnimage3_lat: image3lat,
      DatabaseHelper.columnimage4_lat: image4lat,
      DatabaseHelper.columnimage1_long: image1long,
      DatabaseHelper.columnimage2_long: image2long,
      DatabaseHelper.columnimage3_long: image3long,
      DatabaseHelper.columnimage4_long: image4long,
      DatabaseHelper.columntree_species: treespecies,
      DatabaseHelper.columnpurpose_cut: purposecut,
      DatabaseHelper.columndriver_nameLoc: drivernameLoc,
      DatabaseHelper.columnvehicel_reg: vehicelreg,
      DatabaseHelper.columnphone: phone,
      DatabaseHelper.columnmode: mode,
      DatabaseHelper.columndestination_address: destinationaddress,
      DatabaseHelper.columndestination_state: destinationstate,
      DatabaseHelper.columnlicenceImg: licenceImg,
      DatabaseHelper.columnownership_proof_img: ownershipproofimg,
      DatabaseHelper.columnrevenue_application_img: revenueapplicationimg,
      DatabaseHelper.columnrevenue_approval_img: revenueapprovalimg,
      DatabaseHelper.columndeclaration_img: declarationimg,
      DatabaseHelper.columnlocation_sketch_img: locationsketchimg,
      DatabaseHelper.columntree_ownership_img: treeownershipimg,
      DatabaseHelper.columnaadhar_card_img: aadharcardimg,
      DatabaseHelper.columnsignature_img: signatureimg,
      DatabaseHelper.columnselectProof: selectProof,
      DatabaseHelper.columnlogData: logData,
    };

    Car car = Car.fromMap(row);
    final id = await dbHelper.insert(car);
    isShow = false;
    Fluttertoast.showToast(
        msg: "Data uploded locally",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0);

    await loginAction();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (context, animation, animationTime, child) {
              return ScaleTransition(
                alignment: Alignment.topCenter,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              return HomePage(
                sessionToken: sessionToken,
                userName: userName,
                userEmail: userEmail,
              );
            }));
  }
}
