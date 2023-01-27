// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:uuid/uuid.dart';

import '../functions/sys_constants.dart';
import '../model/property_requestm.dart';
import '../model/user_model.dart';
import '../screens/splash.dart';
import '../styles/sysimg_constants.dart';

class RequestWidget extends StatefulWidget {
  PropertyRequestF? propertyRequestF;
  PropertyF? propertyF;

  RequestWidget({
    required this.propertyF,
    required this.propertyRequestF,
  });

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  SysConstants sys_constants = SysConstants();

  TextEditingController extra_note_request = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: 330,
      child: requestWidget(width, height),
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

  Padding requestWidget(double width, double height) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        width: width,
        height: 330,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('REQUST STATUS'),
                SizedBox(
                  height: 5,
                ),
                widget.propertyRequestF != null
                    ? StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('CLIENT PROPERTY REQUESTS')
                            .doc(widget.propertyRequestF!.request_id)
                            .snapshots(),
                        builder: (context, cprsnapshot) {
                          if (cprsnapshot.hasData &&
                              cprsnapshot.data != null &&
                              cprsnapshot.data!.exists) {
                            PropertyRequestF prf =
                                PropertyRequestF.fromDocument(
                                    cprsnapshot.data!);
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('USERS')
                                        .doc(
                                            widget.propertyRequestF!.request_by)
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
                                        UserF handler = UserF.fromDocument(
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
                                                    decoration: BoxDecoration(
                                                      color: white,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              handler
                                                                  .profile_pic),
                                                          fit: BoxFit.cover),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(0, 0),
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            handler.full_name,
                                                            style: TextStyle(
                                                              fontSize: 16,
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
                                                                handler
                                                                    .email_address,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              (handler.is_verified)
                                                                  ? Icon(
                                                                      Icons
                                                                          .verified,
                                                                      size: 15,
                                                                      color:
                                                                          sys_green)
                                                                  : SizedBox()
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      callUrl(
                                                          handler.phone_number);
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
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  (prf.status == 'Submitted')
                                      ? Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: TextFormField(
                                                cursorColor: sys_green,
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: extra_note_request,
                                                maxLines: 4,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                decoration: InputDecoration(
                                                  focusColor: sys_green,
                                                  prefixIconColor: sys_green,
                                                  prefixIcon: Icon(
                                                    Icons.edit_note,
                                                    color: sys_green,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  labelText: 'Extra note',
                                                  hintText: '',
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 25),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Card(
                                                    color: Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          declineOwnership();
                                                        },
                                                        child: Text(
                                                          'Decline',
                                                          style: TextStyle(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Card(
                                                    color: sys_green,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          approveOwnership();
                                                        },
                                                        child: Text(
                                                          'Approve',
                                                          style: TextStyle(
                                                              letterSpacing: 1,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              width: width,
                                              height: 150,
                                              child: Row(children: [
                                                SizedBox(
                                                  width: 200,
                                                  height: 200,
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        height: 200,
                                                        child: Image(
                                                          image: AssetImage(
                                                            occupied_house,
                                                          ),
                                                          width: 200,
                                                          height: 200,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        height: 200,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      50,
                                                                      50,
                                                                      0),
                                                              child: SizedBox(
                                                                width: 80,
                                                                height: 80,
                                                                child: Image(
                                                                  image:
                                                                      AssetImage(
                                                                    prf.status ==
                                                                            'Approved'
                                                                        ? approved
                                                                        : declined,
                                                                  ),
                                                                  width: 80,
                                                                  height: 80,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: width,
                                                    height: height,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        prf.extra_note
                                                                .isNotEmpty
                                                            ? Linkable(
                                                                text: prf
                                                                    .extra_note,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ]),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Card(
                                                  color: sys_green,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        clearRequest();
                                                      },
                                                      child: Text(
                                                        'Clear & Review Request',
                                                        style: TextStyle(
                                                            letterSpacing: 1,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        })
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void callUrl(String phone_number) {}

  void approveOwnership() {
    if (widget.propertyRequestF != null) {
      FirebaseFirestore.instance
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(widget.propertyRequestF!.request_id)
          .update({
        'status': 'Approved',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });
      FirebaseFirestore.instance
          .collection('PROPERTY REPO')
          .doc(widget.propertyF!.plot_no)
          .update({'property_owner': widget.propertyRequestF!.request_by});
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyRequestF!.request_by)
          .collection('OWN PROPERTY')
          .doc(widget.propertyRequestF!.plot_no.toUpperCase())
          .set({
        'plot_no': widget.propertyRequestF!.plot_no.toUpperCase(),
        'date_reg': DateTime.now(),
        'search_query': widget.propertyRequestF!.search_query,
      });
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyRequestF!.request_by)
          .collection('MY PROPERTY REQUEST')
          .doc(widget.propertyRequestF!.request_id)
          .update({
        'status': 'Approved',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyF!.registered_by)
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(widget.propertyRequestF!.request_id)
          .update({
        'status': 'Approved',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });
    }
    String id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.propertyRequestF!.request_by)
        .collection('ACTIVITIES')
        .doc(id)
        .set({
      'id': id,
      'activity_id': widget.propertyF!.plot_no,
      'activity_type': 'PROPERTY REQUEST',
      'activity_title':
          'Request on ${widget.propertyRequestF!.plot_no} APPROVE',
      'activity_content': extra_note_request.text.isNotEmpty
          ? extra_note_request.text
          : 'Management have approved your ownership request on ${widget.propertyRequestF!.plot_no}',
      'activity_sq': widget.propertyRequestF!.search_query,
      'activity_date': DateTime.now(),
      'activity_read': false,
    });
    if (widget.propertyF!.property_handler.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyF!.property_handler)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': widget.propertyF!.plot_no,
        'activity_type': 'PROPERTY REQUEST',
        'activity_title': '${widget.propertyRequestF!.plot_no} APPROVEd',
        'activity_content': extra_note_request.text.isNotEmpty
            ? extra_note_request.text
            : 'Management have approved ownership request on ${widget.propertyRequestF!.plot_no}',
        'activity_sq': widget.propertyRequestF!.search_query,
        'activity_date': DateTime.now(),
        'activity_read': false,
      });
    }
  }

  void declineOwnership() {
    if (widget.propertyRequestF != null) {
      FirebaseFirestore.instance
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(widget.propertyRequestF!.request_id)
          .update({
        'status': 'Declined',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyRequestF!.request_by)
          .collection('MY PROPERTY REQUEST')
          .doc(widget.propertyRequestF!.request_id)
          .update({
        'status': 'Declined',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyF!.registered_by)
          .collection('CLIENT PROPERTY REQUESTS')
          .doc(widget.propertyRequestF!.request_id)
          .update({
        'status': 'Decline',
        'extra_note': extra_note_request.text,
        'reviewed_by': currentUser!.email_address,
      });
    }
    String id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.propertyRequestF!.request_by)
        .collection('ACTIVITIES')
        .doc(id)
        .set({
      'id': id,
      'activity_id': widget.propertyF!.plot_no,
      'activity_type': 'PROPERTY REQUEST',
      'activity_title':
          'Request on ${widget.propertyRequestF!.plot_no} Decline',
      'activity_content': extra_note_request.text.isNotEmpty
          ? extra_note_request.text
          : 'Management have decline your ${widget.propertyRequestF!.request} request on ${widget.propertyRequestF!.plot_no}',
      'activity_sq': widget.propertyRequestF!.search_query,
      'activity_date': DateTime.now(),
      'activity_read': false,
    });
    if (widget.propertyF!.property_handler.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyF!.property_handler)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': widget.propertyF!.plot_no,
        'activity_type': 'PROPERTY REQUEST',
        'activity_title': '${widget.propertyRequestF!.plot_no} Decline',
        'activity_content': extra_note_request.text.isNotEmpty
            ? extra_note_request.text
            : 'Management have decline ${widget.propertyRequestF!.request} request on ${widget.propertyRequestF!.plot_no}',
        'activity_sq': widget.propertyRequestF!.search_query,
        'activity_date': DateTime.now(),
        'activity_read': false,
      });
    }
  }

  void clearRequest() {
    FirebaseFirestore.instance
        .collection('CLIENT PROPERTY REQUESTS')
        .doc(widget.propertyRequestF!.request_id)
        .update({
      'status': 'Submitted',
      'extra_note': '',
      'reviewed_by': currentUser!.email_address,
    });

    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.propertyRequestF!.request_by)
        .collection('MY PROPERTY REQUEST')
        .doc(widget.propertyRequestF!.request_id)
        .update({
      'status': 'Submitted',
      'extra_note': '',
      'reviewed_by': currentUser!.email_address,
    });

    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.propertyF!.registered_by)
        .collection('CLIENT PROPERTY REQUESTS')
        .doc(widget.propertyRequestF!.request_id)
        .update({
      'status': 'Submitted',
      'extra_note': '',
      'reviewed_by': currentUser!.email_address,
    });

    String id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.propertyRequestF!.request_by)
        .collection('ACTIVITIES')
        .doc(id)
        .set({
      'id': id,
      'activity_id': widget.propertyF!.plot_no,
      'activity_type': 'PROPERTY REQUEST',
      'activity_title':
          'Request on ${widget.propertyRequestF!.plot_no} have be cleared for review again',
      'activity_content': extra_note_request.text.isNotEmpty
          ? extra_note_request.text
          : 'Management have  cleared for review again your ${widget.propertyRequestF!.request} request on ${widget.propertyRequestF!.plot_no}',
      'activity_sq': widget.propertyRequestF!.search_query,
      'activity_date': DateTime.now(),
      'activity_read': false,
    });
    if (widget.propertyF!.property_handler.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.propertyF!.property_handler)
          .collection('ACTIVITIES')
          .doc(id)
          .set({
        'id': id,
        'activity_id': widget.propertyF!.plot_no,
        'activity_type': 'PROPERTY REQUEST',
        'activity_title': '${widget.propertyRequestF!.plot_no} Decline',
        'activity_content': extra_note_request.text.isNotEmpty
            ? extra_note_request.text
            : 'Management have decline ${widget.propertyRequestF!.request} request on ${widget.propertyRequestF!.plot_no}',
        'activity_sq': widget.propertyRequestF!.search_query,
        'activity_date': DateTime.now(),
        'activity_read': false,
      });
    }
  }
}
