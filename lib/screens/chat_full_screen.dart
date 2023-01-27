import 'package:flutter/material.dart';
import 'package:ubairgo/styles/responsive.dart';

import '../model/user_model.dart';
import '../styles/colors.dart';
import '../widgets/chat_screenf.dart';

class ChatFullScreen extends StatefulWidget {
  UserF userf;
  ChatFullScreen({
    required this.userf,
  });
  @override
  State<ChatFullScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatFullScreen> {
  int ch_index = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
        ),
        tablet: SizedBox(
          width: width,
          height: height,
        ),
        largeTablet: SizedBox(
          width: width,
          height: height,
        ),
        computer: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: sys_green,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: width * 0.6,
                          height: height,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 2)
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: SizedBox(
                                    width: width,
                                    height: height,
                                    child: ChatWidgetF(
                                      is_back: false,
                                      user_model: widget.userf,
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: SizedBox(
                                    width: width,
                                    height: height,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: width,
                                            height: 40,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: width,
                                                    height: height,
                                                    color: ch_index == 0
                                                        ? sys_green
                                                        : white,
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ch_index = 0;
                                                          });
                                                        },
                                                        child: Text(
                                                          'Media files',
                                                          style: TextStyle(
                                                              color: ch_index ==
                                                                      0
                                                                  ? white
                                                                  : Colors.grey,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  ch_index == 0
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    width: width,
                                                    height: height,
                                                    color: ch_index == 1
                                                        ? sys_green
                                                        : white,
                                                    child: Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ch_index = 1;
                                                          });
                                                        },
                                                        child: Text(
                                                          'Properties',
                                                          style: TextStyle(
                                                              color: ch_index ==
                                                                      1
                                                                  ? white
                                                                  : Colors.grey,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  ch_index == 1
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: chSwitch(width, height),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  chSwitch(double width, double height) {}
}
