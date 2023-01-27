import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/styles/responsive.dart';

import '../model/button_model.dart';
import '../model/house_model.dart';
import '../model/notice_board_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';
import 'my_house_widget.dart';
import 'notice_board_widget.dart';
import 'support_agent_widget.dart';

class DashboardWidget extends StatefulWidget {
  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  SysConstants sys_constants = SysConstants();
  int house_index = -1;
  HouseModel? house;

  int sel_user_index = -1;
  UserModel? sel_user;

  var msg_textfield;

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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 250,
                      child: NoticeboardWidget(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: width,
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyHouseWidget(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          tablet: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: 250,
                      child: NoticeboardWidget(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: width,
                      height: 850,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyHouseWidget(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          largeTablet: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              height: 250,
                              child: NoticeboardWidget(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: width,
                              height: 850,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: MyHouseWidget(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 1),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, 0),
                                    blurRadius: 0),
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.support_agent,
                                              size: 22,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Support Agents',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  child: Container(
                                    width: width,
                                    height: 1,
                                    color: sys_green,
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: width,
                                          height: height,
                                          child: SupportAgentWidget(),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: height,
                                        color: sys_green,
                                      )
                                    ],
                                  ),
                                ))
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
          computer: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: ResponsiveLayout.isCLT(context) ? 4 : 5,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              height: 250,
                              child: NoticeboardWidget(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: width,
                              height: 900,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: MyHouseWidget(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 1),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, 0),
                                    blurRadius: 0),
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.support_agent,
                                              size: 22,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Support Agents',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  child: Container(
                                    width: width,
                                    height: 1,
                                    color: sys_green,
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: width,
                                          height: height,
                                          child: SupportAgentWidget(),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: height,
                                        color: sys_green,
                                      )
                                    ],
                                  ),
                                ))
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
        ));
  }
}
