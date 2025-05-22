import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/login.dart';
import 'package:tigramnks/utils/db_initializer.dart';

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

// Example usage in main.dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DatabaseInitializer.wrapWithDatabaseInitialization(
      child: const MyApp(),
      loadingWidget: const MaterialApp(
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: MaterialApp(
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
        home: const login(),
      ),
    );
  }
}
