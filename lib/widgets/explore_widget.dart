// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkable/linkable.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/chat_full_screen.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:ubairgo/widgets/chat_screenf.dart';
import 'package:uuid/uuid.dart';
import '../functions/sys_constants.dart';
import '../model/house_model.dart';
import '../screens/splash.dart';
import '../styles/colors.dart';

class ExploreWidget extends StatefulWidget {
  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  SysConstants sys_constants = SysConstants();

  List<String> sel_category = ['All'];

  var sel_Locality = 'Abuja';

  List<String> list_locality = [
    'Abuja',
    'Lagos',
    'Kaduna',
    'Kano',
  ];

  var sel_sub_locality = 'Gwarimpa';

  List<String> list_sub_locality = [
    'Gwarimpa',
    'Katempe Extension',
    'Aso Drive',
  ];
  int simpleIntInput = 0;

  var search_textfield;

  var amount;

  bool show_filter = false;

  bool viewProperty = false;

  HouseModel? sel_property;

  PropertyF? selected_property;

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    exploreTop(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                          color: sys_green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        filterButton(),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: housesGridView(context, width, height, 1),
                  ),
                ),
              )
            ],
          ),
        ),
        tablet: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      exploreTop(),
                      Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: sys_green,
                                borderRadius: BorderRadius.circular(50)),
                            child: TextButton(
                              onPressed: () {},
                              child: Icon(
                                Icons.search,
                                color: white,
                              ),
                            ),
                          ),
                          SizedBox(
                            //UBAIRGO8042823
                            width: 10,
                          ),
                          filterButton()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: housesGridView(context, width, height, 2),
                  ),
                ),
              )
            ],
          ),
        ),
        largeTablet: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: width,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        exploreTop(),
                        Row(
                          children: [
                            searchBar(height, 350),
                            SizedBox(
                              width: 10,
                            ),
                            filterButton()
                          ],
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: housesGridView(context, width, height, 3),
                  ),
                ),
              )
            ],
          ),
        ),
        computer: SizedBox(
          width: width,
          height: height,
          child: !viewProperty && selected_property == null
              ? Stack(
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width,
                              height: 65,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    exploreTop(),
                                    Row(children: [
                                      searchBar(height, 450),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      filterButton()
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child:
                                    housesGridView(context, width, height, 4),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    show_filter
                        ? Positioned(
                            right: 10,
                            top: 10,
                            bottom: 10,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 70, 10, 10),
                              child: sortWidget(height, width, context),
                            ),
                          )
                        : SizedBox()
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: ViewRepo(width, height, 'Computer')),
        ),
      ),
    );
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
  UserF? sel_user;

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

  Container sortWidget(double height, double width, BuildContext context) {
    return Container(
      width: 350,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Filter Search',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        show_filter = false;
                      });
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: sel_category.contains('All')
                                        ? sys_green
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 1)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      if (sel_category.contains('All')) {
                                        setState(() {
                                          sel_category.remove('All');
                                        });
                                      } else {
                                        setState(() {
                                          sel_category.clear();
                                          sel_category.add('All');
                                        });
                                      }
                                    },
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                          color: sel_category.contains('All')
                                              ? white
                                              : Colors.black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: sel_category.contains('For Lease')
                                          ? sys_green
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 0),
                                            blurRadius: 1)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {
                                        if (sel_category
                                            .contains('For Lease')) {
                                          setState(() {
                                            sel_category.remove('For Lease');
                                          });
                                        } else {
                                          setState(() {
                                            sel_category.remove('All');
                                            sel_category.add('For Lease');
                                          });
                                        }
                                      },
                                      child: Text(
                                        'For Lease',
                                        style: TextStyle(
                                            color: sel_category
                                                    .contains('For Lease')
                                                ? white
                                                : Colors.black,
                                            fontSize: 14),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: sel_category.contains('For Sale')
                                        ? sys_green
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 1)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      if (sel_category.contains('For Sale')) {
                                        setState(() {
                                          sel_category.remove('For Sale');
                                        });
                                      } else {
                                        setState(() {
                                          sel_category.remove('All');
                                          sel_category.add('For Sale');
                                        });
                                      }
                                    },
                                    child: Text(
                                      'For Sale',
                                      style: TextStyle(
                                          color:
                                              sel_category.contains('For Sale')
                                                  ? white
                                                  : Colors.black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: sel_category.contains('For Rent')
                                        ? sys_green
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 1)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      if (sel_category.contains('For Rent')) {
                                        setState(() {
                                          sel_category.remove('For Rent');
                                        });
                                      } else {
                                        sel_category.remove('All');
                                        setState(() {
                                          sel_category.add('For Rent');
                                        });
                                      }
                                    },
                                    child: Text(
                                      'For Rent',
                                      style: TextStyle(
                                          color:
                                              sel_category.contains('For Rent')
                                                  ? white
                                                  : Colors.black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        offset: Offset(0, 0),
                                        blurRadius: 5),
                                  ],
                                ),
                                height: 75,
                                width: 250,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Locality',
                                      labelStyle: Theme.of(context)
                                          .primaryTextTheme
                                          .caption!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                      border: const OutlineInputBorder(),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.pin_drop),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 75,
                                            width: 250,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 75,
                                                width: 250,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    dropdownColor: Colors.white,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                    isExpanded: true,
                                                    isDense:
                                                        true, // Reduces the dropdowns height by +/- 50%
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.black,
                                                    ),
                                                    value: sel_Locality,
                                                    items: list_locality
                                                        .map((item) {
                                                      return DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                    onChanged: (selectedItem) =>
                                                        setState(
                                                      () => {
                                                        sel_Locality =
                                                            selectedItem
                                                                .toString()
                                                      },
                                                    ),
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
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        offset: Offset(0, 0),
                                        blurRadius: 5),
                                  ],
                                ),
                                height: 75,
                                width: 300,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Sub Locality',
                                      labelStyle: Theme.of(context)
                                          .primaryTextTheme
                                          .caption!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                      border: const OutlineInputBorder(),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.location_on),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 75,
                                            width: width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 75,
                                                width: width,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    dropdownColor: Colors.white,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                    isExpanded: true,
                                                    isDense:
                                                        true, // Reduces the dropdowns height by +/- 50%
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.black,
                                                    ),
                                                    value: sel_sub_locality,
                                                    items: list_sub_locality
                                                        .map((item) {
                                                      return DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                    onChanged: (selectedItem) =>
                                                        setState(
                                                      () => {
                                                        sel_sub_locality =
                                                            selectedItem
                                                                .toString()
                                                      },
                                                    ),
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
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 5, 15),
                                child: Container(
                                  width: 150,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400,
                                          offset: Offset(0, 0),
                                          blurRadius: 5),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            child: Container(
                                              height: height,
                                              width: width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: TextField(
                                                  controller: amount,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration: InputDecoration(
                                                    prefix: Text(
                                                      '₦ ',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Min Price',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black45),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 5, 15),
                                child: Container(
                                  width: 150,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400,
                                          offset: Offset(0, 0),
                                          blurRadius: 5),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            child: Container(
                                              height: height,
                                              width: width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: TextField(
                                                  controller: amount,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  decoration: InputDecoration(
                                                    prefix: Text(
                                                      '₦ ',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'Max Price',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black45),
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
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Container(
                          width: width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: sys_green,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    show_filter = false;
                                  });
                                },
                                child: Text(
                                  'Search',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  IconButton filterButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          show_filter = true;
        });
      },
      icon: Icon(Icons.sort),
    );
  }

  Container searchBar(double height, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400, offset: Offset(0, 0), blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: height,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextField(
                    controller: search_textfield,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                    color: sys_green, borderRadius: BorderRadius.circular(50)),
                child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.search,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row exploreTop() {
    return Row(
      children: [
        Icon(
          Icons.explore,
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
              'Explore',
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
    );
  }

  Widget housesGridView(
      BuildContext context, double width, double height, int grid) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('PROPERTY REPO')
            .orderBy('date_reg', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return noneWidget();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.9),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: waitingWidget(width, height, index),
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.9),
              itemBuilder: (BuildContext context, int index) {
                PropertyF property =
                    PropertyF.fromDocument(snapshot.data!.docs[index]);
                return Padding(
                  padding: const EdgeInsets.all(10.0),
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
                              blurRadius: 1.5),
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
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              property.featured_img,
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10),
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
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        viewProperty = true;
                                        selected_property = property;
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          property.title,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14, color: black),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₦${property.amount}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${property.size} m²",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
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
                                                  style:
                                                      TextStyle(fontSize: 14),
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
                                                  style:
                                                      TextStyle(fontSize: 14),
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
                                                  style:
                                                      TextStyle(fontSize: 14),
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
                                  decoration: BoxDecoration(
                                      gradient: property.status == 'For Sale'
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
                                      property.status,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 3,
                                  height: 130,
                                  color: property.status == 'For Sale'
                                      ? sys_green
                                      : Colors.blue,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return noneWidget();
          }
        });
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
