import 'package:flutter/material.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/screens/login.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/responsive.dart';

class WaitingScreen extends StatefulWidget {
  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  SysConstants sys_constants = SysConstants();

  void initState() {
    super.initState();
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
