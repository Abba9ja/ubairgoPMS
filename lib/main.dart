import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ubairgo/firebase_options.dart';
import 'package:ubairgo/screens/error.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/screens/waiting.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WebView.platform = WebWebViewPlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),

      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Ubairgo | Estate Management Software',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: ErrorScreen(),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Ubairgo | Estate Management Software',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: SplashScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          title: 'Ubairgo | Estate Management Software',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: WaitingScreen(),
        );
      },
    );
  }
}
