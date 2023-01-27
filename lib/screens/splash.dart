import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/landing.dart';
import 'package:ubairgo/screens/login.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/responsive.dart';

UserF? currentUser;
//TODO
//1. Set App links / Variables / Functions
//2. Don't know yet

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SysConstants sys_constants = SysConstants();
  late StreamSubscription<User?> user;
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user == null) {
          gotoSignIn();
        } else {
          controlSignIn(user);
        }
      },
    );
  }

  void setUser(User? user) async {
    if (user != null) {
      DocumentSnapshot userdoc = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(user.email)
          .get();
      if (userdoc.exists) {
        setState(() {
          currentUser = UserF.fromDocument(userdoc);
        });
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LandingScreen(),
            ));
      }
    }
  }

  void gotoSignIn() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ));
  }

  void controlSignIn(User? user) {
    if (user != null) {
      setUser(user);
    } else {
      gotoSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0.0,
          backgroundColor: sys_green,
        ),
        body: ResponsiveLayout(
          tiny: SizedBox(),
          phone: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SizedBox(), UbairgoHr(150.0), fromHandler(80)],
            ),
          ),
          tablet: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SizedBox(), UbairgoHr(180.0), fromHandler(80)],
            ),
          ),
          largeTablet: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SizedBox(), UbairgoHr(200.0), fromHandler(80)],
            ),
          ),
          computer: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SizedBox(), UbairgoHr(200.0), fromHandler(80)],
            ),
          ),
        ));
  }

  Padding fromHandler(double width) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'From',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          sys_constants.fromQima(width)
        ],
      ),
    );
  }

  Column UbairgoHr(double width) {
    return Column(
      children: [
        SizedBox(
          height: 80,
        ),
        sys_constants.ubairgoHorizontal(width)
      ],
    );
  }
}
