// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  _signupState createState() => _signupState();
}

class Item {
  const Item(this.name);
  final String name;
}

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

  final Color primaryColor = Color.fromARGB(255, 28, 110, 99);
  final Color accentColor = Colors.amber;
  final double borderRadius = 12.0;

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Item? selectedUser;
  List<Item> users = <Item>[
    const Item('Aadhar Card'),
    const Item('Driving License'),
    const Item('Passport'),
    const Item('Government ID'),
    const Item('Voter ID'),
  ];

  final picker = ImagePicker();
  Future<void> setfilepicgallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String temp = base64Encode(await pickedFile.readAsBytes());

      setState(() {
        _image = File(pickedFile.path);
        base64Image = temp;
      });
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> setfilepiccam() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
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
                  ],
                ),
              ),
            ));
  }

  String? dropdownValue;
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
      sproof_holder = dropdownValue!;
      check = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 60, 20, 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/images/kerala_logo.jpg",
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Image.asset(
                        "assets/images/tigram01.png",
                        width: 90,
                        height: 60,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                children: [
                  buildTextField(
                    controller: Name,
                    label: "Full Name",
                    icon: Icons.person_outline,
                  ),
                  buildTextField(
                    controller: rEmail,
                    label: "Email Address",
                    icon: Icons.email_outlined,
                  ),
                  buildTextField(
                    controller: Mobile,
                    label: "Mobile Number",
                    icon: Icons.phone_outlined,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                  ),
                  buildTextField(
                    controller: Address,
                    label: "Address",
                    icon: Icons.location_on_outlined,
                    maxLines: 2,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: Colors.grey.shade50,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        hint: Text("Select ID Proof Type"),
                        items: s_proof.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                            check = value != null;
                          });
                        },
                      ),
                    ),
                  ),
                  if (check) ...[
                    buildTextField(
                      controller: Aadhar,
                      label: "ID Number",
                      icon: Icons.credit_card_outlined,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          foregroundColor: primaryColor,
                          side: BorderSide(color: primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                        ),
                        onPressed: () => _showpickoptiondialog(context),
                        icon: Icon(Icons.upload_outlined),
                        label: Text("Upload ID Proof"),
                      ),
                    ),
                  ],
                  buildTextField(
                    controller: Password,
                    label: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isHiddenPassword: isHiddenPassword,
                    onVisibilityToggle: () {
                      setState(() {
                        isHiddenPassword = !isHiddenPassword;
                      });
                    },
                  ),
                  buildTextField(
                    controller: rPassword,
                    label: "Confirm Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    isHiddenPassword: isHiddenPassword,
                    onVisibilityToggle: () {
                      setState(() {
                        isHiddenPassword = !isHiddenPassword;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      onPressed: () {
                        // Your existing registration logic
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  if (NewPage) buildOtpVerificationSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isHiddenPassword = true,
    VoidCallback? onVisibilityToggle,
    int? maxLength,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isHiddenPassword : false,
        maxLength: maxLength,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryColor),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget buildOtpVerificationSection() {
    return Container();
  }
}
