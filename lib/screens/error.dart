import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubairgo/styles/responsive.dart';

import '../functions/sys_constants.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';

class ErrorScreen extends StatefulWidget {
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  SysConstants sys_constants = SysConstants();

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
          tiny: SizedBox(
            width: width,
            height: height,
          ),
          phone: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: sys_constants.imgHolder(300, building_home),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  errorWidget(),
                ],
              ),
            ),
          ),
          tablet: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: sys_constants.imgHolder(300, building_home),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  errorWidget(),
                ],
              ),
            ),
          ),
          largeTablet: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 300,
                    child: sys_constants.imgHolder(300, building_home),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  errorWidget(),
                ],
              ),
            ),
          ),
          computer: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: sys_constants.imgHolder(300, building_home),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  errorWidget(),
                ],
              ),
            ),
          )),
    );
  }

  Column errorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Could\'nt connect to Ubairgo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          maxLines: 1,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Try:',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Checking the network cables, modem and router',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Restart browser or app',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 170,
          height: 40,
          decoration: BoxDecoration(
            color: sys_green,
            borderRadius: BorderRadius.circular(50),
          ),
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.mailchimp,
              color: white,
            ),
            label: Text(
              'Contact Support',
              style: TextStyle(color: white, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
