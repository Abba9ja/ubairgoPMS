// ignore_for_file: unused_field

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkable/linkable.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/widgets/handler_review.dart';
import 'package:ubairgo/widgets/request_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/shims/dart_ui_real.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../functions/sys_constants.dart';
import '../model/property_requestm.dart';
import '../model/user_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';

class PropertyRepo extends StatefulWidget {
  @override
  State<PropertyRepo> createState() => _PropertyRepoState();
}

class _PropertyRepoState extends State<PropertyRepo> {
  SysConstants sys_constants = SysConstants();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  int sel_index = 0;

  var search_textfield;

  bool show_filter = false;

  bool show_add_repo = false;

  int add_index = 0;

  bool view_property = false;

  PropertyF? selected_property;

  TextEditingController extra_note_request = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveLayout(
      tiny: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [],
        ),
      ),
      phone: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [],
        ),
      ),
      tablet: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [],
        ),
      ),
      largeTablet: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [],
        ),
      ),
      computer: SizedBox(
          width: width,
          height: height,
          child: propertyDisplaySwitch(width, height, 'Computer', context)),
    );
  }

  final _formKey = GlobalKey<FormState>();

  final List<String> typeItems = [
    'Premuim Bungalow',
    'Bungalow',
    'Premuim Duplex',
    'Duplex',
    'Premuim Terrace',
    'Terrace',
    'Premuim Semi-Detacherd',
    'Semi-Detacherd'
  ];

  String sel_type = '';

  final List<String> statusItems = [
    'For Sale',
    'For Rent',
    'For Lease',
    'Occupied-T',
    'Occupied-O',
  ];

  String sel_status = '';

  TextEditingController plot_no = TextEditingController();
  TextEditingController h_lat = TextEditingController();
  TextEditingController h_long = TextEditingController();
  TextEditingController plot_size = TextEditingController();
  TextEditingController extra_note = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController plot_amount = TextEditingController();

  bool show_map = false;
  bool add_handler = false;
  bool show_user = false;
  int add_switch_index = 0;
  String add_user_status = '';

  UserF? propertyOwner;
  String propertyOwnerEmail = '';

  UserF? propertyHandle;
  String propertyHandleEmail = '';

  List<UserF> propertyTenant = [];
  List<String> propertyTenantEmails = [];

  var fb_users_query = FirebaseFirestore.instance
      .collection('USERS')
      .where('user_status', isEqualTo: 'active')
      .snapshots();

  Widget userWaiting() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: sys_constants.imgHolder(200, loading),
        )
      ],
    );
  }

  Widget userNone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: sys_constants.imgHolder(200,
              add_user_status == 'Handler' ? realtor_pana : realtor_rafiki),
        )
      ],
    );
  }

  Color getRandomColor(String s) {
    //int ran = random.nextInt(5);
    if (s.toUpperCase() == 'Estate Support') {
      return Colors.blue;
    } else if (s.toUpperCase() == 'Emergency Support') {
      return Colors.teal;
    } else {
      return sys_green;
    }
  }

  Widget AddRepo(double width, double height, String s) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
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
                          show_add_repo = false;
                        });
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 0, 10, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.add_home,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add Property',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 2),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: width,
                              height: height,
                              color: add_index == 0 ? sys_green : white,
                              child: Center(
                                  child: Text(
                                'Details',
                                style: TextStyle(
                                  color: add_index == 0 ? white : Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: width,
                              height: height,
                              color: add_index == 1 ? sys_green : white,
                              child: Center(
                                  child: Text(
                                'Gallary',
                                style: TextStyle(
                                  color: add_index == 1 ? white : Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: width,
                              height: height,
                              color: add_index == 2 ? sys_green : white,
                              child: Center(
                                  child: Text(
                                'Verify',
                                style: TextStyle(
                                  color: add_index == 2 ? white : Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
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
          ],
        ),
        Expanded(
          child: Container(
            width: show_user ? width * 0.4 : width * 0.6,
            height: height,
            child: show_user
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width * 0.4,
                        height: 50,
                        child: Row(children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                show_user = false;
                              });
                            },
                            icon: Icon(Icons.chevron_left),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: SizedBox(
                                width: width * 0.4,
                                height: 50,
                                child: userSearchBar(height, width * 0.4)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          usrFilterButton()
                        ]),
                      ),
                      Expanded(
                        child: Container(
                            width: width,
                            height: height,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: fb_users_query,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.none) {
                                    return userNone();
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return userWaiting();
                                  }
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.length > 0) {
                                    return SizedBox(
                                      width: width,
                                      height: height,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: width,
                                            height: height,
                                            child: ListView.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  UserF registry =
                                                      UserF.fromDocument(
                                                          snapshot.data!
                                                              .docs[index]);
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        80, 10, 80, 5),
                                                    child: SizedBox(
                                                      width: width,
                                                      height: 70,
                                                      child: Card(
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: SizedBox(
                                                                width: width,
                                                                height: 65,
                                                                child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: registry.profile_pic.isEmpty
                                                                              ? getRandomColor(registry.sys_status)
                                                                              : Colors.white,
                                                                          image: DecorationImage(
                                                                              image: NetworkImage(registry.profile_pic),
                                                                              fit: BoxFit.cover),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Colors.grey,
                                                                                offset: Offset(0, 0),
                                                                                blurRadius: 1),
                                                                          ],
                                                                        ),
                                                                        child: registry.profile_pic.isEmpty
                                                                            ? Center(
                                                                                child: Text(
                                                                                  registry.full_name.split(' ')[0].split('')[0],
                                                                                  style: TextStyle(fontSize: 25, color: white, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              )
                                                                            : SizedBox(),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              width,
                                                                          height:
                                                                              height,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                registry.full_name,
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                maxLines: 1,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 1,
                                                                              ),
                                                                              Text(
                                                                                registry.status.toUpperCase(),
                                                                                style: TextStyle(
                                                                                  color: Colors.grey,
                                                                                  fontSize: 14,
                                                                                ),
                                                                                maxLines: 1,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 2,
                                                              top: 2,
                                                              child: SizedBox(
                                                                  width: 30,
                                                                  height: 30,
                                                                  child:
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (add_user_status ==
                                                                                'Property Owner') {
                                                                              setState(() {
                                                                                propertyOwner = registry;
                                                                                propertyOwnerEmail = registry.email_address;
                                                                              });
                                                                            }
                                                                            if (add_user_status ==
                                                                                'Property Handler') {
                                                                              setState(() {
                                                                                propertyHandle = registry;
                                                                                propertyHandleEmail = registry.email_address;
                                                                              });
                                                                            }
                                                                            if (add_user_status ==
                                                                                'Property Tenants') {
                                                                              if (propertyTenantEmails.contains(registry.email_address)) {
                                                                                setState(() {
                                                                                  propertyTenant.remove(propertyTenant[propertyTenantEmails.indexOf(registry.email_address)]);
                                                                                  propertyTenantEmails.remove(registry.email_address);
                                                                                });
                                                                              } else {
                                                                                setState(() {
                                                                                  propertyTenant.add(registry);
                                                                                  propertyTenantEmails.add(registry.email_address);
                                                                                });
                                                                              }
                                                                            }
                                                                          },
                                                                          child:
                                                                              getIconCheck(registry))),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          ((add_user_status ==
                                                          'Property Tenants' &&
                                                      propertyTenant
                                                          .isNotEmpty) ||
                                                  (add_user_status ==
                                                          'Property Owner' &&
                                                      propertyOwner != null) ||
                                                  (add_user_status ==
                                                          'Property Handler' &&
                                                      propertyHandle != null))
                                              ? Positioned(
                                                  right: 10,
                                                  bottom: 20,
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: sys_green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          show_user = false;
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.done,
                                                        color: white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return userNone();
                                  }
                                })

                            /*Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: sys_constants.imgHolder(width, add_user_status=='realtor'?realtor_pana: realtor_rafiki),
                              )
                            ],
                          ),*/
                            ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        switchState(width, height),
                      ],
                    ),
                  ),
          ),
        )
      ],
    );
  }

  Widget getIconCheck(UserF registry) {
    if ((add_user_status == 'Property Owner' &&
        propertyOwner != null &&
        propertyOwnerEmail == registry.email_address)) {
      return Icon(
        Icons.radio_button_checked,
        color: sys_green,
      );
    } else if ((add_user_status == 'Property Handler' &&
        propertyHandle != null &&
        propertyHandleEmail == registry.email_address)) {
      return Icon(
        Icons.radio_button_checked,
        color: sys_green,
      );
    } else if ((add_user_status == 'Property Tenants' &&
        propertyTenant.isNotEmpty &&
        propertyTenantEmails.contains(registry.email_address))) {
      return Icon(
        Icons.check_box,
        color: sys_green,
      );
    } else if (add_user_status == 'Property Tenants') {
      return Icon(
        Icons.check_box_outline_blank,
        color: Colors.grey,
      );
    } else {
      return Icon(
        Icons.radio_button_off,
        color: Colors.grey,
      );
    }
  }

  getColor(UserF registry) {}

  IconButton usrFilterButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          show_filter = true;
        });
      },
      icon: Icon(Icons.sort),
    );
  }

  Container userSearchBar(double height, double width) {
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
                    Icons.person_search,
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
                          view_property = false;
                          selected_property = null;
                          _property_view = '';
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 10, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  ' Gallary',
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 0, 0),
                                                      child: Container(
                                                        width: width,
                                                        height: height,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
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
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    0, 0),
                                                                blurRadius: 2),
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
                                                                child: SizedBox(
                                                              width: width,
                                                              height: height,
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
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                        selected_property!
                                                                            .images[0],
                                                                      ),
                                                                      fit: BoxFit.cover),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            2),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                                child: SizedBox(
                                                              width: width,
                                                              height: height,
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
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                        selected_property!
                                                                            .images[1],
                                                                      ),
                                                                      fit: BoxFit.cover),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            2),
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
                                                                child: SizedBox(
                                                              width: width,
                                                              height: height,
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
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                        selected_property!
                                                                            .images[2],
                                                                      ),
                                                                      fit: BoxFit.cover),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            2),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                                child: SizedBox(
                                                              width: width,
                                                              height: height,
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
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            2),
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          '+ ${selected_property!.images.length - 3} Photos ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            letterSpacing:
                                                                                1,
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                        Icon(Icons
                                                                            .chevron_right)
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
                              height: 700,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 6,
                                      child: SizedBox(
                                        width: width,
                                        height: height,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
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
                                                  fontWeight: FontWeight.bold,
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
                                                                  5, 0, 5, 0),
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
                                                                  fontSize: 16,
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
                                                                  5, 0, 5, 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Icon(
                                                                Icons.bathroom,
                                                                size: 25,
                                                              ),
                                                              Text(
                                                                "${selected_property!.bathroom} Bathrooms",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
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
                                                                  5, 0, 5, 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Icon(
                                                                Icons.kitchen,
                                                                size: 25,
                                                              ),
                                                              Text(
                                                                "${selected_property!.kitchen} Kitchen",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
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
                                                                  5, 0, 5, 0),
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
                                                                  fontSize: 14,
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
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Estate Amenities',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1,
                                                        color: Colors.black54,
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
                                                                    .all(10.0),
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .local_hospital),
                                                                SizedBox(
                                                                  height: 10,
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
                                                                    .all(10.0),
                                                            child: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .local_police,
                                                                  size: 30,
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
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
                                                                    .all(10.0),
                                                            child: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .electric_meter_rounded,
                                                                  size: 30,
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
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
                                            (_property_view.isNotEmpty)
                                                ? SizedBox(
                                                    width: width,
                                                    height: 350,
                                                    child: RequestWidget(
                                                      propertyF:
                                                          selected_property,
                                                      propertyRequestF:
                                                          _propertyRequestF,
                                                    ))
                                                : SizedBox(),
                                            Expanded(
                                              child: SizedBox(
                                                width: width,
                                                height: height,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Container(
                                                    width: width,
                                                    height: height,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(0, 0),
                                                            blurRadius: 2),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Expanded(
                                                        child: SizedBox(
                                                          width: width,
                                                          height: height,
                                                          child: HandlerReviewWidget(
                                                              propertyF:
                                                                  selected_property!,
                                                              view_from:
                                                                  _property_view),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (_property_view.isEmpty)
                                                ? ownershipWidget(width)
                                                : SizedBox(),
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

  Padding ownershipWidget(double width) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('OWNERSHIP'),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: width,
                height: 75,
                child: selected_property!.property_owner.isNotEmpty
                    ? FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('USERS')
                            .doc(selected_property!.property_owner)
                            .get(),
                        builder: (context, user_snapshot) {
                          if (user_snapshot.connectionState ==
                              ConnectionState.none) {
                            return userWview(width);
                          }
                          if (user_snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return userWview(width);
                          }
                          if (user_snapshot.hasData &&
                              user_snapshot.data != null &&
                              user_snapshot.data!.exists) {
                            UserF handler =
                                UserF.fromDocument(user_snapshot.data!);

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
                                          color: white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  handler.profile_pic),
                                              fit: BoxFit.cover),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    handler.email_address,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(width: 5),
                                                  (handler.is_verified)
                                                      ? Icon(Icons.verified,
                                                          size: 15,
                                                          color: sys_green)
                                                      : SizedBox()
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          callUrl(handler.phone_number);
                                        },
                                        icon: Icon(
                                          Icons.call,
                                          color: sys_green,
                                        ),
                                      ),
                                    ],
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
                                  child: sys_constants.imgHolder(
                                      50, ubairgo_blue)),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: width,
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
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
                                  supportAgemt();
                                },
                                icon: Icon(
                                  Icons.support_agent,
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
                                    'Ubairgo RE',
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

  List<Uint8List> images_filebyte = [];
  List<dynamic> images_filename = [];
  dynamic _pickImageError;
  pickImagesPressed() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: sys_constants.allowedext(),
      );
      if (result != null) {
        List<Uint8List> l_file = result.files.map((e) => e.bytes!).toList();
        List<dynamic> l_filename = result.files.map((e) => e.name).toList();
        setState(() {
          images_filebyte = l_file;
          images_filename = l_filename;
        });
      }
      // ignore: empty_catches
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError.toString());
    }
  }

  Uint8List? featured_filebyte;
  String featured_filename = '';

  pickfeaturedPressed() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: sys_constants.allowedext(),
      );
      if (result != null) {
        final fileBytes = result.files.first.bytes;
        final fileName = result.files.first.name;
        setState(() {
          featured_filebyte = fileBytes;
          featured_filename = fileName;
        });
      }
      // ignore: empty_catches
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      print(_pickImageError.toString());
    }
  }

  bool isregistrying = false;
  Widget switchState(double width, double height) {
    switch (add_index) {
      case 0:
        return detailsWidget(width, height);

      case 1:
        return Column(
          children: [
            SizedBox(
              width: width * 0.5,
              height: 350,
              child: Column(
                children: [
                  featured_filebyte != null
                      ? Row(
                          children: [
                            Card(
                              color: Colors.grey.shade200,
                              child: SizedBox(
                                  height: 320,
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        child: Image.memory(
                                          featured_filebyte!,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Card(
                                            child: TextButton(
                                              onPressed: () {
                                                pickfeaturedPressed();
                                              },
                                              child: Icon(
                                                Icons.add_a_photo,
                                                color: sys_green,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      : Card(
                          color: Colors.grey.shade200,
                          child: SizedBox(
                            width: width * 0.5,
                            height: 320,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      color: Colors.grey.shade300,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Add Featured Image',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'Featured image is the one that is displayed at the first sight of the property  '),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      pickfeaturedPressed();
                                    },
                                    icon: Icon(Icons.add_a_photo),
                                    label: Text('Add'))
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.grey.shade200,
              child: SizedBox(
                width: width * 0.5,
                height: 130,
                child: Row(
                  children: [
                    Card(
                      child: SizedBox(
                        width: 80,
                        height: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Card(
                                  child: SizedBox(
                                      width: 80,
                                      height: 70,
                                      child: Center(
                                        child: Icon(
                                          Icons.image_outlined,
                                          color: Colors.grey.shade200,
                                          size: 40,
                                        ),
                                      )),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          pickImagesPressed();
                                        },
                                        icon: Icon(Icons.add_circle),
                                        label: Text('Add'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: ListView.builder(
                            itemCount: images_filebyte.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: SizedBox(
                                  height: 130,
                                  child: Card(
                                    child: SizedBox(
                                      height: 130,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 130,
                                            child: Image.memory(
                                              images_filebyte[index],
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  images_filebyte.remove(
                                                      images_filebyte[index]);
                                                });
                                              },
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Card(
                                                  child: Icon(
                                                    Icons.close,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: width,
              height: 50,
              child: Row(
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
                            add_index = 1;
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
                    child: Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                          color: sys_green,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            add_index = 2;
                          });
                        },
                        child: Icon(
                          Icons.chevron_right,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );

      case 2:
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width * 0.4,
              height: 450,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: sys_constants.imgHolder(300, done_rifiki),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            color: (plot_no.text.isNotEmpty &&
                                    plot_size.text.isNotEmpty &&
                                    sel_type.isNotEmpty &&
                                    sel_status.isNotEmpty)
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            child: SizedBox(
                              width: 200,
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Property Details',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          color: Colors.black),
                                    ),
                                    Icon(
                                      (plot_no.text.isNotEmpty &&
                                              plot_size.text.isNotEmpty &&
                                              sel_type.isNotEmpty &&
                                              sel_status.isNotEmpty)
                                          ? Icons.check_circle
                                          : Icons.info,
                                      size: 25,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                            child: Card(
                              color: Colors.red.shade100,
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Satellite Details',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.info,
                                        size: 25,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Card(
                              color: (images_filebyte.isNotEmpty)
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Property Gallary',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      Icon(
                                        (images_filebyte.isNotEmpty)
                                            ? Icons.check_circle
                                            : Icons.info,
                                        size: 25,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                            child: Card(
                              color: (featured_filebyte != null)
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Featured Image',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      Icon(
                                        (featured_filebyte != null)
                                            ? Icons.check
                                            : Icons.info,
                                        size: 25,
                                        color: Colors.black,
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
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                        color: sys_green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          add_index = 1;
                        });
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: white,
                      ),
                    ),
                  ),
                ),
                !isregistrying
                    ? ElevatedButton.icon(
                        onPressed: () {
                          registerProperty();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add_home, size: 20),
                        ),
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 100,
                        height: 35,
                        child: Card(
                          color: sys_green,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: LinearProgressIndicator(
                              color: white,
                            ),
                          ),
                        ),
                      ),
              ],
            )
          ],
        );
      default:
        return detailsWidget(width, height);
    }
  }

  bool property_exist = false;
  void propertyCheck(String value) async {
    DocumentSnapshot checkProperty = await FirebaseFirestore.instance
        .collection('PROPERTY REPO')
        .doc(value)
        .get();
    if (!checkProperty.exists) {
      setState(() {
        property_exist = false;
      });
    } else {
      setState(() {
        property_exist = true;
      });
    }
  }

  int bedrooms = 0;
  int bathrooms = 0;
  int palour = 0;
  int kitchen = 0;
  double size = 0.0;

  Widget detailsWidget(double width, double height) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: width,
            height: 85,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.text,
                            controller: plot_no,
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Plot no required';
                              }
                              if (property_exist) {
                                return 'Plot no already exist';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              propertyCheck(value);
                            },
                            onSaved: (value) {
                              propertyCheck(value!);
                            },
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              focusColor: sys_green,
                              prefixIconColor: sys_green,
                              prefixIcon: Icon(
                                Icons.house_outlined,
                                color: sys_green,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: 'Plot no',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width,
                          height: 75,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: const Text(
                                'House type',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: typeItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Type required';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  sel_type = value.toString();
                                });
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                setState(() {
                                  sel_type = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width,
                          height: 75,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: const Text(
                                'House Status',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: statusItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Status required';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  sel_status = value.toString();
                                  if (value.toString() == 'For Sale' ||
                                      value.toString() == 'For Rent' ||
                                      value.toString() == 'For Lease') {
                                    add_handler = true;
                                  }
                                });
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                setState(() {
                                  sel_status = value.toString();
                                  if (value.toString() == 'For Sale' ||
                                      value.toString() == 'For Rent' ||
                                      value.toString() == 'For Lease') {
                                    add_handler = true;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: width,
            height: 85,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.text,
                            controller: plot_size,
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Size required';
                              }
                            },
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              focusColor: sys_green,
                              prefixIconColor: sys_green,
                              prefixIcon: Icon(
                                FontAwesomeIcons.tape,
                                color: sys_green,
                                size: 20,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: 'Size m²',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 180,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.text,
                            controller: plot_amount,
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Amount required';
                              }
                            },
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              focusColor: sys_green,
                              prefixIconColor: sys_green,
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '₦',
                                    style: TextStyle(
                                        color: sys_green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: ' Amount',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 170,
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Palours'),
                        QuantityInput(
                            value: palour,
                            onChanged: (value) => setState(() =>
                                palour = int.parse(value.replaceAll(',', '')))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 170,
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bedrooms'),
                        QuantityInput(
                            value: bedrooms,
                            onChanged: (value) => setState(() => bedrooms =
                                int.parse(value.replaceAll(',', '')))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 170,
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bathrooms'),
                        QuantityInput(
                            value: bathrooms,
                            onChanged: (value) => setState(() => bathrooms =
                                int.parse(value.replaceAll(',', '')))),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 170,
                    height: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kitchen'),
                        QuantityInput(
                            value: kitchen,
                            onChanged: (value) => setState(() => kitchen =
                                int.parse(value.replaceAll(',', '')))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: width,
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.text,
                            controller: address,
                            maxLines: 2,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              focusColor: sys_green,
                              prefixIconColor: sys_green,
                              prefixIcon: Icon(
                                Icons.map,
                                color: sys_green,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: 'Address',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: width,
            height: 120,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.text,
                            controller: extra_note,
                            maxLines: 3,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              focusColor: sys_green,
                              prefixIconColor: sys_green,
                              prefixIcon: Icon(
                                Icons.edit_note,
                                color: sys_green,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: 'Extra note',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          /*  Card(
            child: Container(
              width: width * 0.6,
              height: show_map ? 350 : 100,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                cursorColor: sys_green,
                                keyboardType: TextInputType.text,
                                controller: h_lat,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  focusColor: sys_green,
                                  prefixIconColor: sys_green,
                                  prefixIcon: Icon(
                                    Icons.pin_drop,
                                    color: sys_green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'House Latitude',
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                cursorColor: sys_green,
                                keyboardType: TextInputType.text,
                                controller: h_long,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  focusColor: sys_green,
                                  prefixIconColor: sys_green,
                                  prefixIcon: Icon(
                                    Icons.pin_drop,
                                    color: sys_green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'House Longitude',
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                if (show_map) {
                                  setState(() {
                                    show_map = false;
                                  });
                                } else {
                                  setState(() {
                                    show_map = true;
                                  });
                                }
                              },
                              child: Icon(
                                show_map
                                    ? Icons.close
                                    : FontAwesomeIcons.mapPin,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  show_map
                      ? Expanded(
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: WebView(
                              javascriptMode: JavascriptMode.unrestricted,
                              initialUrl:
                                  "https://www.google.com/maps/@9.125454,7.4264351,54m/data=!3m1!1e3",
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Satellite view ...'),
                        )
                ],
              ),
            ),
          ),*/
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 120,
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 120,
                    width: width,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                          child: propertyOwner == null
                              ? Card(
                                  child: SizedBox(
                                    width: width,
                                    height: 100,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          show_user = true;
                                          add_user_status = 'Property Owner';
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 65,
                                                    height: 65,
                                                    decoration: BoxDecoration(
                                                      color: white,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(0, 0),
                                                            color: Colors.grey,
                                                            blurRadius: 1),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.account_circle,
                                                        size: 65,
                                                        color: sys_green,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: sys_green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 15,
                                                        color: white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 120,
                                              width: width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Add Owner of the property',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'The owner is the lanlord in case if it\'s occupied by tenanats',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
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
                                )
                              : Card(
                                  child: SizedBox(
                                    width: width,
                                    height: 120,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: width,
                                          height: 120,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: propertyOwner!
                                                          .profile_pic.isEmpty
                                                      ? getRandomColor(
                                                          propertyOwner!
                                                              .sys_status)
                                                      : Colors.white,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          propertyOwner!
                                                              .profile_pic),
                                                      fit: BoxFit.cover),
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        offset: Offset(0, 0),
                                                        blurRadius: 1),
                                                  ],
                                                ),
                                                child: propertyOwner!
                                                        .profile_pic.isEmpty
                                                    ? Center(
                                                        child: Text(
                                                          propertyOwner!
                                                              .full_name
                                                              .split(' ')[0]
                                                              .split('')[0],
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              color: white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: width,
                                                  height: height,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        propertyOwner!
                                                            .full_name,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        propertyOwner!.status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Card(
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  propertyOwner = null;
                                                });
                                              },
                                              child: Icon(
                                                Icons.person_remove_outlined,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          top: 0,
                          left: 10,
                          child: Container(
                            color: white,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Property owner'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    width: width,
                    child: sel_status == 'Occupied-T'
                        ? Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 0),
                                child: propertyTenant.isEmpty
                                    ? Card(
                                        child: SizedBox(
                                          width: width,
                                          height: 100,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                show_user = true;
                                                add_user_status =
                                                    'Property Tenants';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 70,
                                                  width: 70,
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width: 65,
                                                          height: 65,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: white,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  color: Colors
                                                                      .grey,
                                                                  blurRadius:
                                                                      1),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .account_circle,
                                                              size: 65,
                                                              color: sys_green,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: sys_green,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 15,
                                                              color: white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 120,
                                                    width: width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Add Tenants of the property',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          'The tenants currently in te property',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
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
                                      )
                                    : Card(
                                        child: SizedBox(
                                          width: width,
                                          height: 120,
                                          child: propertyTenant.length == 1
                                              ? Stack(
                                                  children: [
                                                    SizedBox(
                                                      width: width,
                                                      height: 120,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: propertyTenant[
                                                                          0]
                                                                      .profile_pic
                                                                      .isEmpty
                                                                  ? getRandomColor(
                                                                      propertyTenant[
                                                                              0]
                                                                          .sys_status)
                                                                  : Colors
                                                                      .white,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      propertyTenant[
                                                                              0]
                                                                          .profile_pic),
                                                                  fit: BoxFit
                                                                      .cover),
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
                                                                    blurRadius:
                                                                        1),
                                                              ],
                                                            ),
                                                            child: propertyTenant[
                                                                        0]
                                                                    .profile_pic
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                      propertyTenant[0]
                                                                          .full_name
                                                                          .split(' ')[
                                                                              0]
                                                                          .split(
                                                                              '')[0],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              30,
                                                                          color:
                                                                              white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : SizedBox(),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: width,
                                                              height: height,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    propertyTenant[
                                                                            0]
                                                                        .full_name,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                    maxLines: 1,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                    propertyTenant[
                                                                            0]
                                                                        .status
                                                                        .toUpperCase(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                    maxLines: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Card(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              propertyTenant
                                                                  .clear();
                                                              propertyTenantEmails
                                                                  .clear();
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .person_remove_outlined,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : ListView.builder(
                                                  itemCount:
                                                      propertyTenant.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(8, 0, 8, 0),
                                                      child: Card(
                                                        child: SizedBox(
                                                          height: 100,
                                                          width: 100,
                                                          child: Stack(
                                                            children: [
                                                              SizedBox(
                                                                height: 100,
                                                                width: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: 60,
                                                                      height:
                                                                          60,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: propertyTenant[index].profile_pic.isEmpty
                                                                            ? getRandomColor(propertyTenant[index].sys_status)
                                                                            : Colors.white,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(propertyTenant[index].profile_pic),
                                                                            fit: BoxFit.cover),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors.grey,
                                                                              offset: Offset(0, 0),
                                                                              blurRadius: 1),
                                                                        ],
                                                                      ),
                                                                      child: propertyTenant[index]
                                                                              .profile_pic
                                                                              .isEmpty
                                                                          ? Center(
                                                                              child: Text(
                                                                                propertyTenant[index].full_name.split(' ')[0].split('')[0],
                                                                                style: TextStyle(fontSize: 30, color: white, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            )
                                                                          : SizedBox(),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            width,
                                                                        height:
                                                                            height,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Text(
                                                                              propertyTenant[index].full_name,
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                              ),
                                                                              maxLines: 2,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 0,
                                                                right: 0,
                                                                child: Card(
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        propertyTenant
                                                                            .remove(propertyTenant[propertyTenantEmails.indexOf(propertyTenant[index].email_address)]);
                                                                        propertyTenantEmails
                                                                            .remove(propertyTenant[index].email_address);
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .person_remove_outlined,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                        ),
                                      ),
                              ),
                              Positioned(
                                top: 0,
                                left: 10,
                                child: Container(
                                  color: white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(propertyTenant.isNotEmpty
                                        ? 'Property tenants #${propertyTenant.length} '
                                        : 'Property tenants'),
                                  ),
                                ),
                              ),
                              propertyTenant.length > 1
                                  ? Positioned(
                                      top: 0,
                                      right: 10,
                                      child: Container(
                                          color: white,
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  show_user = true;
                                                  add_user_status =
                                                      'Property Tenants';
                                                });
                                              },
                                              child: Text('Add'))))
                                  : SizedBox()
                            ],
                          )
                        : SizedBox(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextButton.icon(
                    onPressed: () {
                      if (add_handler) {
                        setState(() {
                          add_handler = false;
                        });
                      } else {
                        setState(() {
                          add_handler = true;
                        });
                      }
                    },
                    icon: Icon(add_handler
                        ? Icons.check_box
                        : Icons.check_box_outline_blank),
                    label: Text('Add Hanler'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          (add_handler)
              ? SizedBox(
                  height: 120,
                  width: width,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          width: width,
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 0),
                                child: propertyHandle == null
                                    ? Card(
                                        child: SizedBox(
                                          width: width,
                                          height: 100,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                show_user = true;
                                                add_user_status =
                                                    'Property Handler';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 70,
                                                  width: 70,
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width: 65,
                                                          height: 65,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: white,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  color: Colors
                                                                      .grey,
                                                                  blurRadius:
                                                                      1),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .account_circle,
                                                              size: 65,
                                                              color: sys_green,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: sys_green,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 15,
                                                              color: white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 120,
                                                    width: width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Add Handler of the property',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          'The Handler of the property incase of sale, rent or construction',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14,
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
                                      )
                                    : Card(
                                        child: SizedBox(
                                          width: width,
                                          height: 120,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: width,
                                                height: 120,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color: propertyHandle!
                                                                .profile_pic
                                                                .isEmpty
                                                            ? getRandomColor(
                                                                propertyHandle!
                                                                    .sys_status)
                                                            : Colors.white,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                propertyHandle!
                                                                    .profile_pic),
                                                            fit: BoxFit.cover),
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset:
                                                                  Offset(0, 0),
                                                              blurRadius: 1),
                                                        ],
                                                      ),
                                                      child: propertyHandle!
                                                              .profile_pic
                                                              .isEmpty
                                                          ? Center(
                                                              child: Text(
                                                                propertyHandle!
                                                                    .full_name
                                                                    .split(
                                                                        ' ')[0]
                                                                    .split(
                                                                        '')[0],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        30,
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: width,
                                                        height: height,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              propertyHandle!
                                                                  .full_name,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              propertyHandle!
                                                                  .status
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Card(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        propertyHandle = null;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .person_remove_outlined,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                              Positioned(
                                top: 0,
                                left: 10,
                                child: Container(
                                  color: white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('Property handler'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 120,
                        width: width,
                      ))
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                false
                    // ignore: dead_code
                    ? Padding(
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
                                show_add_repo = false;
                              });
                            },
                            child: Icon(
                              Icons.chevron_right,
                              color: white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            add_index = 1;
                          });
                        }
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

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

  int screen_index = 0;
  Column RepoList(double width, double height, String screen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              Icon(
                Icons.real_estate_agent,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Repository',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: screen_index == 0
                                          ? sys_green
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          screen_index = 0;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          'Registry',
                                          style: TextStyle(
                                              color: screen_index == 0
                                                  ? white
                                                  : Colors.black,
                                              fontSize: 14),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: screen_index == 1
                                          ? sys_green
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          screen_index = 1;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Requests',
                                              style: TextStyle(
                                                  color: screen_index == 1
                                                      ? white
                                                      : Colors.black,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('USERS')
                                                    .doc(currentUser!
                                                        .email_address)
                                                    .collection(
                                                        'CLIENT PROPERTY REQUESTS')
                                                    .where('status',
                                                        isEqualTo: 'Submitted')
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.none) {
                                                    return SizedBox();
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SizedBox();
                                                  }
                                                  if (snapshot.hasData &&
                                                      snapshot.data != null &&
                                                      snapshot.data!.docs
                                                              .length >=
                                                          0) {
                                                    return Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              screen_index == 1
                                                                  ? white
                                                                  : sys_green),
                                                      child: Center(
                                                        child: Text(
                                                          '${snapshot.data!.docs.length}',
                                                          style: TextStyle(
                                                              color:
                                                                  screen_index ==
                                                                          1
                                                                      ? sys_green
                                                                      : white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                })
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: screen_index == 2
                                          ? sys_green
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          screen_index = 2;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Approved Requests',
                                              style: TextStyle(
                                                  color: screen_index == 2
                                                      ? white
                                                      : Colors.black,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('USERS')
                                                    .doc(currentUser!
                                                        .email_address)
                                                    .collection(
                                                        'CLIENT PROPERTY REQUESTS')
                                                    .where(
                                                      'status',
                                                      isEqualTo: 'Approved',
                                                    )
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.none) {
                                                    return SizedBox();
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SizedBox();
                                                  }
                                                  if (snapshot.hasData &&
                                                      snapshot.data != null &&
                                                      snapshot.data!.docs
                                                              .length >=
                                                          0) {
                                                    return Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              screen_index == 2
                                                                  ? white
                                                                  : sys_green),
                                                      child: Center(
                                                        child: Text(
                                                          '${snapshot.data!.docs.length}',
                                                          style: TextStyle(
                                                              color:
                                                                  screen_index ==
                                                                          2
                                                                      ? sys_green
                                                                      : white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                })
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: screen_index == 3
                                          ? sys_green
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          screen_index = 3;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Offers',
                                              style: TextStyle(
                                                  color: screen_index == 3
                                                      ? white
                                                      : Colors.black,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: screen_index == 3
                                                      ? white
                                                      : sys_green),
                                              child: Center(
                                                child: Text(
                                                  '3',
                                                  style: TextStyle(
                                                      color: screen_index == 3
                                                          ? sys_green
                                                          : white,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(children: [
                  searchBar(height, 400),
                  SizedBox(
                    width: 10,
                  ),
                  filterButton(),
                  Container(
                    width: 60,
                    height: 50,
                    decoration: BoxDecoration(
                        color: sys_green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          show_add_repo = true;
                        });
                      },
                      child: Icon(
                        Icons.add_home,
                        color: white,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: propertyScreens(width, height),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _property_view = '';
  PropertyRequestF? _propertyRequestF;

  Widget propertyScreens(double width, double height) {
    switch (screen_index) {
      case 0:
        return propertyRegistries(width, height);
      case 1:
        return requestSA(width, height, 'Submitted');
      case 2:
        return requestSA(width, height, 'Approved');
      case 3:
        return Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Container(
              width: width,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: width,
                      height: height,
                      color: white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'S/N',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Client',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: width,
                      height: height,
                      color: white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Plot no',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: white,
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Type',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: width,
                      height: height,
                      color: white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Offer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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
          )),
        ]);
      default:
        return propertyRegistries(width, height);
    }
  }

  Column requestSA(double width, double height, String s) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                blurRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'S/N',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  width: width,
                  height: height,
                  color: white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'Client',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: width,
                  height: height,
                  color: white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'Plot no',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: white,
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('USERS')
                  .doc(currentUser!.email_address)
                  .collection('CLIENT PROPERTY REQUESTS')
                  .where('status', isEqualTo: s)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return listNone();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return listWaiting();
                }
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.docs.length > 0) {
                  int count = snapshot.data!.docs.length;
                  return ListView.builder(
                      itemCount: count,
                      itemBuilder: (context, index) {
                        PropertyRequestF propertyRequestF =
                            PropertyRequestF.fromDocument(
                                snapshot.data!.docs[index]);
                        return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('PROPERTY REPO')
                                .doc(propertyRequestF.plot_no.toUpperCase())
                                .get(),
                            builder: (context, pr_snapshot) {
                              if (pr_snapshot.connectionState ==
                                  ConnectionState.none) {
                                return SizedBox();
                              }
                              if (pr_snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 15, 10, 10),
                                  child: Container(
                                    width: width,
                                    height: 35,
                                    color: Colors.grey.shade100,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: width,
                                            height: height,
                                            color: Colors.grey.shade50,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            width: width,
                                            height: height,
                                            child:
                                                userWaitingNone(width, height),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: width,
                                            height: height,
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            color: Colors.grey.shade50,
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: width,
                                            height: height,
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              if (pr_snapshot.hasData &&
                                  pr_snapshot.data != null &&
                                  pr_snapshot.data!.exists) {
                                PropertyF registry =
                                    PropertyF.fromDocument(pr_snapshot.data!);
                                return TextButton(
                                  onPressed: () {
                                    setState(() {
                                      view_property = true;
                                      selected_property = registry;
                                      _property_view = 'request_view';
                                      _propertyRequestF = propertyRequestF;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 10),
                                    child: Container(
                                      width: width,
                                      height: 35,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: width,
                                              height: height,
                                              color: white,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      '${index + 1}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                                width: width,
                                                height: height,
                                                color: white,
                                                child: FutureBuilder<
                                                        DocumentSnapshot>(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection('USERS')
                                                        .doc(propertyRequestF
                                                            .request_by)
                                                        .get(),
                                                    builder: (context,
                                                        user_snapshot) {
                                                      if (user_snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .none) {
                                                        return userWaitingNone(
                                                            width, height);
                                                      }
                                                      if (user_snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return userWaitingNone(
                                                            width, height);
                                                      }
                                                      if (user_snapshot
                                                              .hasData &&
                                                          user_snapshot.data !=
                                                              null &&
                                                          user_snapshot
                                                              .data!.exists) {
                                                        UserF owner_user =
                                                            UserF.fromDocument(
                                                                user_snapshot
                                                                    .data!);
                                                        return Row(
                                                          children: [
                                                            Container(
                                                              width: 35,
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: owner_user
                                                                        .profile_pic
                                                                        .isEmpty
                                                                    ? getRandomColor(
                                                                        owner_user
                                                                            .sys_status)
                                                                    : Colors
                                                                        .white,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        owner_user
                                                                            .profile_pic),
                                                                    fit: BoxFit
                                                                        .cover),
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      blurRadius:
                                                                          1),
                                                                ],
                                                              ),
                                                              child: owner_user
                                                                      .profile_pic
                                                                      .isEmpty
                                                                  ? Center(
                                                                      child:
                                                                          Text(
                                                                        owner_user
                                                                            .full_name
                                                                            .split(' ')[0]
                                                                            .split('')[0],
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
                                                              width: 3,
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                width: width,
                                                                height: height,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      owner_user
                                                                          .full_name,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 1,
                                                                    ),
                                                                    Text(
                                                                      owner_user
                                                                          .email_address,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      } else {
                                                        return userWaitingNone(
                                                            width, height);
                                                      }
                                                    })),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      propertyRequestF.request
                                                                  .toUpperCase() ==
                                                              'LANDLORD'
                                                          ? 'OWNERSHIP'
                                                          : 'TENANT',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              color: white,
                                              width: width,
                                              height: height,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      registry.plot_no,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      registry.status,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      registry.type,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              width: width,
                                              height: height,
                                              color: white,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      "₦${registry.amount}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            });
                      });
                } else {
                  return listNone();
                }
              }),
        ),
      ),
    ]);
  }

  void approveOwnership() {
    if (_propertyRequestF != null) {
      FirebaseFirestore.instance
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(_propertyRequestF!.request_id)
          .update({
        'status': 'Approve',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(_propertyRequestF!.request_by)
          .collection('OWN PROPERTY')
          .doc(_propertyRequestF!.plot_no.toUpperCase())
          .set({
        'plot_no': _propertyRequestF!.plot_no.toUpperCase(),
        'date_reg': DateTime.now(),
        'search_query': _propertyRequestF!.search_query,
      });
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(_propertyRequestF!.request_by)
          .collection('MY PROPERTY REQUEST')
          .doc(_propertyRequestF!.request_id)
          .update({
        'status': 'Approve',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(selected_property!.registered_by)
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(_propertyRequestF!.request_id)
          .update({
        'status': 'Approve',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });
    }
    String id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(_propertyRequestF!.request_by)
        .collection('ACTIVITIES')
        .doc(id)
        .set({
      'id': id,
      'activity_id': _propertyRequestF!.request_id,
      'activity_type': 'APPROVE',
      'activity_title': 'Request on ${_propertyRequestF!.plot_no} APPROVE',
      'activity_content': extra_note_request.text.isNotEmpty
          ? extra_note_request.text
          : 'Management have approved your ownership request on ${_propertyRequestF!.plot_no}',
      'activity_sq': _propertyRequestF!.search_query,
      'activity_date': DateTime.now(),
      'activity_read': false,
      'activity_user': currentUser!.email_address
    });
    if (selected_property!.property_handler.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(selected_property!.property_handler)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': _propertyRequestF!.request_id,
        'activity_type': 'APPROVE',
        'activity_title': '${_propertyRequestF!.plot_no} APPROVEd',
        'activity_content': extra_note_request.text.isNotEmpty
            ? extra_note_request.text
            : 'Management have approved ownership request on ${_propertyRequestF!.plot_no}',
        'activity_sq': _propertyRequestF!.search_query,
        'activity_date': DateTime.now(),
        'activity_read': false,
        'activity_user': currentUser!.email_address
      });
    }
  }

  void declineOwnership() {
    if (_propertyRequestF != null) {
      FirebaseFirestore.instance
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(_propertyRequestF!.request_id)
          .update({
        'status': 'Decline',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(_propertyRequestF!.request_by)
          .collection('MY PROPERTY REQUEST')
          .doc(_propertyRequestF!.request_id)
          .update({
        'status': 'Decline',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(selected_property!.registered_by)
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(_propertyRequestF!.request_id)
          .update({
        'status': 'Decline',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });
    }
    String id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(_propertyRequestF!.request_by)
        .collection('ACTIVITIES')
        .doc(id)
        .set({
      'id': id,
      'activity_id': _propertyRequestF!.request_id,
      'activity_type': 'Decline',
      'activity_title': 'Request on ${_propertyRequestF!.plot_no} Decline',
      'activity_content': extra_note_request.text.isNotEmpty
          ? extra_note_request.text
          : 'Management have decline your ownership request on ${_propertyRequestF!.plot_no}',
      'activity_sq': _propertyRequestF!.search_query,
      'activity_date': DateTime.now(),
      'activity_read': false,
      'activity_user': currentUser!.email_address
    });
    if (selected_property!.property_handler.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(selected_property!.property_handler)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': _propertyRequestF!.request_id,
        'activity_type': 'Decline',
        'activity_title': '${_propertyRequestF!.plot_no} Decline',
        'activity_content': extra_note_request.text.isNotEmpty
            ? extra_note_request.text
            : 'Management have decline ${_propertyRequestF!.request} request on ${_propertyRequestF!.plot_no}',
        'activity_sq': _propertyRequestF!.search_query,
        'activity_date': DateTime.now(),
        'activity_read': false,
        'activity_user': currentUser!.email_address
      });
    }
    setState(
      () {
        view_property = false;
        selected_property = null;
        _property_view = '';
        _propertyRequestF = null;
      },
    );
  }

  Column propertyRegistries(double width, double height) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Container(
            width: width,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: width,
                    height: height,
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'S/N',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'Plot no',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    width: width,
                    height: height,
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'Possessor',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: white,
                    width: width,
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    width: width,
                    height: height,
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(
                            'Amount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('USERS')
                    .doc(currentUser!.email_address)
                    .collection('REGISTERED PROPERTY')
                    .orderBy('date_reg', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return listNone();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return listWaiting();
                  }
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.docs.length > 0) {
                    int count = snapshot.data!.docs.length;
                    return ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) {
                          UserPropertyF user_registry =
                              UserPropertyF.fromDocument(
                                  snapshot.data!.docs[index]);

                          return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('PROPERTY REPO')
                                  .doc(user_registry.plot_no.toUpperCase())
                                  .get(),
                              builder: (context, pr_snapshot) {
                                if (pr_snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return SizedBox();
                                }
                                if (pr_snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 10),
                                    child: Container(
                                      width: width,
                                      height: 35,
                                      color: Colors.grey.shade100,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: width,
                                              height: height,
                                              color: Colors.grey.shade50,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              width: width,
                                              height: height,
                                              color: Colors.grey.shade100,
                                              child: userWaitingNone(
                                                  width, height),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              color: Colors.grey.shade50,
                                              width: width,
                                              height: height,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              width: width,
                                              height: height,
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (pr_snapshot.hasData &&
                                    pr_snapshot.data != null &&
                                    pr_snapshot.data!.exists) {
                                  PropertyF registry =
                                      PropertyF.fromDocument(pr_snapshot.data!);
                                  return TextButton(
                                    onPressed: () {
                                      setState(() {
                                        view_property = true;
                                        selected_property = registry;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 10),
                                      child: Container(
                                        width: width,
                                        height: 35,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: width,
                                                height: height,
                                                color: white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                        '${index + 1}',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: SizedBox(
                                                width: width,
                                                height: height,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                        registry.plot_no,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                width: width,
                                                height: height,
                                                color: white,
                                                child: registry.property_owner
                                                        .isNotEmpty
                                                    ? FutureBuilder<
                                                            DocumentSnapshot>(
                                                        future: FirebaseFirestore
                                                            .instance
                                                            .collection('USERS')
                                                            .doc(registry
                                                                .property_owner)
                                                            .get(),
                                                        builder: (context,
                                                            user_snapshot) {
                                                          if (user_snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .none) {
                                                            return userWaitingNone(
                                                                width, height);
                                                          }
                                                          if (user_snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return userWaitingNone(
                                                                width, height);
                                                          }
                                                          if (user_snapshot
                                                                  .hasData &&
                                                              user_snapshot
                                                                      .data !=
                                                                  null &&
                                                              user_snapshot
                                                                  .data!
                                                                  .exists) {
                                                            UserF owner_user =
                                                                UserF.fromDocument(
                                                                    user_snapshot
                                                                        .data!);
                                                            return Row(
                                                              children: [
                                                                Container(
                                                                  width: 35,
                                                                  height: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: owner_user
                                                                            .profile_pic
                                                                            .isEmpty
                                                                        ? getRandomColor(owner_user
                                                                            .sys_status)
                                                                        : Colors
                                                                            .white,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(owner_user
                                                                            .profile_pic),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors
                                                                              .grey,
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                          blurRadius:
                                                                              1),
                                                                    ],
                                                                  ),
                                                                  child: owner_user
                                                                          .profile_pic
                                                                          .isEmpty
                                                                      ? Center(
                                                                          child:
                                                                              Text(
                                                                            owner_user.full_name.split(' ')[0].split('')[0],
                                                                            style: TextStyle(
                                                                                fontSize: 25,
                                                                                color: white,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        )
                                                                      : SizedBox(),
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          owner_user
                                                                              .full_name,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              1,
                                                                        ),
                                                                        Text(
                                                                          owner_user
                                                                              .email_address,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          } else {
                                                            return userWaitingNone(
                                                                width, height);
                                                          }
                                                        })
                                                    : Row(
                                                        children: [
                                                          Container(
                                                            width: 45,
                                                            height: 45,
                                                            child: sys_constants
                                                                .imgHolder(45,
                                                                    ubairgo_blue),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: width,
                                                              height: height,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    'Ubairgo Real Estate',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                    maxLines: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                width: width,
                                                height: height,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                        registry.status,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                color: white,
                                                width: width,
                                                height: height,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                        registry.type,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                width: width,
                                                height: height,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                        registry.size + " m²",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: width,
                                                height: height,
                                                color: white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                        "₦${registry.amount}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              });
                        });
                  } else {
                    return listNone();
                  }
                }),
          ),
        )
      ],
    );
  }

  Row userWaitingNone(double width, double height) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, offset: Offset(0, 0), blurRadius: 1),
            ],
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Expanded(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey.shade300,
                  child: Text(
                    '                               ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Container(
                  color: Colors.grey.shade300,
                  child: Text(
                    '                            ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
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

  propertyDisplaySwitch(
      double width, double height, String s, BuildContext context) {
    if (show_add_repo) {
      return AddRepo(width, height, 'Computer');
    } else if (view_property && selected_property != null) {
      return ViewRepo(width, height, 'Computer');
    } else {
      return RepoList(width, height, 'Computer');
    }
  }

  uploadImagesFileWeb(
      List<Uint8List> id_filebyte, List<dynamic> id_filename) async {
    try {
      List<dynamic> download_url = [];
      for (var i = 0; i < id_filebyte.length; i++) {
        String id = Uuid().v4();
        String name = "${id_filename[i]}${id}";
        await firebase_storage.FirebaseStorage.instance.ref('${name}').putData(
            id_filebyte[i],
            firebase_storage.SettableMetadata(
                contentType: sys_constants.getFileType(id_filename[i])));

        dynamic download = await firebase_storage.FirebaseStorage.instance
            .ref('${name}')
            .getDownloadURL();

        if (download != null) {
          download_url.add(download);
        }
      }
      return download_url;
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      setState(() {
        isregistrying = false;
      });
    }
  }

  uploadFeaturedFileWeb(Uint8List id_filebyte, dynamic id_filename) async {
    try {
      dynamic download_url = '';
      String id = Uuid().v4();
      String name = "${id_filename}${id}";
      await firebase_storage.FirebaseStorage.instance.ref('${name}').putData(
          id_filebyte,
          firebase_storage.SettableMetadata(
              contentType: sys_constants.getFileType(id_filename)));

      dynamic download = await firebase_storage.FirebaseStorage.instance
          .ref('${name}')
          .getDownloadURL();

      if (download != null) {
        download_url = download;
      }

      return download_url;
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      setState(() {
        isregistrying = false;
      });
    }
  }

  void registerProperty() async {
    setState(() {
      isregistrying = true;
    });
    dynamic featured_image = '';
    if (featured_filebyte != null) {
      featured_image =
          await uploadFeaturedFileWeb(featured_filebyte!, featured_filename);
    }
    List<dynamic> images = [];
    if (images_filebyte.isNotEmpty) {
      images = await uploadImagesFileWeb(images_filebyte, images_filename);
    }
    List<String> ad = address.text.split(' ');
    List<String> sq = [
      plot_no.text.toLowerCase(),
      plot_no.text.toUpperCase(),
    ];
    for (var a in ad) {
      sq.add(a);
    }
    DateTime time = DateTime.now();
    FirebaseFirestore.instance
        .collection('PROPERTY REPO')
        .doc(plot_no.text.toUpperCase())
        .set({
      'plot_no': plot_no.text.toUpperCase(),
      'status': sel_status,
      'type': sel_type,
      'size': plot_size.text,
      'amount': plot_amount.text,
      'address': address.text,
      'title': extra_note.text.split('.')[0],
      'description': extra_note.text,
      'palours': palour,
      'bedrooms': bedrooms,
      'bathroom': bathrooms,
      'kitchen': kitchen,
      'property_owner': getProperyOwner(),
      'property_tenants':
          (propertyTenant.isNotEmpty) ? propertyTenantEmails : [],
      'property_handler':
          (propertyHandle != null) ? propertyHandle!.email_address : '',
      'featured_img': featured_image,
      'images': images,
      'registered_by': currentUser!.email_address,
      'date_reg': time,
      'search_query': sq,
    });

    FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.email_address)
        .collection('REGISTERED PROPERTY')
        .doc(plot_no.text.toUpperCase())
        .set({
      'plot_no': plot_no.text.toUpperCase(),
      'date_reg': time,
      'search_query': sq,
    });

    if ((propertyTenant.isNotEmpty)) {
      for (UserF em in propertyTenant)
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(em.email_address)
            .collection('RENTED PROPERTY')
            .doc(plot_no.text.toUpperCase())
            .set({
          'plot_no': plot_no.text.toUpperCase(),
          'date_reg': time,
          'search_query': sq,
        }).then((value) {
          String id = Uuid().v4();
          FirebaseFirestore.instance
              .collection('USERS')
              .doc(em.email_address)
              .collection('ACTIVITIES')
              .doc(id)
              .set({
            'id': id,
            'activity_id': plot_no.text.toUpperCase(),
            'activity_type': 'PROPERTY_REG',
            'activity_title': 'Registered as Tenant',
            'activity_content':
                'You are now a tenant at property ${plot_no.text.toUpperCase()}',
            'activity_sq': sq,
            'activity_date': time,
            'activity_read': false,
            'activity_user': currentUser!.email_address
          });
        });
    }
    if (propertyHandle != null) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(propertyHandle!.email_address)
          .collection('HANDLE PROPERTY')
          .doc(plot_no.text.toUpperCase())
          .set({
        'plot_no': plot_no.text.toUpperCase(),
        'date_reg': time,
        'search_query': sq,
      }).then((value) {
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(propertyHandle!.email_address)
            .collection('ACTIVITIES')
            .doc(id)
            .set({
          'id': id,
          'activity_id': plot_no.text.toUpperCase(),
          'activity_type': 'PROPERTY_REG',
          'activity_title': 'Registered as Handler',
          'activity_content':
              '${plot_no.text.toUpperCase()}: now as the property handler',
          'activity_sq': sq,
          'activity_date': time,
          'activity_read': false,
          'activity_user': currentUser!.email_address
        });
      });
    }

    if (propertyOwner != null) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(propertyOwner!.email_address)
          .collection('OWN PROPERTY')
          .doc(plot_no.text.toUpperCase())
          .set({
        'plot_no': plot_no.text.toUpperCase(),
        'date_reg': time,
        'search_query': sq,
      }).then((value) {
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(propertyHandle!.email_address)
            .collection('ACTIVITIES')
            .doc(id)
            .set({
          'id': id,
          'activity_id': plot_no.text.toUpperCase(),
          'activity_type': 'PROPERTY_REG',
          'activity_title': 'Registered as Owner',
          'activity_content':
              '${plot_no.text.toUpperCase()}: now as the owner of the property',
          'activity_sq': sq,
          'activity_date': time,
          'activity_read': false,
          'activity_user': currentUser!.email_address
        });
      });
    }

    showSnackBar(context);

    setState(() {
      isregistrying = false;
      images_filebyte.clear();
      images_filename.clear();
      featured_filebyte = null;
      featured_filename = '';
      show_user = false;
      propertyOwner = null;
      propertyOwnerEmail = '';
      propertyHandle = null;
      propertyHandleEmail = '';
      propertyTenant.clear();
      propertyTenantEmails.clear();
      kitchen = 0;
      bathrooms = 0;
      bedrooms = 0;
      palour = 0;
      plot_size.text = '';
      plot_amount.text = '';
      address.text = '';
      extra_note.text = '';
      sel_type = '';
      sel_status = '';
      plot_no.text = '';
      add_index = 0;
    });
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            FontAwesomeIcons.fileCircleCheck,
            color: white,
            size: 20,
          ),
          Text('Successfully registered'),
        ],
      ),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      width: 400,
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getProperyOwner() {
    if (propertyOwner != null) {
      return propertyOwner!.email_address;
    } else {
      return '';
    }
  }

  void callUrl(phone_number) {}

  void supportAgemt() {}
}
