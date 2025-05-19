import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:marquee/marquee.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigramnks/DivisionDashboard.dart';
import 'package:tigramnks/FieldOfficerDashboard.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:tigramnks/SFDashboard.dart';
import 'package:tigramnks/forgetPassword.dart';
import 'package:tigramnks/homePage.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/signup.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'checkPostDash.dart';

void main() {
  runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  bool isHiddenPassword = true;

  TextEditingController loginMobile = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  int _radioValue = 0;
  String? maintenance;
  int? maintenance_cost;
  int? estimatedMaintenanceCost;

  bool flag = true;
  bool? _jailbroken;
  bool? _developerMode;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _requestStoragePermission();
  }

  // Request storage permission
  Future<void> _requestStoragePermission() async {
    PermissionStatus status;

    // For Android 13 and above (SDK 33+), we need to request specific permissions
    if (await Permission.storage.isRestricted ||
        await Permission.storage.isDenied) {
      status = await Permission.storage.request();

      if (status.isGranted) {
        // await Permission.storage.request();
        Fluttertoast.showToast(
          msg: 'Storage permission granted',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (status.isDenied) {
        await Permission.storage.request();
        Fluttertoast.showToast(
          msg:
              'Storage permission denied. Some features may not work properly.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else if (status.isPermanentlyDenied) {
        Fluttertoast.showToast(
          msg:
              'Storage permission permanently denied. Please enable it from app settings.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        // You could open app settings here
        await openAppSettings();
      }
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool jailbroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final jailbreakRootDetection = JailbreakRootDetection();
      jailbroken = await jailbreakRootDetection.isJailBroken;
    } on PlatformException {
      jailbroken = true;
      developerMode = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
    });
  }

  @override
  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value ?? 0;
      if (_radioValue == 0) {
        maintenance = 'Yes';
        setState(() {
          flag = true;
        });
      } else if (_radioValue == 1) {
        maintenance = 'No';
        setState(() {
          flag = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.green[100],
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(right: 15, top: 8),
                  width: double.infinity,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Add this
                    children: <Widget>[
                      Image.asset(
                        "assets/images/kerala_logo.jpg",
                        width: 80,
                        height: 80,
                      ),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: 65,
                  color: HexColor("#02075D"),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/tigram01.png",
                        width: 120,
                        height: 90,
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 15),
                child: ToggleSwitch(
                  minWidth: double.infinity,
                  minHeight: 50,
                  initialLabelIndex: _radioValue,
                  cornerRadius: 8.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[200],
                  inactiveFgColor: Colors.black54,
                  labels: const ['User', 'Officer'],
                  fontSize: 16,
                  activeBgColors: const [
                    [Color(0xFF02075D)],
                    [Color(0xFF02075D)]
                    //blinh
                  ],
                  onToggle: _handleRadioValueChange,
                ),
              ),
              LayoutBuilder(builder: (context, constraints) {
                if (flag == true) {
                  return const UserLogin();
                } else if (flag == false) {
                  return const OfficerLogin();
                }
                return Container(); // Default return for type safety
              }),
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            final packageInfo = snapshot.data!;
                            return Center(
                              child: Text(
                                "Version: ${packageInfo.version}+${packageInfo.buildNumber}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 63, 63, 63),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                "Error loading version",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }
                        }
                        // Show loading indicator while waiting
                        return const Center(
                          child: Text(
                            "Loading version...",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 25,
                color: HexColor("#004d40"),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10),
                child: Marquee(
                  text: "Kerala Forest Research Institute (KFRI)",
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ));
  }
}

//-------------------------------User-Login-------------------------------------

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserLogin> {
  bool isHiddenPassword = true;
  String sessionToken = '';
  int? userId;
  String userName = '';
  String userEmail = '';
  String userMobile = '';
  String userAddress = '';
  String userProfile = '';
  String userGroup = '';
  String userCato = '';

  TextEditingController loginMobile = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validateMobile(String value) {
    if (value.length != 10)
      return false;
    else
      return true;
  }

  //-------------------------------------Shared-Preferences---------------------
  SharedPreferences? prefs;
  bool? newuser;

  get dropdownValue => null;

  void getLogin() async {
    List userRange;
    List<String> URange = [];
    List distRange = [];
    List<String> Dist = [];
    List Range = [];
    prefs = await SharedPreferences.getInstance();
    setState(() {
      newuser = (prefs?.getBool('isLoggedIn') ?? true);
    });
    if (newuser == false) {
      const String url = '${ServerHelper.baseUrl}auth/NewLogin';
      Map data = {
        "email_or_phone": (prefs?.getString('LoginUser') ?? '').trim(),
        "password": (prefs?.getString('LoginPass') ?? '').trim(),
      };

      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == "success") {
        setState(() {
          userId = responseJson['data']['id'];

          userName = responseJson['data']['name'];
          userEmail = responseJson["data"]["email"];
          sessionToken = responseJson['token'];
          userGroup = responseJson['data']['user_group'][0];
          userMobile = responseJson["data"]["phone"];
          userAddress = responseJson["data"]["address"];
          userCato = responseJson["data"]["usr_category"];
          userProfile = responseJson["data"]["photo_proof_img"];
        });
        if (responseJson['data']['user_group'][0] == 'user') {
          Fluttertoast.showToast(
              msg: 'Welcome $userName',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return HomePage(
                      userId: userId!,
                      userName: userName,
                      userEmail: userEmail,
                      userMobile: userMobile,
                      userAddress: userAddress,
                      userProfile: userProfile,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      userCato: userCato,
                    );
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'division officer') {
          setState(() {
            userRange = responseJson['data']['range'];
            URange = List<String>.from(userRange);
          });
          Fluttertoast.showToast(
              msg: 'Welcome $userName',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return DivisonDashBoard(
                      userId: userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      // dropdownValue: dropdownValue,
                      userRange: URange,
                    );
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'state officer') {
          setState(() {
            distRange = responseJson['data']['division_range_list'];

            for (int i = 0; i < distRange.length; i++) {
              Dist.add(
                  responseJson['data']['division_range_list'][i]['division']);
              Range.add(
                  responseJson['data']['division_range_list'][i]['ranges']);
              // URange=List<String>.from(Range);
              for (int j = 0; j < Range[i].length; j++) {
                URange.add(Range[i][j].toString());
              }
            }
            //D_Range=List<String>.from(Dist_Range);
          });
          Fluttertoast.showToast(
              msg: 'Welcome $userName',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return SFDashboard(
                      Dist_Range: distRange ?? [],
                      userId: userId!,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      dropdownValue: dropdownValue,
                      userMobile: userMobile,
                      userProfile: userProfile,
                      userAddress: userAddress,
                      Dist: Dist,
                      Range: URange,
                    );
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'field officer') {
          Fluttertoast.showToast(
              msg: 'Welcome $userName',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return FieldOfficerDashboard(
                        userId: userId!,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        dropdownValue: 'Field Officer',
                        userMobile: userMobile,
                        userProfile: userProfile,
                        userAddress: userAddress);
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'checkpost officer') {
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return checkPost(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup);
                  }));
        } else {
          if (userGroup == 'forest range officer') {
            Range = responseJson['data']['range'];
          }
          Fluttertoast.showToast(
              msg: 'Welcome $userName',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return OfficerDashboard(
                      userId: userId!,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      dropdownValue: dropdownValue ?? '',
                      Range: Range,
                      userMobile: userMobile,
                      userAddress: userAddress,
                    );
                  }));
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const login()),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
    // toHome();
  }

  //-----------------------------------End-Shared-Preferences-------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.red[600]!, width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(73, 0, 0, 0),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 30),
        child: Column(children: <Widget>[
          TextField(
              controller: loginEmail,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Enter E-mail/Mobile',
                  labelText: "E-mail/Mobile",
                  hintStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                  ))),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: loginPassword,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.vpn_key_outlined),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isHiddenPassword = !isHiddenPassword;
                    });
                  },
                  child: const Icon(
                    Icons.visibility,
                  ),
                ),
                hintText: 'Enter Password',
                labelText: "Password",
                hintStyle: const TextStyle(
                  fontFamily: 'Cairo',
                  fontStyle: FontStyle.normal,
                )),
            obscureText: isHiddenPassword,
            // obscuringCharacter: '*',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const forgetPassword()));
                  },
                  child: Text(
                    'Forget Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontStyle: FontStyle.normal,
                      color: Colors.blue[700],
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                      // color: Colors.amber,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () async {
                        if ((loginEmail.text.isEmpty) ||
                            (loginPassword.text.isEmpty)) {
                          Fluttertoast.showToast(
                              msg:
                                  "Either User Name or password field is empty",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        } else {
                          print("----login----");
                          const String url =
                              '${ServerHelper.baseUrl}auth/NewLogin';
                          Map data = {
                            "email_or_phone": loginEmail.text.trim(),
                            "password": loginPassword.text.trim()
                          };

                          var body = json.encode(data);

                          final response = await http.post(Uri.parse(url),
                              headers: <String, String>{
                                'Content-Type': 'application/json'
                              },
                              body: body);

                          Map<String, dynamic> responseJson =
                              json.decode(response.body);
                          print("----------------------login----------------");

                          if (responseJson['status'] == "success") {
                            setState(() {
                              userId = responseJson['data']['id'];

                              userName = responseJson['data']['name'];
                              userEmail = responseJson["data"]["email"];
                              userMobile = responseJson["data"]["phone"];
                              userAddress = responseJson["data"]["address"];
                              sessionToken = responseJson["token"];
                              userProfile =
                                  responseJson["data"]["photo_proof_img"];
                              userGroup = responseJson['data']['user_group'][0];
                              userCato = responseJson['data']['usr_category'];
                            });
                            if (responseJson['data']['user_group'][0] ==
                                'user') {
                              prefs?.setString('LoginUser', loginEmail.text);
                              prefs?.setString('LoginPass', loginPassword.text);
                              prefs?.setBool('isLoggedIn', false);
                              Fluttertoast.showToast(
                                  msg: 'Login Sucessfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 250),
                                      transitionsBuilder: (context, animation,
                                          animationTime, child) {
                                        return ScaleTransition(
                                          alignment: Alignment.topCenter,
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      pageBuilder:
                                          (context, animation, animationTime) {
                                        return HomePage(
                                          userId: userId!,
                                          userName: userName,
                                          userEmail: userEmail,
                                          userMobile: userMobile,
                                          userAddress: userAddress,
                                          userProfile: userProfile,
                                          sessionToken: sessionToken,
                                          userGroup: userGroup,
                                          userCato: userCato,
                                        );
                                      }));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const login()));
                              Fluttertoast.showToast(
                                  msg: 'Go to Officer Login',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              loginEmail.clear();
                              loginPassword.clear();
                            }
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const login()));
                            Fluttertoast.showToast(
                                msg: 'Invalid credentials',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }
                        }
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const signup()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //  TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (_) => const signup()));
          //     },
          //     child: RichText(
          //       textAlign: TextAlign.center,
          //       text: TextSpan(children: <TextSpan>[
          //         const TextSpan(
          //             text: "New User ? ",
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontFamily: 'Cairo',
          //             )),
          //         TextSpan(
          //             text: "Sign Up",
          //             style: TextStyle(
          //                 color: Colors.blue[700],
          //                 fontFamily: 'Cairo',
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold)),
          //       ]),
          //     )),
        ]));
  }
}
//-------------------------------End--UserLogin---------------------------------

//-----------------------Officer--Login-----------------------------------------

class OfficerLogin extends StatefulWidget {
  const OfficerLogin({super.key});

  @override
  _OfficerState createState() => _OfficerState();
}

class _OfficerState extends State<OfficerLogin> {
  //-------------------------------------Shared-Preferences---------------------
  SharedPreferences? prefs;
  bool? newuser;

  void getLogin() async {
    List userRange;
    List<String> URange = [];
    List distRange = [];
    List<String> Dist = [];
    List Range = [];
    prefs = await SharedPreferences.getInstance();
    setState(() {
      newuser = (prefs?.getBool('isLoggedIn') ?? true);
    });
    if (newuser == false) {
      const String url = 'http://www.gisfy.co.in:86/app/auth/NewLogin';
      Map data = {
        "email_or_phone": prefs?.getString('LoginUser') ?? '',
        "password": prefs?.getString('LoginPass') ?? '',
      };

      var body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: body);

      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['status'] == "success") {
        setState(() {
          userId = responseJson['data']['id'];

          userName = responseJson['data']['name'];
          userEmail = responseJson["data"]["email"];
          sessionToken = responseJson['token'];
          userGroup = responseJson['data']['user_group'][0];
          userMobile = responseJson["data"]["phone"];
          userAddress = responseJson["data"]["address"];
          userProfile = responseJson["data"]["photo_proof_img"];
        });
        if (responseJson['data']['user_group'][0] == 'user') {
          Fluttertoast.showToast(
              msg: 'Login Sucessfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return HomePage(
                      userId: userId!,
                      userName: userName,
                      userEmail: userEmail,
                      userMobile: userMobile,
                      userAddress: userAddress,
                      userProfile: userProfile,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      userCato: '',
                    );
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'division officer') {
          setState(() {
            userRange = responseJson['data']['range'];
            URange = List<String>.from(userRange);
          });
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return DivisonDashBoard(
                      userId: userId,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      userRange: URange,
                    );
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'state officer') {
          setState(() {
            distRange = responseJson['data']['division_range_list'];
            print("----------------------------#%%%------");

            for (int i = 0; i < distRange.length; i++) {
              Dist.add(
                  responseJson['data']['division_range_list'][i]['division']);
              Range.add(
                  responseJson['data']['division_range_list'][i]['ranges']);
              // URange=List<String>.from(Range);
              for (int j = 0; j < Range[i].length; j++) {
                URange.add(Range[i][j].toString());
              }

              //print(Range);
            }
            //D_Range=List<String>.from(Dist_Range);
          });
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return SFDashboard(
                      userId: userId!,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      dropdownValue: dropdownValue!,
                      userMobile: userMobile,
                      userProfile: userProfile,
                      userAddress: userAddress,
                      Dist: Dist,
                      Range: URange,
                      Dist_Range: distRange ?? [],
                    );
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'field officer') {
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return FieldOfficerDashboard(
                        userId: userId!,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        dropdownValue: dropdownValue!,
                        userMobile: userMobile,
                        userProfile: userProfile,
                        userAddress: userAddress);
                  }));
        } else if (responseJson['data']['user_group'][0]
                .toString()
                .toLowerCase() ==
            'checkpost officer') {
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return checkPost(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup);
                  }));
        } else {
          if (userGroup == 'forest range officer') {
            Range = responseJson['data']['range'];
          }
          Fluttertoast.showToast(
              msg: 'Login Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    return ScaleTransition(
                      alignment: Alignment.topCenter,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return OfficerDashboard(
                      userId: userId!,
                      userName: userName,
                      userEmail: userEmail,
                      sessionToken: sessionToken,
                      userGroup: userGroup,
                      Range: Range,
                      dropdownValue: dropdownValue!,
                      userMobile: userMobile,
                      userAddress: userAddress,
                      //  userImage:userImage,
                    );
                  }));
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const login()),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
    // check_if_already_login();
  }
  //-----------------------------------End-Shared-Preferences-------------------

  bool isHiddenPassword = true;

  String sessionToken = '';
  int? userId;
  String userName = '';
  String userEmail = '';
  String userGroup = '';
  String userMobile = '';
  String userAddress = '';
  String userProfile = '';
  List? userRange;
  List<String> URange = [];
  List? Dist_Range;
  List<String> Dist = [];
  List Range = [];
  TextEditingController loginMobile = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  String? dropdownValue;
  String? login_holder = '';
  List<String> Officer_login = [
    'Revenue Officer',
    'Deputy Range Officer',
    'Forest Range Officer',
    'Division Officer',
    'State Officer',
    'Field Officer',
    'checkpost officer'
  ];
  bool check = false;
  void getDropDownItem() {
    setState(() {
      login_holder = dropdownValue;
      if (login_holder != null) {
        check = true;
      } else {
        check = false;
      }
    });
  }

  //------------------Assign Officer--------------------------------

  //------------------End-Assign-Officer----------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
            color: Colors.red[700]!,
            width: 1.2,
          ), //<---- Insert Gradient Here
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(144, 0, 0, 0),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 45),
        child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10, bottom: 0),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
              iconSize: 24,
              elevation: 0,
              style: const TextStyle(color: Colors.black, fontSize: 18),
              hint: const Text("Officer Login"),
              /*underline: Container(
                height: 2,
                color: Colors.grey,
              ),*/
              onChanged: (String? data) {
                setState(() {
                  dropdownValue = data;
                  if (dropdownValue == data) {
                    check = true;
                  } else {
                    check = false;
                  }
                });
              },
              items:
                  Officer_login.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          TextField(
              controller: loginEmail,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  prefixIcon: Icon(Icons.perm_identity_rounded),
                  hintText: 'Enter Email/Mobile',
                  labelText: "E-mail/Mobile",
                  hintStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                  ))),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: loginPassword,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: const Icon(Icons.vpn_key_outlined),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isHiddenPassword = !isHiddenPassword;
                    });
                  },
                  child: const Icon(Icons.visibility),
                ),
                hintText: 'Enter Password',
                labelText: "Password",
                hintStyle: const TextStyle(
                  fontFamily: 'Cairo',
                  fontStyle: FontStyle.normal,
                )),
            obscureText: isHiddenPassword,
            // obscuringCharacter: '',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const forgetPassword()));
                  },
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontStyle: FontStyle.normal,
                      color: Colors.blue[700],
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(8)),
            child: TextButton(
                // color: Colors.amber,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed: () async {
                  if ((loginEmail.text.isEmpty) ||
                      (loginPassword.text.isEmpty)) {
                    Fluttertoast.showToast(
                        msg: "Either User Name or password field is empty",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else if ((dropdownValue == null)) {
                    Fluttertoast.showToast(
                        msg: "Please Select Officer Login",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 18.0);
                  } else {
                    print("----login--");
                    const String url = '${ServerHelper.baseUrl}auth/NewLogin';
                    Map data = {
                      "email_or_phone": loginEmail.text.trim(),
                      "password": loginPassword.text.trim()
                    };

                    var body = json.encode(data);

                    final response = await http.post(Uri.parse(url),
                        headers: {'Content-Type': 'application/json'},
                        body: body);

                    Map<String, dynamic> responseJson =
                        json.decode(response.body);
                    log("----------------------login----------------");
                    log(response.body);

                    if (responseJson['status'] == "success") {
                      setState(() {
                        userId = responseJson['data']['id'];
                        userName = responseJson['data']['name'];
                        userEmail = responseJson["data"]["email"];
                        sessionToken = responseJson['token'];
                        userGroup = responseJson['data']['user_group'][0];
                        // Make sure to handle the phone and address fields safely
                        userMobile =
                            responseJson["data"]["phone"]?.toString() ?? '';
                        userAddress =
                            responseJson["data"]["address"]?.toString() ?? '';
                        userProfile = responseJson["data"]["photo_proof_img"] ??
                            'no_photo';
                      });
                      log(userMobile.toString());
                      log(userMobile.toString());
                      log(userMobile.toString());
                      if (dropdownValue != null &&
                          responseJson['data']['user_group'][0]
                                  .toString()
                                  .toLowerCase() ==
                              dropdownValue!.toLowerCase()) {
                        if (responseJson['data']['user_group'][0]
                                .toString()
                                .toLowerCase() ==
                            'division officer') {
                          prefs?.setBool('isLoggedIn', false);
                          prefs?.setString('LoginUser', loginEmail.text);
                          prefs?.setString('LoginPass', loginPassword.text);
                          setState(() {
                            userRange = responseJson['data']['range'];
                            URange = List<String>.from(userRange ?? []);
                          });
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 250),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.topCenter,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return DivisonDashBoard(
                                      userId: userId,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue,
                                      userRange: URange,
                                    );
                                  }));
                        } else if (responseJson['data']['user_group'][0]
                                .toString()
                                .toLowerCase() ==
                            'state officer') {
                          prefs?.setBool('isLoggedIn', false);
                          prefs?.setString('LoginUser', loginEmail.text);
                          prefs?.setString('LoginPass', loginPassword.text);
                          setState(() {
                            Dist_Range =
                                responseJson['data']['division_range_list'];

                            for (int i = 0; i < Dist_Range!.length; i++) {
                              Dist.add(responseJson['data']
                                  ['division_range_list'][i]['division']);
                              Range.add(responseJson['data']
                                  ['division_range_list'][i]['ranges']);
                              for (int j = 0; j < Range[i].length; j++) {
                                URange.add(Range[i][j].toString());
                              }
                            }
                          });
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 250),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.topCenter,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return SFDashboard(
                                      userId: userId!,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue!,
                                      userMobile: userMobile,
                                      userProfile: userProfile,
                                      userAddress: userAddress,
                                      Dist: Dist,
                                      Range: URange,
                                      Dist_Range: Dist_Range ?? [],
                                    );
                                  }));
                        } else if (responseJson['data']['user_group'][0]
                                .toString()
                                .toLowerCase() ==
                            'field officer') {
                          prefs!.setBool('isLoggedIn', false);
                          prefs!.setString('LoginUser', loginEmail.text);
                          prefs!.setString('LoginPass', loginPassword.text);
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 250),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.topCenter,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return FieldOfficerDashboard(
                                        userId: userId!,
                                        userName: userName,
                                        userEmail: userEmail,
                                        sessionToken: sessionToken,
                                        userGroup: userGroup,
                                        dropdownValue: dropdownValue!,
                                        userMobile: userMobile,
                                        userProfile: userProfile,
                                        userAddress: userAddress);
                                  }));
                        } else if (responseJson['data']['user_group'][0]
                                .toString()
                                .toLowerCase() ==
                            'checkpost officer') {
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 250),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.topCenter,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return checkPost(
                                        userId: userId,
                                        userName: userName,
                                        userEmail: userEmail,
                                        sessionToken: sessionToken,
                                        userGroup: userGroup);
                                  }));
                        } else {
                          if (userGroup == 'forest range officer') {
                            Range = responseJson['data']['range'];
                          }
                          prefs!.setBool('isLoggedIn', false);
                          prefs!.setString('LoginUser', loginEmail.text);
                          prefs!.setString('LoginPass', loginPassword.text);
                          Fluttertoast.showToast(
                              msg: 'Login Successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 250),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    return ScaleTransition(
                                      alignment: Alignment.topCenter,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return OfficerDashboard(
                                      userId: userId!,
                                      userName: userName,
                                      userEmail: userEmail,
                                      sessionToken: sessionToken,
                                      userGroup: userGroup,
                                      dropdownValue: dropdownValue!,
                                      Range: Range,
                                      userMobile: userMobile,
                                      userAddress: userAddress,
                                    );
                                  }));
                        }
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const login()),
                      );
                      Fluttertoast.showToast(
                          msg: 'Invalid credentials',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 4,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    }
                  }
                }),
          ),
          const SizedBox(
            height: 10,
          ),
        ]));
  }
}
