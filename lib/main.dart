import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:tigramnks/login.dart';
import 'dart:io';

// Add this class for SSL certificate bypass
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

// Make sure this runs before anything else
void _setHttpOverrides() {
  HttpOverrides.global = MyHttpOverrides();
}

void main() async {
  // Set overrides before anything else
  _setHttpOverrides();
  
  // Then initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(99, 118, 71, 1),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(99, 118, 71, 1),
          foregroundColor: Colors.white,
        ),
      ),
      home: login(),
    );
  }
}