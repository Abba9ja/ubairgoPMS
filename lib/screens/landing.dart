import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/widgets/dashboard_widget.dart';

import '../model/button_model.dart';
import '../model/house_model.dart';
import '../model/notice_board_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';
import '../widgets/admin_tools.dart';
import '../widgets/emargency.dart';
import '../widgets/explore_widget.dart';
import '../widgets/messenger.dart';
import '../widgets/verified_supports.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  SysConstants sys_constants = SysConstants();

  List<ButtonModel> navButtons = [
    ButtonModel(title: 'Dashboard', icon: Icons.dashboard),
    ButtonModel(title: 'Explore', icon: Icons.real_estate_agent),
    ButtonModel(title: 'People', icon: Icons.people),
    ButtonModel(title: 'Forums', icon: Icons.question_answer),
    ButtonModel(title: 'Emergency', icon: Icons.emergency),
    ButtonModel(title: 'Admin', icon: Icons.admin_panel_settings),
  ];

  int navIndex = 0;
  int house_index = -1;
  HouseModel? house;

  int sel_user_index = -1;
  UserModel? sel_user;

  var msg_textfield;

  List<Widget> _icons = [
    Icon(
      Icons.dashboard,
      size: 20,
      color: Colors.white,
    ),
    Icon(
      Icons.real_estate_agent,
      size: 20,
      color: Colors.white,
    ),
    Icon(
      Icons.people,
      size: 20,
      color: Colors.white,
    ),
    /* Icon(
      Icons.perm_media,
      size: 20,
      color: Colors.white,
    ),*/
    Icon(
      Icons.question_answer,
      size: 20,
      color: Colors.white,
    ),
    Icon(
      Icons.emergency,
      size: 20,
      color: Colors.white,
    ),
  ];

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
          child: switchScreens(navIndex),
        ),
        tablet: SizedBox(
            width: width, height: height, child: switchScreens(navIndex)),
        largeTablet: SizedBox(
          width: width,
          height: height,
          child: Row(
            children: [
              Container(
                width: 80,
                height: height,
                color: sys_green,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: TextButton(
                          onPressed: () {
                            logOut();
                          },
                          child: sys_constants.ubairgoWhite(100)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                navButtons.length,
                                (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 20, 5, 5),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: navIndex == index
                                              ? white
                                              : sys_green,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [],
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(navButtons[index].icon),
                                            onPressed: () {
                                              setState(() {
                                                navIndex = index;
                                              });
                                            },
                                            color: navIndex == index
                                                ? sys_green
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: sys_green,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(0, 0),
                              blurRadius: 2),
                          BoxShadow(
                              color: sys_green,
                              offset: Offset(-0, -0),
                              blurRadius: 2),
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            logOut();
                          },
                          icon: Icon(
                            Icons.support_agent,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SizedBox(
                      width: width,
                      height: height,
                      child: switchScreens(navIndex)))
            ],
          ),
        ),
        computer: SizedBox(
          width: width,
          height: height,
          child: Row(
            children: [
              Container(
                width: 100,
                height: height,
                color: sys_green,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                          onPressed: () {},
                          child: sys_constants.ubairgoWhite(100)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                navButtons.length,
                                (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 20, 5, 5),
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: navIndex == index
                                              ? white
                                              : sys_green,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [],
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(navButtons[index].icon),
                                            onPressed: () {
                                              setState(() {
                                                navIndex = index;
                                              });
                                            },
                                            color: navIndex == index
                                                ? sys_green
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: sys_green,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(0, 0),
                              blurRadius: 2),
                          BoxShadow(
                              color: sys_green,
                              offset: Offset(-0, -0),
                              blurRadius: 2),
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.support_agent,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SizedBox(
                      width: width,
                      height: height,
                      child: switchScreens(navIndex)))
            ],
          ),
        ),
      ),
      bottomNavigationBar: ResponsiveLayout.isPhone(context) ||
              ResponsiveLayout.isTablet(context)
          ? CurvedNavigationBar(
              index: navIndex,
              color: sys_green,
              backgroundColor: white,
              items: _icons,
              onTap: (index) {
                setState(() {
                  navIndex = index;
                });
              })
          : null,
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SplashScreen(),
        ));
  }

  switchScreens(int navIndex) {
    switch (navIndex) {
      case 0:
        return DashboardWidget();
      case 1:
        return ExploreWidget();
      case 2:
        return VSWidget();
      case 3:
        return MessengerWidget();
      case 4:
        return EmergencyWidget();
      case 5:
        return AdminScreen();
      default:
    }
  }
}
