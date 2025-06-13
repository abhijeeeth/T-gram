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
import 'package:tigramnks/sqflite/localstorage.dart';

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
        body: Container(
          decoration: const BoxDecoration(
              // color: const Color.fromARGB(255, 28, 110, 99).withOpacity(0.05),
              ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 28, 110, 99),
                        ),
                      ),
                      Image.asset(
                        "assets/images/tigram01.png",
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    "assets/images/kerala_logo.jpg",
                    height: 80,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const LoginForm(),
                ),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "v${snapshot.data!.version}",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: const Color.fromARGB(255, 28, 110, 99),
                  child: const Text(
                    "Kerala Forest Research Institute (KFRI)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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
        LocalStorage.saveToken(sessionToken);
        LocalStorage.saveUserGroup(userGroup);
        LocalStorage.saveUserId(userId.toString());
        LocalStorage.saveUserName(userName);
        LocalStorage.saveUserEmail(userEmail);
        LocalStorage.saveRange(responseJson['data']['range']?.toString() ?? '');
        LocalStorage.saveUserMobile(userMobile);
        LocalStorage.saveUserAddress(userAddress);

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: loginEmail,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            prefixIcon: const Icon(Icons.person),
            hintText: 'E-mail/Mobile',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: loginPassword,
          obscureText: isHiddenPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                  isHiddenPassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () =>
                  setState(() => isHiddenPassword = !isHiddenPassword),
            ),
            hintText: 'Password',
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const forgetPassword())),
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isLoading ? null : _login,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 28, 110, 99),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : const Text('LOGIN',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: _isLoading
              ? null
              : () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const signup())),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('SIGN UP',
              style: TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }
}
