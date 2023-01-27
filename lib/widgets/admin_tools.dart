import 'package:flutter/material.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/styles/responsive.dart';

import '../model/button_model.dart';
import '../styles/colors.dart';
import 'accounting_widget.dart';
import 'property_repository.dart';
import 'users_management.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  SysConstants sys_constants = SysConstants();

  int sel_index = 0;

  List<ButtonModel> navButtons = [
    ButtonModel(title: 'House/Plot', icon: Icons.real_estate_agent),
    ButtonModel(title: 'Accountig', icon: Icons.account_balance),
    ButtonModel(title: 'Users', icon: Icons.people),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: sys_green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: sel_index == 0 ? Colors.white : sys_green,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                sel_index = 0;
                              });
                            },
                            icon: Icon(
                              Icons.real_estate_agent,
                              color: sel_index == 0
                                  ? sys_green
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: width,
                        height: height,
                        color: sel_index == 1 ? Colors.white : sys_green,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                sel_index = 1;
                              });
                            },
                            icon: Icon(
                              Icons.account_balance,
                              color: sel_index == 1
                                  ? sys_green
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: sel_index == 2 ? Colors.white : sys_green,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  sel_index = 2;
                                });
                              },
                              icon: Icon(
                                Icons.people,
                                color: sel_index == 2
                                    ? sys_green
                                    : Colors.grey.shade300,
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
          ),
          Expanded(
            child: SizedBox(
              width: width,
              height: height,
              child: screenState(width, height),
            ),
          )
        ],
      ),
    );
  }

  Widget screenState(
    double width,
    double height,
  ) {
    switch (sel_index) {
      case 0:
        return PropertyRepo();
      case 1:
        return AccountingWidget();
      case 2:
        return UsersMngt();
      default:
        return SizedBox();
    }
  }
}
