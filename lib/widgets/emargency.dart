import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:ubairgo/widgets/chat_screen.dart';
import 'package:ubairgo/widgets/chat_screenf.dart';

import '../functions/sys_constants.dart';
import '../model/emergency_model.dart';

class EmergencyWidget extends StatefulWidget {
  @override
  State<EmergencyWidget> createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget> {
  EmergencyModel? sel_emrg;
  SysConstants sys_constants = SysConstants();

  UserF? selected_user;

  var search_textfield;

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
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  peopleTop(),
                  Expanded(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: eslist(width, height, true),
                    ),
                  ),
                ],
              ),
            ),
          ),
          tablet: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  peopleTop(),
                  Expanded(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: eslist(width, height, true),
                    ),
                  ),
                ],
              ),
            ),
          ),
          largeTablet: SizedBox(
            width: width,
            height: height,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          peopleTop(),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: eslist(width, height, false),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 20, 20),
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 2),
                          ],
                        ),
                        child: selected_user != null
                            ? ChatWidgetF(
                                user_model: selected_user, is_back: false)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: sys_constants.imgHolder(
                                        250, service_24),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          computer: SizedBox(
            width: width,
            height: height,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          peopleTop(),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: eslist(width, height, false),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 20, 20),
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 2),
                          ],
                        ),
                        child: selected_user != null
                            ? ChatWidgetF(
                                user_model: selected_user, is_back: false)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: sys_constants.imgHolder(
                                        250, service_24),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  SingleChildScrollView eslist(double width, double height, bool isback) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            width: width,
            height: 250,
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  height: 250,
                  child: Image(
                    image: AssetImage(
                        'assets/illustration/hospital_emergency.png'),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hospital Emergency support 24/7',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Linkable(
                            text:
                                'Hospital emergency services means the health care delivered to outpatients within or under the care and supervision of personnel working in a designated emergency department or emergency room of a hospital.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 75,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('HOSPITAL ASSISTANT')
                                    .orderBy('date_reg', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    ESAgentF esa = ESAgentF.fromDocument(
                                        snapshot.data!.docs[0]);

                                    return FutureBuilder<DocumentSnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection('USERS')
                                            .doc(esa.email_address)
                                            .get(),
                                        builder: (context, user_snapshot) {
                                          if (user_snapshot.hasData &&
                                              user_snapshot.data != null &&
                                              user_snapshot.data!.exists) {
                                            UserF user = UserF.fromDocument(
                                                user_snapshot.data!);
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: user
                                                                  .profile_pic
                                                                  .isEmpty
                                                              ? sys_constants
                                                                  .getRandomColor(
                                                                      user.sys_status)
                                                              : Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(user
                                                                  .profile_pic),
                                                              fit:
                                                                  BoxFit.cover),
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 1),
                                                          ],
                                                        ),
                                                        child:
                                                            user.profile_pic
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                      user.full_name
                                                                          .split(' ')[
                                                                              0]
                                                                          .split(
                                                                              '')[0],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : SizedBox(),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: width,
                                                          height: 50,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              if (isback) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        ChatWidgetF(
                                                                      is_back:
                                                                          true,
                                                                      user_model:
                                                                          user,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                setState(() {
                                                                  selected_user =
                                                                      user;
                                                                });
                                                              }
                                                            },
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  user.full_name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      user.status,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    (user.is_verified)
                                                                        ? Icon(
                                                                            Icons
                                                                                .verified,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                sys_green)
                                                                        : SizedBox()
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.call,
                                                          color: sys_green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                  child: Card(
                                                    color: sys_green,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          sys_constants.ratingValue(
                                                              user.rate,
                                                              user.is_verified),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        });
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            width: width,
            height: 250,
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Police Emergency Response Team 24/7',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Linkable(
                            text:
                                'The team consists of specially trained officers chosen from all sections within the Police Department. ERT members must be patrol officers for two years before applying to join the ERT Team.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 75,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('POLICE ASSISTANT')
                                    .orderBy('date_reg', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    ESAgentF esa = ESAgentF.fromDocument(
                                        snapshot.data!.docs[0]);

                                    return FutureBuilder<DocumentSnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection('USERS')
                                            .doc(esa.email_address)
                                            .get(),
                                        builder: (context, user_snapshot) {
                                          if (user_snapshot.hasData &&
                                              user_snapshot.data != null &&
                                              user_snapshot.data!.exists) {
                                            UserF user = UserF.fromDocument(
                                                user_snapshot.data!);
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: user
                                                                  .profile_pic
                                                                  .isEmpty
                                                              ? sys_constants
                                                                  .getRandomColor(
                                                                      user.sys_status)
                                                              : Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(user
                                                                  .profile_pic),
                                                              fit:
                                                                  BoxFit.cover),
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 1),
                                                          ],
                                                        ),
                                                        child:
                                                            user.profile_pic
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                      user.full_name
                                                                          .split(' ')[
                                                                              0]
                                                                          .split(
                                                                              '')[0],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : SizedBox(),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: width,
                                                          height: 50,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              if (isback) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        ChatWidgetF(
                                                                      is_back:
                                                                          true,
                                                                      user_model:
                                                                          user,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                setState(() {
                                                                  selected_user =
                                                                      user;
                                                                });
                                                              }
                                                            },
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  user.full_name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      user.status,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    (user.is_verified)
                                                                        ? Icon(
                                                                            Icons
                                                                                .verified,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                sys_green)
                                                                        : SizedBox()
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.call,
                                                          color: sys_green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                  child: Card(
                                                    color: sys_green,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          sys_constants.ratingValue(
                                                              user.rate,
                                                              user.is_verified),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        });
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  width: 300,
                  height: 250,
                  child: Image(
                    image: AssetImage('assets/illustration/police_ill.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            width: width,
            height: 250,
            child: Row(
              children: [
                SizedBox(
                  width: 300,
                  height: 250,
                  child: Image(
                    image: AssetImage('assets/illustration/security_post.png'),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estate Security Post 24/7',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Linkable(
                            text:
                                'A security guard’s duties can range from simply being present to reacting to robberies and assaults and maintaining law and order. Knowing all the responsibilities of a security guard goes a long way in ensuring that your property is secure.',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 75,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('E-SECURITY ASISTANT')
                                    .orderBy('date_reg', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    ESAgentF esa = ESAgentF.fromDocument(
                                        snapshot.data!.docs[0]);

                                    return FutureBuilder<DocumentSnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection('USERS')
                                            .doc(esa.email_address)
                                            .get(),
                                        builder: (context, user_snapshot) {
                                          if (user_snapshot.hasData &&
                                              user_snapshot.data != null &&
                                              user_snapshot.data!.exists) {
                                            UserF user = UserF.fromDocument(
                                                user_snapshot.data!);
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width,
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: user
                                                                  .profile_pic
                                                                  .isEmpty
                                                              ? sys_constants
                                                                  .getRandomColor(
                                                                      user.sys_status)
                                                              : Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(user
                                                                  .profile_pic),
                                                              fit:
                                                                  BoxFit.cover),
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 1),
                                                          ],
                                                        ),
                                                        child:
                                                            user.profile_pic
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                      user.full_name
                                                                          .split(' ')[
                                                                              0]
                                                                          .split(
                                                                              '')[0],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              25,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : SizedBox(),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: width,
                                                          height: 50,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              if (isback) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        ChatWidgetF(
                                                                      is_back:
                                                                          true,
                                                                      user_model:
                                                                          user,
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                setState(() {
                                                                  selected_user =
                                                                      user;
                                                                });
                                                              }
                                                            },
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  user.full_name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      user.status,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    (user.is_verified)
                                                                        ? Icon(
                                                                            Icons
                                                                                .verified,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                sys_green)
                                                                        : SizedBox()
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.call,
                                                          color: sys_green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                  child: Card(
                                                    color: sys_green,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          sys_constants.ratingValue(
                                                              user.rate,
                                                              user.is_verified),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        });
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row peopleTop() {
    return Row(
      children: [
        Icon(
          Icons.emergency,
          size: 25,
          color: Colors.black54,
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Emergency Support',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }
}
