import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:linkable/linkable.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/widgets/chat_screenf.dart';
import 'package:uuid/uuid.dart';

import '../functions/sys_constants.dart';
import '../model/house_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';

class MyHouseWidget extends StatefulWidget {
  @override
  State<MyHouseWidget> createState() => _MyHouseWidgetState();
}

class _MyHouseWidgetState extends State<MyHouseWidget> {
  SysConstants sys_constants = SysConstants();
  int house_index = -1;
  HouseModel? house;

  bool viewProperty = false;

  HouseModel? sel_property;

  PropertyF? selected_property;

  UserF? sel_user;

  Widget listNone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: sys_constants.imgHolder(250, house_waiting),
        )
      ],
    );
  }

  Widget listWaiting() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: sys_constants.imgHolder(250, loading),
        )
      ],
    );
  }

  int getGrid() {
    if (ResponsiveLayout.isPhone(context)) {
      return 1;
    } else if (ResponsiveLayout.isTablet(context)) {
      return 2;
    } else if (ResponsiveLayout.isPT(context)) {
      return 1;
    } else if (ResponsiveLayout.isCLT(context)) {
      return 2;
    } else if (ResponsiveLayout.isLargeTable(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  Column userWview(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: 50,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 2),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey.shade100,
                        child: Text(
                          '                                     ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.grey.shade100,
                            child: Text(
                              '                     ',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: Colors.grey.shade100,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade100,
          width: 90,
          height: 15,
        )
      ],
    );
  }

  bool show_chat = false;

  proceedFurther(UserF userf) {
    String msg_id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('CHAT SPACE')
        .doc(sys_constants.getChatRoomId(
            selected_property!.property_handler, currentUser!.email_address))
        .collection('CHAT')
        .doc(msg_id)
        .set({
      'id': msg_id,
      'type': 'Property',
      'content': 'Lets proceed further on this property',
      'sender': currentUser!.email_address,
      'receiver': selected_property!.property_handler,
      'time': DateTime.now(),
      'search_query':
          ('Lets proceed further on this property' + selected_property!.plot_no)
              .toLowerCase()
              .split(' '),
      'views': [currentUser!.email_address]
    }).then((value) {
      String id = Uuid().v4();
      FirebaseFirestore.instance
          .collection('CHAT SPACE')
          .doc(sys_constants.getChatRoomId(
              selected_property!.property_handler, currentUser!.email_address))
          .collection('CHAT')
          .doc(msg_id)
          .collection('Property')
          .doc(id)
          .set({
        'id': id,
        'plot_no': selected_property!.plot_no.toUpperCase(),
        'caption': selected_property!.title,
        'time': DateTime.now()
      });
    });
    setState(() {
      show_chat = true;
      sel_user = userf;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(5)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: width,
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.real_estate_agent,
                      size: 22,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Houses',
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
          Expanded(
            child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: sys_green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: SizedBox(
                          width: width,
                          height: height,
                          child: selected_property == null
                              ? StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('USERS')
                                      .doc(currentUser!.email_address)
                                      .collection('OWN PROPERTY')
                                      .orderBy('date_reg', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.none) {
                                      return noneWidget();
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return GridView.builder(
                                        itemCount: 5,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: getGrid(),
                                                crossAxisSpacing: 20.0,
                                                mainAxisSpacing: 20.0,
                                                childAspectRatio: 0.9),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: waitingWidget(
                                                width, height, index),
                                          );
                                        },
                                      );
                                    }
                                    if (snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data!.docs.length > 0) {
                                      int count = snapshot.data!.docs.length;
                                      return GridView.builder(
                                        itemCount: count,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: getGrid(),
                                                crossAxisSpacing: 20.0,
                                                mainAxisSpacing: 20.0,
                                                childAspectRatio: 0.9),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          UserPropertyF up =
                                              UserPropertyF.fromDocument(
                                                  snapshot.data!.docs[index]);
                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('PROPERTY REPO')
                                                  .doc(up.plot_no)
                                                  .snapshots(),
                                              builder: (context, p_snapshot) {
                                                if (p_snapshot.hasData &&
                                                    p_snapshot.data != null &&
                                                    p_snapshot.data!.exists) {
                                                  PropertyF property =
                                                      PropertyF.fromDocument(
                                                          p_snapshot.data!);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      width: width,
                                                      height: height,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius:
                                                                    1.5),
                                                          ]),
                                                      child: Stack(
                                                        children: [
                                                          SizedBox(
                                                            width: width,
                                                            height: height,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            width,
                                                                        height:
                                                                            height,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          image: DecorationImage(
                                                                              image: NetworkImage(
                                                                                property.featured_img,
                                                                              ),
                                                                              fit: BoxFit.cover),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Colors.grey,
                                                                                offset: Offset(0, 0),
                                                                                blurRadius: 1.5),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 120,
                                                                  width: width,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            20,
                                                                            10,
                                                                            10,
                                                                            10),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          viewProperty =
                                                                              true;
                                                                          selected_property =
                                                                              property;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            property.title,
                                                                            maxLines:
                                                                                2,
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: black),
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "₦${property.amount}",
                                                                                style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  Text(
                                                                                    "${property.size} m²",
                                                                                    style: TextStyle(fontSize: 12, color: Colors.black),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.bedroom_parent,
                                                                                    size: 15,
                                                                                  ),
                                                                                  Text(
                                                                                    "${property.bedrooms}",
                                                                                    style: TextStyle(fontSize: 14),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.kitchen,
                                                                                    size: 15,
                                                                                  ),
                                                                                  Text(
                                                                                    "${property.kitchen}",
                                                                                    style: TextStyle(fontSize: 14),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.bathroom,
                                                                                    size: 15,
                                                                                  ),
                                                                                  Text(
                                                                                    "${property.bathroom}",
                                                                                    style: TextStyle(fontSize: 14),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 10,
                                                            child: SizedBox(
                                                              height: 170,
                                                              width: width,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            gradient: property.status ==
                                                                                    'For Sale'
                                                                                ? LinearGradient(colors: [
                                                                                    sys_green,
                                                                                    sys_green,
                                                                                    tp1sys_green,
                                                                                    tp1sys_green,
                                                                                    tp1sys_green
                                                                                  ])
                                                                                : LinearGradient(colors: [
                                                                                    Colors.blue,
                                                                                    Colors.blue,
                                                                                    Colors.blue,
                                                                                    Color.fromARGB(226, 33, 149, 243),
                                                                                    Color.fromARGB(226, 33, 149, 243),
                                                                                  ])),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        property
                                                                            .status,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 3,
                                                                    height: 130,
                                                                    color: property.status ==
                                                                            'For Sale'
                                                                        ? sys_green
                                                                        : Colors
                                                                            .blue,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox();
                                                }
                                              });
                                        },
                                      );
                                    } else {
                                      return noneWidget();
                                    }
                                  },
                                )
                              : SizedBox(
                                  child: ViewRepo(width, height, ''),
                                )),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  ViewRepo(double width, double height, String s) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                      color: sys_green,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        setState(() {
                          viewProperty = false;
                          selected_property = null;
                        });
                      });
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        label: Text('Edit')),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.archive),
                        label: Text('Archive'))
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: (selected_property != null)
                ? SizedBox(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: width,
                          height: height,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 20, 10, 0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: sys_green,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        selected_property!.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: width,
                                    height: 450,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.browse_gallery,
                                                    size: 22,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        ' Gallary',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                        Expanded(
                                          child: SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Container(
                                                              width: width,
                                                              height: height,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                image:
                                                                    DecorationImage(
                                                                        image:
                                                                            NetworkImage(
                                                                          selected_property!
                                                                              .featured_img,
                                                                        ),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      blurRadius:
                                                                          2),
                                                                ],
                                                              ),
                                                            ),
                                                          ))),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                      flex: 4,
                                                      child: SizedBox(
                                                        width: width,
                                                        height: height,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                                child: SizedBox(
                                                              width: width,
                                                              height: height,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          height,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(
                                                                              selected_property!.images[0],
                                                                            ),
                                                                            fit: BoxFit.cover),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              offset: Offset(0, 0),
                                                                              blurRadius: 2),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          height,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(
                                                                              selected_property!.images[1],
                                                                            ),
                                                                            fit: BoxFit.cover),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              offset: Offset(0, 0),
                                                                              blurRadius: 2),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                                ],
                                                              ),
                                                            )),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Expanded(
                                                                child: SizedBox(
                                                              width: width,
                                                              height: height,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          height,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(
                                                                              selected_property!.images[2],
                                                                            ),
                                                                            fit: BoxFit.cover),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              offset: Offset(0, 0),
                                                                              blurRadius: 2),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          height,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              offset: Offset(0, 0),
                                                                              blurRadius: 2),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            TextButton(
                                                                          onPressed:
                                                                              () {},
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                '+ ${selected_property!.images.length - 3} Photos ',
                                                                                style: TextStyle(
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  letterSpacing: 1,
                                                                                  color: Colors.black54,
                                                                                ),
                                                                              ),
                                                                              Icon(Icons.chevron_right)
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                                ],
                                                              ),
                                                            )),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: width,
                                    height: 500,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 6,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Details',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 100,
                                                      width: width,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Card(
                                                            child: SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .bedroom_parent,
                                                                      size: 25,
                                                                    ),
                                                                    Text(
                                                                      "${selected_property!.bedrooms} Bedrooms",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            child: SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .bathroom,
                                                                      size: 25,
                                                                    ),
                                                                    Text(
                                                                      "${selected_property!.bathroom} Bathrooms",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            child: SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .kitchen,
                                                                      size: 25,
                                                                    ),
                                                                    Text(
                                                                      "${selected_property!.kitchen} Kitchen",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            child: SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .square_foot,
                                                                      size: 25,
                                                                    ),
                                                                    Text(
                                                                      "${selected_property!.size} m²",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Linkable(
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        letterSpacing: 1,
                                                        color: Colors.black54,
                                                      ),
                                                      text: selected_property!
                                                          .description,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Estate Amenities',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing: 1,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Card(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(Icons
                                                                          .local_hospital),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          '24/7 Health care\nsupport')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .local_police,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          '24/7 Security service')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .electric_meter_rounded,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          '24/7 Power supply')
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 4,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: width,
                                                      height: height,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Container(
                                                          width: width,
                                                          height: height,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  blurRadius:
                                                                      2),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                SizedBox(
                                                                  height: 70,
                                                                  width: width,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left:
                                                                            10,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              70,
                                                                          width:
                                                                              width,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: SizedBox(
                                                                                  width: width,
                                                                                  height: height,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: width,
                                                                                height: 2,
                                                                                color: selected_property!.status == 'For Sale' ? sys_green : Colors.blue,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        bottom:
                                                                            0,
                                                                        left:
                                                                            10,
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              70,
                                                                          width:
                                                                              width,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
                                                                                height: 20,
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                        gradient: selected_property!.status ==
                                                                                                'For Sale'
                                                                                            ? LinearGradient(colors: [
                                                                                                sys_green,
                                                                                                sys_green,
                                                                                                tp1sys_green,
                                                                                                tp1sys_green,
                                                                                                tp1sys_green
                                                                                              ])
                                                                                            : LinearGradient(colors: [
                                                                                                Colors.blue,
                                                                                                Colors.blue,
                                                                                                Colors.blue,
                                                                                                Color.fromARGB(226, 33, 149, 243),
                                                                                                Color.fromARGB(226, 33, 149, 243),
                                                                                              ])),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    selected_property!.status,
                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 2,
                                                                                height: 50,
                                                                                color: selected_property!.status == 'For Sale' ? sys_green : Colors.blue,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              Text(
                                                                            "₦${selected_property!.amount}",
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Property Handler'),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width,
                                                                      height:
                                                                          130,
                                                                      child: selected_property!
                                                                              .property_handler
                                                                              .isNotEmpty
                                                                          ? FutureBuilder<DocumentSnapshot>(
                                                                              future: FirebaseFirestore.instance.collection('USERS').doc(selected_property!.property_handler).get(),
                                                                              builder: (context, user_snapshot) {
                                                                                if (user_snapshot.connectionState == ConnectionState.none) {
                                                                                  return userWview(width);
                                                                                }
                                                                                if (user_snapshot.connectionState == ConnectionState.waiting) {
                                                                                  return userWview(width);
                                                                                }
                                                                                if (user_snapshot.hasData && user_snapshot.data != null && user_snapshot.data!.exists) {
                                                                                  UserF handler = UserF.fromDocument(user_snapshot.data!);

                                                                                  return Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: width,
                                                                                        height: 50,
                                                                                        child: TextButton(
                                                                                          onPressed: () {
                                                                                            setState(() {
                                                                                              sel_user = handler;
                                                                                              show_chat = true;
                                                                                            });
                                                                                          },
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 50,
                                                                                                height: 50,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: white,
                                                                                                  shape: BoxShape.circle,
                                                                                                  image: DecorationImage(image: NetworkImage(handler.profile_pic), fit: BoxFit.cover),
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 5,
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: SizedBox(
                                                                                                  width: width,
                                                                                                  height: 50,
                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        handler.full_name,
                                                                                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: 5,
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            handler.status,
                                                                                                            style: TextStyle(fontSize: 13, color: Colors.grey),
                                                                                                          ),
                                                                                                          SizedBox(width: 5),
                                                                                                          (handler.is_verified) ? Icon(Icons.verified, size: 15, color: sys_green) : SizedBox()
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              IconButton(
                                                                                                onPressed: () {
                                                                                                  //callUrl(handler.phone_number);
                                                                                                },
                                                                                                icon: Icon(
                                                                                                  Icons.call,
                                                                                                  color: sys_green,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 90,
                                                                                        child: Card(
                                                                                          color: sys_green,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                            child: Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                sys_constants.ratingValue(handler.rate, handler.is_verified),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Container(
                                                                                        width: width,
                                                                                        height: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          color: selected_property!.status == 'For Sale' ? sys_green : Colors.blue,
                                                                                          boxShadow: [
                                                                                            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 0),
                                                                                          ],
                                                                                        ),
                                                                                        child: TextButton(
                                                                                          onPressed: () {
                                                                                            proceedFurther(handler);
                                                                                          },
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            'Proceed further',
                                                                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: white),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                } else {
                                                                                  return userWview(width);
                                                                                }
                                                                              })
                                                                          : Column(children: [
                                                                              SizedBox(
                                                                                width: width,
                                                                                height: 50,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                      decoration: BoxDecoration(
                                                                                        color: white,
                                                                                        shape: BoxShape.circle,
                                                                                        boxShadow: [
                                                                                          BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2),
                                                                                        ],
                                                                                      ),
                                                                                      child: Center(child: Icon(Icons.person, size: 50, color: sys_green)),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: SizedBox(
                                                                                        width: width,
                                                                                        height: 50,
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              'Handler not assign',
                                                                                              style: TextStyle(
                                                                                                fontSize: 16,
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                Text(
                                                                                                  'hanler have\'nt been assign yet',
                                                                                                  style: TextStyle(fontSize: 13, color: Colors.grey),
                                                                                                ),
                                                                                                SizedBox(width: 5),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    IconButton(
                                                                                      onPressed: () {
                                                                                        //supportAgemt();
                                                                                      },
                                                                                      icon: Icon(
                                                                                        Icons.real_estate_agent,
                                                                                        color: sys_green,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 110,
                                                                                child: Card(
                                                                                  color: sys_green,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Handler',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ]),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      width: width,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset:
                                                                  Offset(0, 0),
                                                              blurRadius: 2),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                'Property Possession'),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            SizedBox(
                                                              width: width,
                                                              height: 75,
                                                              child: selected_property!
                                                                      .property_owner
                                                                      .isNotEmpty
                                                                  ? FutureBuilder<
                                                                          DocumentSnapshot>(
                                                                      future: FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'USERS')
                                                                          .doc(selected_property!
                                                                              .property_owner)
                                                                          .get(),
                                                                      builder:
                                                                          (context,
                                                                              user_snapshot) {
                                                                        if (user_snapshot.connectionState ==
                                                                            ConnectionState.none) {
                                                                          return userWview(
                                                                              width);
                                                                        }
                                                                        if (user_snapshot.connectionState ==
                                                                            ConnectionState.waiting) {
                                                                          return userWview(
                                                                              width);
                                                                        }
                                                                        if (user_snapshot.hasData &&
                                                                            user_snapshot.data !=
                                                                                null &&
                                                                            user_snapshot.data!.exists) {
                                                                          UserF
                                                                              handler =
                                                                              UserF.fromDocument(user_snapshot.data!);

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
                                                                                      decoration: BoxDecoration(
                                                                                        color: white,
                                                                                        shape: BoxShape.circle,
                                                                                        image: DecorationImage(image: NetworkImage(handler.profile_pic), fit: BoxFit.cover),
                                                                                        boxShadow: [
                                                                                          BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: SizedBox(
                                                                                        width: width,
                                                                                        height: 50,
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              handler.full_name,
                                                                                              style: TextStyle(
                                                                                                fontSize: 16,
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            Row(
                                                                                              children: [
                                                                                                Text(
                                                                                                  handler.status,
                                                                                                  style: TextStyle(fontSize: 13, color: Colors.grey),
                                                                                                ),
                                                                                                SizedBox(width: 5),
                                                                                                (handler.is_verified) ? Icon(Icons.verified, size: 15, color: sys_green) : SizedBox()
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    IconButton(
                                                                                      onPressed: () {
                                                                                        //callUrl(handler.phone_number);
                                                                                      },
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
                                                                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        sys_constants.ratingValue(handler.rate, handler.is_verified),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          );
                                                                        } else {
                                                                          return userWview(
                                                                              width);
                                                                        }
                                                                      })
                                                                  : Column(
                                                                      children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(width: 50, height: 50, child: sys_constants.imgHolder(50, ubairgo_blue)),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Expanded(
                                                                                  child: SizedBox(
                                                                                    width: width,
                                                                                    height: 50,
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Ubairgo Real Estate',
                                                                                          style: TextStyle(
                                                                                            fontSize: 16,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 5,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              'in possession of the estate',
                                                                                              style: TextStyle(fontSize: 13, color: Colors.grey),
                                                                                            ),
                                                                                            SizedBox(width: 5),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    // supportAgemt();
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.support_agent,
                                                                                    color: sys_green,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 110,
                                                                                child: Card(
                                                                                  color: sys_green,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Ubairgo RE',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ]),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        show_chat && sel_user != null
                            ? Positioned(
                                top: 100,
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: 500,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 2),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                show_chat = false;
                                                sel_user = null;
                                              });
                                            },
                                            icon: Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: width,
                                          height: height,
                                          child: ChatWidgetF(
                                            is_back: false,
                                            user_model: sel_user!,
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  )
                : SizedBox(
                    width: width,
                    height: height,
                  ),
          )
        ],
      ),
    );
  }

  Column noneWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: sys_constants.imgHolder(250, houses_amico),
        )
      ],
    );
  }

  Container waitingWidget(double width, double height, int index) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, offset: Offset(0, 0), blurRadius: 1.5),
          ]),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.grey.shade100,
                            child: Text(
                              '                                        ',
                              maxLines: 2,
                              style: TextStyle(fontSize: 14, color: black),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.grey.shade100,
                                child: Text(
                                  '                              ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    color: Colors.grey.shade100,
                                    child: Text(
                                      '          ',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            child: SizedBox(
              height: 170,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                  ),
                  Container(width: 3, height: 130, color: Colors.grey.shade200)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
