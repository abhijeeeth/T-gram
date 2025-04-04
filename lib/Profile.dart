//import 'dart:html';
import 'dart:convert';
import 'dart:io' show File;
import 'dart:io' as Io;
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tigramnks/homePage.dart';

class Profile extends StatefulWidget {
  String sessionToken;
  String userName;
  String userProfile;
  String userEmail;
  String userMobile;
  String userAddress;
  Profile({
    super.key,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
    required this.userMobile,
    required this.userAddress,
    required this.userProfile,
  });
  @override
  _ProfileState createState() => _ProfileState(
      sessionToken, userName, userEmail, userMobile, userAddress, userProfile);
}

class _ProfileState extends State<Profile> {
  String sessionToken;
  String userName;
  String userProfile;
  String userEmail;
  String userMobile;
  String userAddress;
  _ProfileState(this.sessionToken, this.userName, this.userEmail,
      this.userMobile, this.userAddress, this.userProfile);
  bool flag = true;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  String base64Image = 'empty';
  var IMGG;
  var _image;
  setimage() {
    setState(() {
      base64Image = widget.userProfile;
    });
  }

  @override
  void initState() {
    super.initState();
    viewProfile();
    // setimage();
  }

  String Vphone = '';
  String Vemail = '';
  String Vname = '';
  String Vaddress = '';
  String pic_url = '';

  // File _imgProfile;
  // final ImagePicker _picker = ImagePicker();
  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(
  //     source: source,
  //   );
  //   //final bytes = Io.File(_imageFile.path).readAsBytesSync();
  //   setState(() {
  //     _imgProfile = (pickedFile as File!=null ? _imgProfile.path : null) as File ;
  //     print("------------------------------Profile Image--------------");
  //     print(_imgProfile.path);
  //   });
  // }
  viewProfile() async {
    const String url = 'http://192.168.54.114:8000/api/auth/ViewProfile';
    print(sessionToken);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token $sessionToken"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    print(responseJSON);
    setState(() {
      Vphone = responseJSON['user']['phone'];
      Vemail = responseJSON['user']['email'];
      Vname = responseJSON['user']['name'];
      Vaddress = responseJSON['user']['address'];
      pic_url = responseJSON['user']['pic_url'];
    });
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
        IMGG = base64Image;
        print(IMGG);
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

  Future<bool> _onBackPressed() {
    Navigator.pop(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                sessionToken: sessionToken,
                userId: 0,
                userName: userName,
                userEmail: userEmail,
                userMobile: userMobile,
                userAddress: userAddress,
                userProfile: userProfile,
                userGroup: '',
                userCato: '',
              )),
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile "),

          actions: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: LayoutBuilder(builder: (context, constraints) {
                if (flag == true) {
                  return IconButton(
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          flag = false;
                        });
                      });
                } else if (flag == false) {
                  return IconButton(
                      icon: const Icon(
                        Icons.save_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        // final bytes = Io.File(_imgProfile.path).readAsBytesSync();
                        // String profile_base= _imgProfile.path != null ? 'data:image/png;base64,' + base64Encode(bytes) : '';
                        print(base64Image);
                        const String url =
                            'http://192.168.54.114:8000/api/auth/EditProfile';

                        Map data = {
                          "name": name.text,
                          "contact": phone.text,
                          "address": address.text,
                        };
                        Vname = name.text.toString();
                        Vphone = phone.text.toString();
                        Vaddress = address.text.toString();

                        print(data);
                        var body = json.encode(data);
                        print(body);
                        final response = await http.post(Uri.parse(url),
                            headers: {
                              'Content-Type': 'application/json',
                              'Authorization': "token $sessionToken"
                            },
                            body: body);
                        print(response);
                        Map<String, dynamic> responseJson =
                            json.decode(response.body);
                        print(
                            "----------------------Update Profile----------------");
                        print(responseJson);
                        Fluttertoast.showToast(
                            msg: responseJson['message'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0);
                        setState(() {
                          flag = true;
                          name.text = Vname;
                          phone.text = Vphone;
                          address.text = Vaddress;
                        });
                      });
                }
                return Container(); // Add this line
              }),
            )
          ],
          // backgroundColor: Colors.blueGrey,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: Colors.lightGreenAccent, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                padding: const EdgeInsets.all(8),
                child: LayoutBuilder(builder: (context, constraints) {
                  if (flag == true) {
                    return Column(
                      children: <Widget>[
                        Stack(alignment: Alignment.center, children: <Widget>[
                          Image(
                            height: MediaQuery.of(context).size.height / 4,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: const NetworkImage(
                                "https://images.pexels.com/photos/311458/pexels-photo-311458.jpeg?cs=srgb&dl=pexels-scott-webb-311458.jpg&fm=jpg"),
                          ),
                          //   Positioned(
                          //     child: CircleAvatar(
                          //       backgroundImage: NetworkImage(
                          //         pic_url,
                          //       ),
                          //       radius: 50.0,
                          //     ),
                          //   ),
                        ]),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.perm_identity_rounded),
                            title: Text(
                              Vname,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.email_outlined),
                            title: Text(
                              Vemail,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.phone),
                            title: Text(
                              Vphone,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.home_outlined),
                            title: Text(
                              Vaddress,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (flag == false) {
                    name.text = Vname;
                    phone.text = Vphone;
                    address.text = Vaddress;
                    return Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image(
                              height: MediaQuery.of(context).size.height / 4,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: const NetworkImage(
                                  "https://images.pexels.com/photos/311458/pexels-photo-311458.jpeg?cs=srgb&dl=pexels-scott-webb-311458.jpg&fm=jpg"),
                            ),
                            // Positioned(
                            //   child: CircleAvatar(
                            //     backgroundImage: _image == null
                            //         ? NetworkImage('$pic_url')
                            //         : FileImage(File(base64Image)),
                            //     radius: 50.0,
                            //   ),
                            // ),
                            // Positioned(
                            //     child: InkWell(
                            //   onTap: () {
                            //     setState(() {
                            //       setState(() {
                            //         _showpickoptiondialog(context);
                            //       });

                            //       // takePhoto(ImageSource.gallery);
                            //     });
                            //   },
                            //   child: Icon(Icons.camera_alt,
                            //       color:
                            //           (_image) == null ? Colors.red : Colors.green,
                            //       size: 25.0),
                            // )),
                          ],
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.perm_identity_rounded),
                            title: TextField(
                              controller: name,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: userName),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.email_outlined),
                            title: Text(
                              userEmail,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.phone),
                            title: TextField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: userMobile),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.home_outlined),
                            title: TextField(
                              controller: address,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: userAddress.toString()),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container(); // Add this line
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
