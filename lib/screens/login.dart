import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ubairgo/screens/sign_up.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/responsive.dart';

import '../functions/sys_constants.dart';
import '../styles/sysimg_constants.dart';
import '../widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: tpLoginView(width, context, height),
        ),
        tablet: SizedBox(
          width: width,
          height: height,
          child: tpLoginView(width, context, height),
        ),
        largeTablet: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                  top: 50,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                illustrationWidget(550),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: width,
                            height: height,
                            color: Colors.grey.shade50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 0, 0, 0),
                                  child: SizedBox(
                                    width: 350,
                                    height: 500,
                                    child: LoginWidget(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                width: width,
                height: 70,
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 0),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          child: sys_constants.ubairgoHorizontalTM(60),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text('Tenant / Lanloard?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SignUpScreen(),
                                      ));
                                },
                                child: Text('Sign up'),
                              )
                            ],
                          ),
                          SizedBox(width: 30),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.support_agent),
                              label: Text('Support'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Developed by:',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                width: 120,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Image(
                                    image: AssetImage(qima_dev),
                                    width: width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Protected by:',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                width: 100,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Image(
                                    image: AssetImage(google),
                                    width: width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        computer: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                  top: 50,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                illustrationWidget(550),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: width,
                            height: height,
                            color: Colors.grey.shade50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 0, 0, 0),
                                  child: SizedBox(
                                    width: 350,
                                    height: 500,
                                    child: LoginWidget(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                width: width,
                height: 70,
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 0),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          child: sys_constants.ubairgoHorizontalTM(60),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text('Tenant / Lanloard?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SignUpScreen(),
                                      ));
                                },
                                child: Text('Sign up'),
                              )
                            ],
                          ),
                          SizedBox(width: 30),
                          TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.support_agent),
                              label: Text('Support'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Developed by:',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                width: 120,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Image(
                                    image: AssetImage(qima_dev),
                                    width: width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Protected by:',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 40,
                                width: 100,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Image(
                                    image: AssetImage(google),
                                    width: width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column tpLoginView(double width, BuildContext context, double height) {
    return Column(
      children: [
        Container(
          width: width,
          height: 70,
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, 0),
                blurRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                ResponsiveLayout.isPhone(context) ? 10 : 50,
                10,
                ResponsiveLayout.isPhone(context) ? 10 : 50,
                0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    child: sys_constants.ubairgoHorizontalTM(60),
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text('Tenant / Lanloard?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignUpScreen(),
                                ));
                          },
                          child: Text('Sign up'),
                        )
                      ],
                    ),
                    SizedBox(width: 30),
                    ResponsiveLayout.isPhone(context)
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.support_agent),
                          )
                        : TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.support_agent),
                            label: Text('Support'))
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      illustrationWidget(550),
                    ],
                  ),
                ),
                Positioned(
                  left: ResponsiveLayout.isPhone(context) ? 10 : 20,
                  right: ResponsiveLayout.isPhone(context) ? 10 : 20,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.9),
                                Colors.white.withOpacity(0.6),
                              ],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.teal.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 350,
                                height: 500,
                                child: LoginWidget(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Developed by:',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 120,
                    child: TextButton(
                      onPressed: () {},
                      child: Image(
                        image: AssetImage(qima_dev),
                        width: width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Protected by:',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: TextButton(
                      onPressed: () {},
                      child: Image(
                        image: AssetImage(google),
                        width: width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox illustrationWidget(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: sys_constants.houseAmico(550),
      ),
    );
  }
}
