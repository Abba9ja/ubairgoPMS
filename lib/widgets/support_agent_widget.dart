import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../functions/sys_constants.dart';
import '../model/user_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';
import 'chat_screenf.dart';

class SupportAgentWidget extends StatefulWidget {
  @override
  State<SupportAgentWidget> createState() => _SupportAgentWidgetState();
}

class _SupportAgentWidgetState extends State<SupportAgentWidget> {
  SysConstants sys_constants = SysConstants();
  int house_index = -1;

  int sel_user_index = -1;
  UserF? sel_user;

  var msg_textfield;
  //HouseModel? house;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
            child: Container(
              width: width,
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('USERS')
                              .where('sys_status', isEqualTo: 'Estate Support')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  UserF support = UserF.fromDocument(
                                      snapshot.data!.docs[index]);
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          sel_user_index = index;
                                          sel_user = support;
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: sel_user_index == index
                                                ? 80
                                                : 45,
                                            height: sel_user_index == index
                                                ? 80
                                                : 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      support.profile_pic),
                                                  fit: BoxFit.cover),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 2),
                                              ],
                                            ),
                                          ),
                                          sel_user_index != index
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      support.full_name
                                                          .split(' ')[0],
                                                      style: TextStyle(
                                                          fontSize:
                                                              sel_user_index ==
                                                                      index
                                                                  ? 14
                                                                  : 12,
                                                          fontWeight:
                                                              sel_user_index ==
                                                                      index
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .w400),
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: SizedBox(
            width: width,
            height: height,
            child: sel_user != null
                ? ChatWidgetF(
                    is_back: false,
                    user_model: sel_user!,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: sys_constants.imgHolder(
                          width,
                          realtor,
                        ),
                      ),
                    ],
                  ),
          ))
        ],
      ),
    );
  }
}
