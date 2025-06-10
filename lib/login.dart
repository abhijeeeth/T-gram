import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io'; // Add this import for HttpClient and X509Certificate

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromARGB(49, 255, 255, 255),
                const Color.fromARGB(255, 28, 110, 99).withOpacity(0.5),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 28, 110, 99).withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 28,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/tigram01.png",
                        width: 100,
                        height: 70,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/kerala_logo.jpg",
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const LoginForm(),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 28, 110, 99).withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Kerala Forest Research Institute (KFRI)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
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
    return Column(
      children: <Widget>[
        TextField(
          controller: loginEmail,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.person,
                color: Color.fromARGB(255, 28, 110, 99)),
            hintText: 'Enter E-mail/Mobile',
            labelText: "E-mail/Mobile",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: loginPassword,
          obscureText: isHiddenPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            prefixIcon:
                const Icon(Icons.lock, color: Color.fromARGB(255, 28, 110, 99)),
            suffixIcon: IconButton(
              icon: Icon(
                isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                color: const Color.fromARGB(255, 28, 110, 99),
              ),
              onPressed: () {
                setState(() {
                  isHiddenPassword = !isHiddenPassword;
                });
              },
            ),
            hintText: 'Enter Password',
            labelText: "Password",
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const forgetPassword()));
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color.fromARGB(255, 28, 110, 99),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 110, 99),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const signup()));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 28, 110, 99),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 28, 110, 99),
                    ),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
