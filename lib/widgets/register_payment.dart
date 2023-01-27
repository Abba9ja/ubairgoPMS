import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisteredPayment extends StatefulWidget {
  @override
  State<RegisteredPayment> createState() => _RegisteredPayment();
}

class _RegisteredPayment extends State<RegisteredPayment> {
  TextEditingController plot_no = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController extra_note = TextEditingController();
  TextEditingController trasnsaction_id = TextEditingController();
  String plot_id_search = '';
  SysConstants sys_constants = SysConstants();
  final _formKey1 = GlobalKey<FormState>();
  PropertyF? sel_property;
  String sel_property_no = '';

  UserF? client;
  String client_email = '';

  final List<String> typeItems = [
    'Facility Fee',
    'Security Fee',
    'Electiricity Bill',
    'Water Bill',
  ];

  String paymentType = '';
  bool confirm_payment = false;

  TextEditingController user_email = TextEditingController();
  String email_address = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: sys_green,
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'NOTE: Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.grey.shade50,
                    child: SizedBox(
                      width: width,
                      height: plot_id_search.isNotEmpty ? 460 : 60,
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
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  plot_id_search = value;
                                });
                              },
                              onSaved: (newValue) {
                                setState(() {
                                  plot_id_search = newValue!;
                                });
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
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
                          plot_id_search.isNotEmpty
                              ? Expanded(
                                  child: SizedBox(
                                      width: width,
                                      height: height,
                                      child: FutureBuilder<DocumentSnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection('PROPERTY REPO')
                                            .doc(plot_id_search.toUpperCase())
                                            .get(),
                                        builder: (context, pr_snapshot) {
                                          if (pr_snapshot.connectionState ==
                                              ConnectionState.none) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child:
                                                      sys_constants.imgHolder(
                                                          width,
                                                          houses_searching),
                                                )
                                              ],
                                            );
                                          }
                                          if (pr_snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child:
                                                      sys_constants.imgHolder(
                                                          width,
                                                          houses_searching),
                                                )
                                              ],
                                            );
                                          }

                                          if (pr_snapshot.hasData &&
                                              pr_snapshot.data != null &&
                                              pr_snapshot.data!.exists) {
                                            PropertyF property =
                                                PropertyF.fromDocument(
                                                    pr_snapshot.data!);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: width,
                                                height: height,
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
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child:
                                                                    Container(
                                                                  width: width,
                                                                  height:
                                                                      height,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          property
                                                                              .featured_img,
                                                                        ),
                                                                        fit: BoxFit.cover),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors
                                                                              .grey,
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                          blurRadius:
                                                                              1.5),
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
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      20,
                                                                      10,
                                                                      10,
                                                                      10),
                                                              child: TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      property
                                                                          .title,
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              black),
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
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
                                                                              style: TextStyle(fontSize: 12, color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
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
                                                              child: Center(
                                                                child: Text(
                                                                  property
                                                                      .status,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 3,
                                                              height: 130,
                                                              color: property
                                                                          .status ==
                                                                      'For Sale'
                                                                  ? sys_green
                                                                  : Colors.blue,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          if (sel_property_no ==
                                                              property
                                                                  .plot_no) {
                                                            sel_property_no =
                                                                '';
                                                            sel_property = null;
                                                          } else {
                                                            setState(() {
                                                              sel_property_no =
                                                                  property
                                                                      .plot_no;
                                                              sel_property =
                                                                  property;
                                                            });
                                                          }
                                                        },
                                                        icon: Icon(
                                                          (sel_property_no ==
                                                                  property
                                                                      .plot_no)
                                                              ? Icons.add_home
                                                              : Icons
                                                                  .add_home_outlined,
                                                          color: sys_green,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child:
                                                      sys_constants.imgHolder(
                                                          width,
                                                          houses_searching),
                                                )
                                              ],
                                            );
                                          }
                                        },
                                      )),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  plot_id_search.isNotEmpty
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox(),
                  sel_property != null
                      ? getPaymentType(width, height)
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.grey.shade50,
                    child: SizedBox(
                      height: email_address.isNotEmpty ? 150 : 50,
                      width: width,
                      child: Column(
                        children: [
                          searchBar(height, width),
                          email_address.isNotEmpty
                              ? SizedBox(
                                  width: width,
                                  height: 100,
                                  child: StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('USERS')
                                          .doc(email_address)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null &&
                                            snapshot.data!.exists) {
                                          UserF propertyOwner =
                                              UserF.fromDocument(
                                                  snapshot.data!);
                                          return SizedBox(
                                            width: width,
                                            height: 100,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: width,
                                                  height: 100,
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
                                                          color: propertyOwner
                                                                  .profile_pic
                                                                  .isEmpty
                                                              ? sys_constants
                                                                  .getRandomColor(
                                                                      propertyOwner
                                                                          .sys_status)
                                                              : Colors.white,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  propertyOwner
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
                                                            propertyOwner
                                                                    .profile_pic
                                                                    .isEmpty
                                                                ? Center(
                                                                    child: Text(
                                                                      propertyOwner
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
                                                                propertyOwner
                                                                    .full_name,
                                                                style:
                                                                    TextStyle(
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
                                                                propertyOwner
                                                                    .status
                                                                    .toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
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
                                                    child: IconButton(
                                                      onPressed: () {
                                                        if (client_email !=
                                                            propertyOwner
                                                                .email_address) {
                                                          setState(() {
                                                            client_email =
                                                                propertyOwner
                                                                    .email_address;
                                                            client =
                                                                propertyOwner;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            client_email = '';
                                                            client = null;
                                                          });
                                                        }
                                                      },
                                                      icon: (client_email !=
                                                              propertyOwner
                                                                  .email_address)
                                                          ? Icon(Icons
                                                              .check_box_outline_blank)
                                                          : Icon(
                                                              Icons.check_box),
                                                      color: (client_email ==
                                                              propertyOwner
                                                                  .email_address)
                                                          ? sys_green
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: width,
                                                height: 50,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 0, 20, 0),
                                                  child: Container(
                                                    width: width,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors
                                                            .pink.shade200),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Card(
                                                            color: Colors
                                                                .pink.shade300,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Icon(
                                                                Icons
                                                                    .error_outline,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(
                                                            width: width,
                                                            height: height,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'User not found, check email and try again',
                                                                  maxLines: 2,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
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
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.number,
                            controller: amount,
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Amount required';
                              }
                              return null;
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
                              labelText: 'Amount',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width,
                    height: 120,
                    child: Expanded(
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
                                maxLines: 4,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width,
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            cursorColor: sys_green,
                            keyboardType: TextInputType.text,
                            controller: trasnsaction_id,
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Transaction id required';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            decoration: InputDecoration(
                              focusColor: sys_green,
                              prefixIconColor: sys_green,
                              prefixIcon: Icon(Icons.numbers),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: 'Transaction ID',
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            pickIDPressed();
                          },
                          icon: Icon(Icons.attach_file),
                          label: Text('Attach Tella'))
                    ],
                  ),
                  id_filebyte.isNotEmpty
                      ? SizedBox(
                          width: width,
                          height: 150,
                          child: ListView.builder(
                              itemCount: id_filebyte.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Card(
                                    child: SizedBox(
                                      height: 130,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 130,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Card(
                                                    child: SizedBox(
                                                      height: 100,
                                                      child: Image.memory(
                                                        id_filebyte[index],
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  id_filebyte.remove(
                                                      id_filebyte[index]);
                                                  id_filename.remove(
                                                      id_filename[index]);
                                                });
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Icon(Icons.close),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }))
                      : SizedBox(),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: width,
                    height: 50,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (confirm_payment) {
                                  setState(() {
                                    confirm_payment = false;
                                  });
                                } else {
                                  setState(() {
                                    confirm_payment = true;
                                  });
                                }
                              },
                              icon: Icon(
                                confirm_payment
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color:
                                    confirm_payment ? sys_green : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'By clicking the check box you agree that this Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.',
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      !is_registring
                          ? ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey1.currentState!.validate()) {
                                  registerPayment();
                                }
                              },
                              icon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.account_tree),
                              ),
                              label: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('Register'),
                              ))
                          : Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: sys_green),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: white,
                                ),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container searchBar(double height, double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade50,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400, offset: Offset(0, 0), blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: height,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: user_email,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    onChanged: (value) {
                      setState(() {
                        email_address = value;
                      });
                    },
                    onSaved: (newValue) {
                      setState(() {
                        email_address = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email address',
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
                    color: sys_green, borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.person_add,
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

  List<Uint8List> id_filebyte = [];
  List<dynamic> id_filename = [];
  dynamic _pickImageError;

  pickIDPressed() async {
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
          id_filebyte = l_file;
          id_filename = l_filename;
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

  final List<String> ocuppiedL = [
    'Facility Fee',
    'Security Fee',
    'Electiricity Bill',
    'Water Bill',
  ];

  final List<String> ocuppiedT = [
    'Security Fee',
    'Electiricity Bill',
    'Water Bill',
  ];

  final List<String> forsale_types = [
    'Full Payment',
    'Instalment Payment',
  ];

  final List<String> forrent_types = [
    'Rent Payment',
    'Rent part Payment',
  ];
  final List<String> forlease_types = [
    'Lease Payment',
    'Lease part Payment',
  ];
  String pay_type = '';
  getPaymentType(double w, double h) {
    List<String> types = [];
    if (sel_property!.status.toLowerCase() == 'for sale') {
      types = forsale_types;
    } else if (sel_property!.status.toLowerCase() == 'for rent') {
      types = forrent_types;
    } else if (sel_property!.status.toLowerCase() == 'for lease') {
      types = forlease_types;
    } else if (sel_property!.status.toLowerCase() == 'Ocuppied Tenant') {
      types = ocuppiedT;
    } else {
      types = ocuppiedL;
    }
    return SizedBox(
      width: w,
      height: 60,
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
            'Payment For',
            style: TextStyle(fontSize: 14),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 30,
          buttonHeight: 60,
          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          items: types
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
            //Do something when changing the item if you want.
          },
          onSaved: (value) {
            pay_type = value.toString();
          },
        ),
      ),
    );
  }

  uploadFileWeb(List<Uint8List> id_filebyte, List<dynamic> id_filename) async {
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
        is_registring = false;
      });
    }
  }

  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "₦");

  bool is_registring = false;

  getOutStanding(double parse, double parse2) {
    return parse2 - parse;
  }

  getStatus() {
    if (sel_property!.status == 'For Sale') {
      return 'Occupied Landlord';
    } else if (sel_property!.status == 'For Rent') {
      return 'Occupied Tenant';
    } else {
      return sel_property!.status;
    }
  }

  getOwner() {
    if (sel_property!.status == 'For Sale') {
      return client_email;
    } else {
      return sel_property!.property_owner;
    }
  }

  getTenant() {
    if (sel_property!.status == 'For Rent') {
      return [client_email];
    } else {
      return sel_property!.property_tenants;
    }
  }

  void registerPayment() async {
    String m_id = Uuid().v4();
    setState(() {
      is_registring = false;
    });
    List<dynamic> reciept_url = [];
    if (id_filebyte.isNotEmpty) {
      reciept_url = await uploadFileWeb(id_filebyte, id_filename);
    }
    List<dynamic> search = [];
    search.add(
      sel_property!.plot_no.toLowerCase(),
    );
    if (client_email.isNotEmpty) {
      search.add(
        client_email.split("@").first.toLowerCase(),
      );
    }

    if (sel_property!.property_handler.isNotEmpty) {
      search.add(
        sel_property!.property_handler.split("@").first.toLowerCase(),
      );
    }
    search.add(
      currentUser!.email_address.split("@").first.toLowerCase(),
    );
    for (var element in trasnsaction_id.text.split(',')) {
      search.add(
        element.toLowerCase(),
      );
    }
    for (var element in extra_note.text.split(' ')) {
      search.add(
        element.toLowerCase(),
      );
    }

    search.add(pay_type);

    FirebaseFirestore.instance.collection('PAYMENT RECORDS').doc(m_id).set({
      'payment_id': m_id,
      'plot_no': sel_property!.plot_no,
      'paid_for': pay_type,
      'paid_amount': amount.text,
      'transaction_id': trasnsaction_id.text.split(','),
      'transactoin_reciept': reciept_url,
      'extra_note': extra_note.text,
      'discount_id': '',
      'registeredby': currentUser!.email_address,
      'request_date': DateTime.now(),
      'confirm_date': confirm_payment
          ? DateTime.now()
          : DateTime.parse('1969-07-20 20:18:04Z'),
      'handler': sel_property!.property_handler,
      'request_by': client_email,
      'search_query': search,
      'confirm_status': confirm_payment,
      'payment_status': confirm_payment ? 'Varified' : 'Waiting',
    });

    if (confirm_payment) {
      FirebaseFirestore.instance
          .collection('PROPERTY REPO')
          .doc(sel_property!.plot_no)
          .collection('PAYMENT RECORDS')
          .doc(m_id)
          .set({
        'payment_id': m_id,
        'plot_no': sel_property!.plot_no,
        'paid_amount': amount.text,
        'search_query': search,
        'confirm_date': DateTime.now(),
        'confirm_status': confirm_payment,
        'payment_status': confirm_payment ? 'Varified' : 'Waiting',
      });
      FirebaseFirestore.instance
          .collection('PROPERTY REPO')
          .doc(sel_property!.plot_no)
          .update({
        'status': getStatus(),
        'property_owner': getOwner(),
        'property_tenants': FieldValue.arrayUnion(getTenant())
      });
      DocumentSnapshot acc_doc = await FirebaseFirestore.instance
          .collection('PROPERTY REPO')
          .doc(sel_property!.plot_no)
          .collection('PAYMENT ACCOUNT')
          .doc(client_email)
          .get();
      if (acc_doc.exists) {
        PaymentAccountF paf = PaymentAccountF.fromDocument(acc_doc);
        FirebaseFirestore.instance
            .collection('PROPERTY REPO')
            .doc(sel_property!.plot_no)
            .collection('PAYMENT ACCOUNT')
            .doc(client_email)
            .update({
          'payments_id': FieldValue.arrayUnion([m_id]),
          'paid_amount':
              "${double.parse(paf.paid_amount) + double.parse(amount.text)}",
          'outstanding_amount': getOutStanding(
                  double.parse(paf.paid_amount) + double.parse(amount.text),
                  double.parse(paf.total_amount_num))
              .toString(),
          'paid_complete': getPaidStatus(
              double.parse(paf.paid_amount) + double.parse(amount.text),
              double.parse(paf.total_amount_num))
        });
      } else {
        FirebaseFirestore.instance
            .collection('PROPERTY REPO')
            .doc(sel_property!.plot_no)
            .collection('PAYMENT ACCOUNT')
            .doc(client_email)
            .set({
          'client_email': client_email,
          'payments_id': [m_id],
          'total_amount_num': sel_property!.amount,
          'paid_amount': amount.text.toString(),
          'outstanding_amount': getOutStanding(
              double.parse(amount.text.toString()),
              double.parse(sel_property!.amount)),
          'paid_complete': getPaidStatus(double.parse(amount.text.toString()),
              double.parse(sel_property!.amount))
        });
      }
      DocumentSnapshot own_p = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(client_email)
          .collection('OWN PROPERTY')
          .doc(plot_no.text.toUpperCase())
          .get();
      if (!own_p.exists) {
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(client_email)
            .collection('OWN PROPERTY')
            .doc(plot_no.text.toUpperCase())
            .set({
          'plot_no': plot_no.text.toUpperCase(),
          'date_reg': DateTime.now(),
          'search_query': [
            plot_no.text.toLowerCase(),
          ],
        });
      }
    }

    if (sel_property!.property_handler.isNotEmpty) {
      String id = Uuid().v4();
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(sel_property!.property_handler)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': sel_property!.plot_no + "|" + m_id,
        'activity_type': 'CLIENT PAYMENT RECORDS',
        'activity_title': '${pay_type} registerd for ${sel_property!.plot_no}',
        'activity_content': extra_note.text.isNotEmpty ? extra_note.text : "",
        'activity_sq': search,
        'activity_date': DateTime.now(),
        'activity_read': false,
        'activity_user': currentUser!.email_address
      });
    }
    if (client_email.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(client_email)
          .collection('PAYMENT RECORDS')
          .doc(m_id)
          .set({
        'payment_id': m_id,
        'plot_no': sel_property!.plot_no,
        'paid_amount': amount.text.toString(),
        'search_query': search,
        'confirm_date': DateTime.now(),
        'confirm_status': confirm_payment,
        'payment_status': confirm_payment ? 'Varified' : 'Waiting',
      });
      String id = Uuid().v4();
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(client_email)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': m_id,
        'activity_type': 'PAYMENT RECORDS',
        'activity_title': '${pay_type} registerd for ${sel_property!.plot_no}',
        'activity_content': extra_note.text.isNotEmpty ? extra_note.text : "",
        'activity_sq': search,
        'activity_date': DateTime.now(),
        'activity_read': false,
        'activity_user': currentUser!.email_address
      });
    }
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.email_address)
        .collection('REGISTERED PAYMENT RECORDS')
        .doc(m_id)
        .set({
      'payment_id': m_id,
      'plot_no': sel_property!.plot_no,
      'paid_amount': amount.text.toString(),
      'search_query': search,
      'confirm_date': DateTime.now(),
      'confirm_status': confirm_payment,
      'payment_status': confirm_payment ? 'Varified' : 'Waiting',
    });

    showSnackBar(context);
    setState(() {
      is_registring = false;
      plot_id_search = '';
      plot_no.text = '';
      extra_note.text = '';
      user_email.text = '';
      email_address = '';
      sel_property = null;
      sel_property_no = '';
      client = null;
      client_email = '';
      amount.text = '';
      trasnsaction_id.text = '';
      id_filebyte.clear();
      id_filename.clear();
      confirm_payment = false;
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

  getPaidStatus(double parse, double parse2) {
    if (parse == parse2) {
      return 'Completed';
    } else if (parse > parse2) {
      return 'Exceeded';
    } else if (parse < parse2) {
      return 'Remaining';
    } else {
      return 'Remaining';
    }
  }
}
