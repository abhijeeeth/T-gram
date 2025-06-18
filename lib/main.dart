import 'dart:io';

import 'package:flutter/foundation.dart'
    show kDebugMode; // For debug mode check
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/homecheck.dart'; // Import your Homecheck page
import 'package:tigramnks/login.dart' as login_page;
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/sqflite/localstorage.dart'; // Add this import
import 'package:tigramnks/utils/db_initializer.dart';

import 'utils/config.dart';
import 'utils/http_overrides.dart';

// Add this class for SSL certificate bypass
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Make sure this runs before anything else
void _setHttpOverrides() {
  HttpOverrides.global = MyHttpOverrides();
}

void main() async {
  if (AppConfig.shouldBypassSecurity) {
    setupTestHttpOverrides();
  }

  // Only bypass SSL in debug mode for safety
  if (kDebugMode) {
    _setHttpOverrides();
  }

  WidgetsFlutterBinding.ensureInitialized();

  // Check token and user group before running the app
  String? token = await LocalStorage.getToken();
  String? userGroup = await LocalStorage.getUserGroup();
  String? userId = await LocalStorage.getUserId();
  String? range = await LocalStorage.getRange();
  String? email = await LocalStorage.getUserEmail();
  String? userName = await LocalStorage.getUserName();
  String? userMobile = await LocalStorage.getUserMobile();
  String? userAdress = await LocalStorage.getUserAddress();

  Widget initialScreen;
  if (token != null && userGroup != "user") {
    ServerHelper.token = token;
    ServerHelper.userGroup = userGroup;
    initialScreen = Homecheck(
      userId: int.parse(userId ?? '0'),
      userName: userName.toString(),
      userEmail: email.toString(),
      sessionToken: token.toString(),
      userGroup: userGroup.toString(),
      dropdownValue: '',
      Range: range != null && range.isNotEmpty ? range.split(',') : [],
      userMobile: userMobile,
      userAddress: userAdress,
    ); // Replace with your Homecheck widget
  } else {
    initialScreen = const login_page.login();
  }

  runApp(
    DatabaseInitializer.wrapWithDatabaseInitialization(
      child: MyApp(initialScreen: initialScreen),
      loadingWidget: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      errorWidget: const MaterialApp(
        home: Scaffold(
          body: Center(
            child:
                Text('Failed to initialize database. Please restart the app.'),
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.teal,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(99, 118, 71, 1),
            brightness: Brightness.light,
            secondary: const Color.fromARGB(195, 105, 138, 132),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(99, 118, 71, 1),
            foregroundColor: Colors.white,
          ),
        ),
        home: initialScreen,
      ),
    );
  }
}
