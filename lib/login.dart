import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // Add this import for HttpClient and X509Certificate

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/io_client.dart'; // Add this import for IOClient
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigramnks/DivisionDashboard.dart';
import 'package:tigramnks/FieldOfficerDashboard.dart';
import 'package:tigramnks/SFDashboard.dart';
import 'package:tigramnks/forgetPassword.dart';
import 'package:tigramnks/homePage.dart';
import 'package:tigramnks/homecheck.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/signup.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                width: double.infinity,
                height: 65,
                // color: HexColor("#02075D"),
                color: HexColor("#004d40"),
                child: Row(
                  children: <Widget>[
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      // color: const Color.fromARGB(255, 255, 255, 255),
                      child: Image.asset(
                        "assets/images/tigram01.png",
                        width: 120,
                        height: 90,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Container(
                padding: const EdgeInsets.only(right: 15, top: 8),
                width: double.infinity,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/kerala_logo.jpg",
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              const LoginForm(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                child: const Text(
                  "Kerala Forest Research Institute (KFRI)",
                  style: TextStyle(
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
        ),
      ),
    );
  }
}

//-------------------------------LoginForm-------------------------------------

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isHiddenPassword = true;
  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();
  bool _isLoading = false;

  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _login() async {
    if (loginEmail.text.isEmpty || loginPassword.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Either User Name or password field is empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const String url = '${ServerHelper.baseUrl}auth/NewLogin';
    Map data = {
      "email_or_phone": loginEmail.text.trim(),
      "password": loginPassword.text.trim()
    };

    try {
      HttpClient httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

      // Create an IOClient using the custom HttpClient
      IOClient ioClient = IOClient(httpClient);

      // Make the POST request
      final response = await ioClient
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw TimeoutException(
                "Connection timed out. Please try again."),
          );

      // Close the client when done
      ioClient.close();

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      Map<String, dynamic> responseJson = json.decode(response.body);

      if (responseJson['status'] == "success") {
        final userGroup =
            responseJson['data']['user_group'][0].toString().toLowerCase();
        final userId = responseJson['data']['id'];
        final userName = responseJson['data']['name'];
        final userEmail = responseJson["data"]["email"];
        final userMobile = responseJson["data"]["phone"]?.toString() ?? '';
        final userAddress = responseJson["data"]["address"]?.toString() ?? '';
        final sessionToken = responseJson["token"];
        ServerHelper.token = sessionToken;
        ServerHelper.userGroup = userGroup;
        log(userGroup);
        final userProfile = responseJson["data"]["photo_proof_img"] ?? '';
        final userCato = responseJson['data']['usr_category'] ?? '';

        prefs?.setString('LoginUser', loginEmail.text);
        prefs?.setString('LoginPass', loginPassword.text);
        prefs?.setBool('isLoggedIn', false);

        if (userGroup == 'user') {
          Fluttertoast.showToast(
              msg: 'Welcome $userName',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => HomePage(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        userMobile: userMobile,
                        userAddress: userAddress,
                        userProfile: userProfile,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        userCato: userCato,
                      )));
        } else if (userGroup == 'division officer') {
          final userRange =
              List<String>.from(responseJson['data']['range'] ?? []);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => DivisonDashBoard(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        dropdownValue: '',
                        userRange: userRange,
                      )));
        } else if (userGroup == 'state officer') {
          final distRange = responseJson['data']['division_range_list'] ?? [];
          List<String> Dist = [];
          List<String> URange = [];
          List Range = [];
          for (int i = 0; i < distRange.length; i++) {
            Dist.add(distRange[i]['division']);
            Range.add(distRange[i]['ranges']);
            for (int j = 0; j < Range[i].length; j++) {
              URange.add(Range[i][j].toString());
            }
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => SFDashboard(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        dropdownValue: "",
                        userMobile: userMobile,
                        userProfile: userProfile,
                        userAddress: userAddress,
                        Dist: Dist,
                        Range: URange,
                        Dist_Range: distRange,
                      )));
        } else if (userGroup == 'field officer') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => FieldOfficerDashboard(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        dropdownValue: '',
                        userMobile: userMobile,
                        userProfile: userProfile,
                        userAddress: userAddress,
                      )));
        } else if (userGroup == 'checkpost officer') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => checkPost(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                      )));
        } else {
          final Range = responseJson['data']['range'] ?? [];
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => Homecheck(
                        userId: userId,
                        userName: userName,
                        userEmail: userEmail,
                        sessionToken: sessionToken,
                        userGroup: userGroup,
                        dropdownValue: '',
                        Range: Range,
                        userMobile: userMobile,
                        userAddress: userAddress,
                      )));
        }
      } else {
        String errorMessage = responseJson['message'] ?? 'Error occurred';
        Fluttertoast.showToast(
            msg: errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      String errorMessage = 'Login failed. ';
      if (e is TimeoutException) {
        errorMessage += 'Connection timed out.';
      } else if (e.toString().contains('SocketException')) {
        errorMessage += 'No internet connection.';
      } else {
        errorMessage += 'Please try again.';
      }

      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.2,
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromARGB(73, 0, 0, 0),
        //     blurRadius: 2.0,
        //     spreadRadius: 0.0,
        //     offset: Offset(2.0, 2.0),
        //   )
        // ],
      ),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 30),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 45, bottom: 30),
      child: Column(
        children: <Widget>[
          TextField(
            controller: loginEmail,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              prefixIcon: Icon(Icons.perm_identity_rounded),
              hintText: 'Enter E-mail/Mobile',
              labelText: "E-mail/Mobile",
              hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                child: Icon(
                  isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              hintText: 'Enter Password',
              labelText: "Password",
              hintStyle: const TextStyle(
                fontFamily: 'Cairo',
                fontStyle: FontStyle.normal,
              ),
            ),
            obscureText: isHiddenPassword,
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
                child: const Text(
                  'Forget Password',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontStyle: FontStyle.normal,
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(8)),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2.0,
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: _login,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const signup()),
                            );
                          },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
