import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:file_picker/file_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' show File;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/login.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

//--DropDown-- code--
class Item {
  const Item(this.name);
  final String name;
}
//--End --DropDown code--

class _signupState extends State<signup> {
  bool isHiddenPassword = true;
  bool NewPage = false;
  bool flag = false;
  final _focusNode = FocusNode();
  final _focusNode2 = FocusNode();
  TextEditingController Name = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController rEmail = TextEditingController();
  TextEditingController Mobile = TextEditingController();
  TextEditingController Aadhar = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController rPassword = TextEditingController();
  String base64Image = 'empty';
  var _image;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  //--DropDown List ----

  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Aadhar Card'),
    const Item('Driving License'),
    const Item('Passport'),
    const Item('Government ID'),
    const Item('Voter ID'),
  ];

  //--End- DropDown List
//--device File fetching--

  Future<void> _IdPrrof() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
  }

  final picker = ImagePicker();
  Future<void> setfilepicgallery() async {
    print('object');

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

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

  Future<void> setfilepiccam() async {
    print('object');
    var camimage;

    final pickedFile = await picker.pickImage(source: ImageSource.camera);
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

  String dropdownValue;
  String sproof_holder = '';
  List<String> s_proof = [
    'Aadhar Card',
    'Driving License',
    'Passport',
    'Government ID',
    'Voter ID',
  ];
  bool check = false;
  void getDropDownItem() {
    setState(() {
      sproof_holder = dropdownValue;
      if (sproof_holder != null) {
        check = true;
      } else {
        check = false;
      }
    });
    print(sproof_holder);
  }

  //---------------------------Api-connection----------------//

  //-----------------------------end-Api-connection-----------//
  //--end-
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
            padding: const EdgeInsets.only(right: 15, top: 8),
            width: double.infinity,
            height: 80,
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/usaid_logo.png",
                  width: 130,
                  height: 75,
                ),
                Spacer(),
                Image.asset(
                  "assets/images/kerala_logo.jpg",
                  alignment: Alignment.center,
                  width: 80,
                  height: 80,
                ),
                Spacer(),
                Container(
                    child: Row(children: <Widget>[
                  Image.asset(
                    "assets/images/ministry_logo.jpg",
                  ),
                ]))
              ],
            )),
        Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            width: double.infinity,
            height: 65,
            color: HexColor("#02075D"),
            child: Row(
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                Image.asset(
                  "assets/images/tigram01.png",
                  width: 120,
                  height: 90,
                ),
              ],
            )),
        Container(
          /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),*/
          margin: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
          //padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                child: TextField(
                  controller: Name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12.0)),
                      ),
                      labelText: 'Name',
                      hintText: 'Enter Your Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: rEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12.0)),
                      ),
                      labelText: 'E-mail',
                      hintText: 'Enter Your E-mail'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  maxLength: 10,
                  controller: Mobile,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12.0)),
                      ),
                      labelText: 'Mobile No',
                      hintText: 'Enter Valid Mobile Number'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: Address,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12.0)),
                      ),
                      labelText: 'Address',
                      hintText: 'Enter Your Address'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButton<String>(
                  value: dropdownValue,
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
                  onChanged: (String data) {
                    setState(() {
                      dropdownValue = data;
                      if (dropdownValue == data) {
                        check = true;
                      } else {
                        check = false;
                      }
                    });
                    print(dropdownValue);
                  },
                  items: s_proof.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              LayoutBuilder(builder: (context, constraints) {
                if (check == true) {
                  return Container(
                      child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0, bottom: 10),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: Aadhar,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(12.0)),
                            ),
                            labelText: 'Id Number',
                            hintText: 'Enter Id Proof Number'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0, bottom: 10),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton.icon(
                              icon: Icon(Icons.image),
                              onPressed: () {
                                setState(() {
                                  setState(() {
                                    _showpickoptiondialog(context);
                                  });
                                  // takePhoto(ImageSource.gallery);
                                });
                              },
                              label: Text("Photo ID Proof"),
                            ),
                            Spacer(),
                            Icon(
                              Icons.check_circle,
                              color:
                                  (_image) == null ? Colors.red : Colors.green,
                              size: 28.0,
                            ),
                          ]),
                    ),
                  ]));
                } else if (check == false) {
                  return Container(
                    width: 0,
                    height: 0,
                    color: Colors.white,
                  );
                }
              }),
              /* Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: Aadhar,

                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Any ID Proof/ Gov. ID',
                    hintText: 'Enter valid Id Proof  Number'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left:15,top: 15.0,bottom: 0.0,right: 15),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey,width: 1,), borderRadius: BorderRadius.circular(5)
              ),
              child: Row(children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(left:10, top: 5.0,bottom: 5.0),
                    child: RaisedButton(
                      color: Colors.grey[400],
                      onPressed: _IdPrrof,
                      child: Text(
                        'Choose file',
                        style: TextStyle(color:Colors.white, fontSize: 14),
                      ),
                    )
                ),
              ]
              ),
            ),*/

              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: Password,
                  obscureText: isHiddenPassword,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: Icon(Icons.visibility, color: Colors.black54)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12.0)),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: rPassword,
                  obscureText: isHiddenPassword,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              print("hi...");
                              isHiddenPassword = !isHiddenPassword;
                            });
                          },
                          child: Icon(Icons.visibility, color: Colors.black54)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(12.0)),
                      ),
                      labelText: 'Re-Password',
                      hintText: 'Repeat Password'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(12)),
                child: TextButton(
                  onPressed: () async {
                    if ((Name.text.length == 0) ||
                        (rEmail.text.length == 0) ||
                        (Mobile.text.length == 0) ||
                        (Aadhar.text.length == 0) ||
                        (Address.text.length == 0) ||
                        (Password.text.length == 0) ||
                        (rPassword.text.length == 0)) {
                      Fluttertoast.showToast(
                          msg: "please fill all fields",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (!validateEmail(rEmail.text)) {
                      Fluttertoast.showToast(
                          msg: "Invalid email address",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (Mobile.text.length != 10) {
                      Fluttertoast.showToast(
                          msg: "Mobile No is Invalid",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } /*else if(Aadhar.text.length !=12){
                    Fluttertoast.showToast(
                        msg:
                        "Invalid Aadhar Number",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                   }*/
                    else if (Address.text.length > 200) {
                      Fluttertoast.showToast(
                          msg: "Address must be less then 200 charcter",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (Password.text != rPassword.text) {
                      Fluttertoast.showToast(
                          msg:
                              "Password Mismatch or size must be greater then 8",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (Password.text.length < 8) {
                      Fluttertoast.showToast(
                          msg:
                              "Password Mismatch or size must be greater then 8",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      const String url =
                          'http://13.234.208.246/api/auth/NewRegisterAPI';
                      // final bytes6 = File(_imageFile.path).readAsBytesSync();
                      // String aadhar_base= _imageFile != null ? 'data:image/png;base64,' + base64Encode(bytes6) : '';
                      print(base64Image);
                      Map data = {
                        "name": Name.text,
                        "phone": Mobile.text,
                        "email": rEmail.text.trim(),
                        "password": Password.text,
                        "address": Address.text,
                        "photo_proof_name": sproof_holder,
                        "photo_proof_no": Aadhar.text,
                        "photo_proof_img": {
                          "mime": "image/jpeg",
                          "data": base64Image,
                        }
                      };
                      print(data);
                      var body = json.encode(data);
                      print(body);
                      final response = await http.post(Uri.parse(url),
                          headers: <String, String>{
                            'Content-Type': 'application/json'
                          },
                          body: body);
                      print(response);
                      Map<String, dynamic> responseJson =
                          json.decode(response.body);
                      print("----------------------Register----------------");
                      print(responseJson);
                      if (responseJson['status'] == "Success") {
                        // Fluttertoast.showToast(
                        //     msg: responseJson['Message'],
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.green,
                        //     textColor: Colors.white,
                        //     fontSize: 18.0);
                        const String url1 =
                            'http://13.234.208.246/api/auth/register_otp_verification';
                        Map data1 = {
                          "phone": Mobile.text,
                        };
                        print(data1);
                        var body1 = json.encode(data);
                        print(body1);
                        NewPage = true;
                        final response1 = await http.post(Uri.parse(url1),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: body1);
                        print(response1);
                        Map<String, dynamic> responseJson =
                            json.decode(response.body);
                        print("----------------------OTP-GEN---------------");
                        print(responseJson);

                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) => login()));
                      } else {
                        Fluttertoast.showToast(
                            msg: responseJson['Message'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);

                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) => signup()));
                      }
                    }
                    _focusNode2.requestFocus();
                  },
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: NewPage,
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '------Verify OTP-------',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'OTP Send on Email OR Mobile Number: ' + Mobile.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: otp,
                        focusNode: _focusNode2,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Icon(Icons.check_circle,
                                  color: (flag) == false
                                      ? Colors.red
                                      : Colors.green),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            prefixIcon: Icon(Icons.mobile_friendly_outlined),
                            labelText: 'OTP',
                            hintText: 'Enter OTP'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          // color: Colors.amber,
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (otp.text.length == 0) {
                              Fluttertoast.showToast(
                                  msg: 'Please Enter OTP',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 4,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            } else {
                              const String url =
                                  'http://13.234.208.246/api/auth/register_Otp_verify';
                              Map data = {
                                "phone": Mobile.text,
                                "otp": otp.text,
                              };
                              print(data);
                              var body = json.encode(data);
                              print(body);
                              final response = await http.post(Uri.parse(url),
                                  headers: <String, String>{
                                    'Content-Type': 'application/json'
                                  },
                                  body: body);
                              print(response);
                              Map<String, dynamic> responseJson =
                                  json.decode(response.body);
                              print(
                                  "----------------------Register----------------");
                              print(responseJson);
                              if (responseJson['status'] == 'success') {
                                setState(() {
                                  // userId = responseJson['data']['id'];
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()),
                                );
                                // print(userId);
                                Fluttertoast.showToast(
                                    msg: responseJson['message'].toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: responseJson['message'].toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              }
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 40, bottom: 40),
                    ),
                  ],
                )),
              )
            ],
          ),
        )
      ])),
    );
  }
}
