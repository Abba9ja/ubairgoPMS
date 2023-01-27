// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ubairgo/model/messeages.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/widgets/message_container.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../configs/time.dart';
import '../functions/sys_constants.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';

class ChatWidgetF extends StatefulWidget {
  UserF? user_model;
  bool? is_back;
  ChatWidgetF({
    required this.user_model,
    required this.is_back,
  });
  @override
  State<ChatWidgetF> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidgetF> {
  SysConstants sys_constants = SysConstants();

  TextEditingController msg_textfield = TextEditingController();

  bool showAttach = false;

  bool isUploading = false;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    checkSpace();
    super.initState();
    setOnline();
    checkOnline();
  }

  @override
  void dispose() {
    disposeOnline();
    msg_textfield.dispose();
    super.dispose();
  }

  void checkSpace() async {
    DocumentSnapshot channelSpacedoc = await FirebaseFirestore.instance
        .collection('CHAT SPACE')
        .doc(getChatRoomId(
            widget.user_model!.email_address, currentUser!.email_address))
        .get();
    if (!channelSpacedoc.exists) {
      FirebaseFirestore.instance
          .collection('CHAT SPACE')
          .doc(getChatRoomId(
              widget.user_model!.email_address, currentUser!.email_address))
          .set({
        'users': [widget.user_model!.email_address, currentUser!.email_address]
      });
    }
    setOnline();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return '$b\_$a';
    } else {
      return '$a\_$b';
    }
  }

  void setOnline() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.email_address)
        .collection('ONLINE STATUS')
        .doc('status')
        .get();
    if (doc.exists) {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.email_address)
          .collection('ONLINE STATUS')
          .doc('status')
          .update({
        'online_status': true,
        'online_time': DateTime.now(),
      });
    } else {
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.email_address)
          .collection('ONLINE STATUS')
          .doc('status')
          .set({
        'online_status': true,
        'online_time': DateTime.now(),
      });
    }
  }

  void disposeOnline() {
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.user_model!.email_address)
        .collection('ONLINE STATUS')
        .doc('status')
        .update({
      'online_status': false,
      'online_time': DateTime.now(),
    });
  }

  bool isonline = false;
  void checkOnline() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.email_address)
        .collection('ONLINE STATUS')
        .doc('status')
        .get();
    if (doc.exists) {
      setState(() {
        isonline = doc.get('online_status');
      });
    } else {
      setState(() {
        isonline = false;
      });
    }
  }

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
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: (widget.user_model != null)
              ? SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: width,
                        height: height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: SizedBox(
                                width: width,
                                height: 100,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: width,
                                        height: 100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            (widget.is_back!)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                            Icons.chevron_left),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.call,
                                                          color: sys_green,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.call,
                                                      color: sys_green,
                                                      size: 20,
                                                    ),
                                                  ),
                                            Text(
                                              widget.user_model!.full_name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: black),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  widget.user_model!.status,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(width: 3),
                                                (widget.user_model!.is_verified)
                                                    ? Icon(Icons.verified,
                                                        size: 15,
                                                        color: Colors.grey)
                                                    : SizedBox()
                                              ],
                                            ),
                                            /* IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                    Icons.call,
                                                                    color:
                                                                        sys_green,
                                                                    size: 20,
                                                                  ),
                                                                ),*/
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: widget.user_model!
                                                            .profile_pic.isEmpty
                                                        ? sys_constants
                                                            .getRandomColor(
                                                                widget
                                                                    .user_model!
                                                                    .sys_status)
                                                        : Colors.white,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            widget.user_model!
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
                                                  child: widget.user_model!
                                                          .profile_pic.isEmpty
                                                      ? Center(
                                                          child: Text(
                                                            widget.user_model!
                                                                .full_name
                                                                .split(' ')[0]
                                                                .split('')[0],
                                                            style: TextStyle(
                                                                fontSize: 40,
                                                                color: white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ),
                                                isonline
                                                    ? Positioned(
                                                        top: 0,
                                                        left: 0,
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  shape: BoxShape
                                                                      .circle),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              sys_constants.ratingValue(
                                                  widget.user_model!.rate,
                                                  false),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: width,
                              height: height,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('CHAT SPACE')
                                        .doc(getChatRoomId(
                                            widget.user_model!.email_address,
                                            currentUser!.email_address))
                                        .collection('CHAT')
                                        .orderBy('time', descending: true)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.none) {
                                        //print('none');
                                        return waitingWidget(width, height);
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        //print('waiting');
                                        return waitingWidget(width, height);
                                      }

                                      if (snapshot.hasData &&
                                          snapshot.data != null &&
                                          snapshot.data!.docs.length > 0) {
                                        return ListView.builder(
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            reverse: true,
                                            itemBuilder: (context, index) {
                                              MessageF msg =
                                                  MessageF.fromDocument(snapshot
                                                      .data!.docs[index]);

                                              return Slidable(
                                                key: const ValueKey(0),
                                                endActionPane: ActionPane(
                                                  // A motion is a widget used to control how the pane animates.
                                                  motion: const ScrollMotion(),

                                                  // A pane can dismiss the Slidable.

                                                  // All actions are defined in the children parameter.
                                                  children: [
                                                    // A SlidableAction can have an icon and/or a label.

                                                    SlidableAction(
                                                      onPressed: (BuildContext
                                                          context) {
                                                        deleteMessage(msg);
                                                      },
                                                      backgroundColor:
                                                          Color(0xFFFE4A49),
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      label: 'Delete',
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  child: SizedBox(
                                                    width: width,
                                                    child: Row(
                                                      mainAxisAlignment: msg
                                                                  .sender ==
                                                              currentUser!
                                                                  .email_address
                                                          ? MainAxisAlignment
                                                              .end
                                                          : MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        messageWidget(
                                                            width, height, msg)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 250,
                                                child: sys_constants.imgHolder(
                                                    250, work_chat)),
                                          ],
                                        );
                                      }
                                    }),
                              ),
                            )),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: MessegeContainer(
                          user_model: widget.user_model,
                        ),
                      ),
                    ],
                  ),
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
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.real_estate_agent,
                          size: 20,
                        ),
                        label: Text(
                          'Become a Realtor',
                        ))
                  ],
                ),
        ),
      ),
    );
  }

  Container messageContainer(double width, double height) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400, offset: Offset(0, 0), blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Container(
                  height: height,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextField(
                      controller: msg_textfield,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        prefix: SizedBox(
                          width: 45,
                          height: 45,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                showAttach = true;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Message',
                        hintStyle: const TextStyle(
                            fontSize: 14, color: Colors.black45),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
                color: sys_green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget waitingWidget(double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 250, child: sys_constants.imgHolder(250, work_chat)),
      ],
    );
  }

  void deleteMessage(MessageF msg) {}

  messageWidget(double width, double height, MessageF msg) {
    if (!(msg.sender != currentUser!.email_address) &&
        !msg.views.contains(currentUser!.email_address)) {
      FirebaseFirestore.instance
          .collection('CHAT SPACE')
          .doc(getChatRoomId(
              widget.user_model!.email_address, currentUser!.email_address))
          .collection('CHAT')
          .doc(msg.id)
          .update({
        'views': FieldValue.arrayUnion([
          currentUser!.email_address,
        ]),
      });
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.user_model!.email_address)
          .collection('RECENT CHATS')
          .doc(getChatRoomId(
              widget.user_model!.email_address, currentUser!.email_address))
          .update({
        'messageViews': FieldValue.arrayUnion([
          currentUser!.email_address,
        ]),
      });
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.email_address)
          .collection('RECENT CHATS')
          .doc(getChatRoomId(
              widget.user_model!.email_address, currentUser!.email_address))
          .update({
        'messageViews': FieldValue.arrayUnion([
          currentUser!.email_address,
        ]),
      });
    }
    if (msg.type == 'Property') {
      return Container(
        decoration: BoxDecoration(
          color: msg.sender == currentUser!.email_address
              ? sys_green
              : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 1)
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: msg.sender == currentUser!.email_address
                ? Radius.circular(15)
                : Radius.circular(0),
            bottomRight: msg.sender == currentUser!.email_address
                ? Radius.circular(0)
                : Radius.circular(15),
          ),
        ),
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              SizedBox(
                width: 400,
                height: 400,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('CHAT SPACE')
                        .doc(getChatRoomId(widget.user_model!.email_address,
                            currentUser!.email_address))
                        .collection('CHAT')
                        .doc(msg.id)
                        .collection('Property')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, msg_p_snapshot) {
                      if (msg_p_snapshot.hasData &&
                          msg_p_snapshot.data != null &&
                          msg_p_snapshot.data!.docs.length > 0) {
                        return ListView.builder(
                            itemCount: msg_p_snapshot.data!.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              MessagePropertyF mpf =
                                  MessagePropertyF.fromDocument(
                                      msg_p_snapshot.data!.docs[index]);
                              return StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('PROPERTY REPO')
                                    .doc(mpf.plot_no.toUpperCase())
                                    .snapshots(),
                                builder: (context, pr_snapshot) {
                                  if (pr_snapshot.hasData &&
                                      pr_snapshot.data != null &&
                                      pr_snapshot.data!.exists) {
                                    PropertyF property = PropertyF.fromDocument(
                                        pr_snapshot.data!);

                                    return SizedBox(
                                      width: 400,
                                      height: 400,
                                      child: Container(
                                        width: width,
                                        height: height,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          width: width,
                                                          height: height,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            image:
                                                                DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      property
                                                                          .featured_img,
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  blurRadius:
                                                                      1.5),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 55,
                                                    width: width,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          20, 10, 10, 10),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          viewProperty(
                                                              property);
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "₦${property.amount}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color:
                                                                          black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      "${property.size} m²",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ],
                                                                )
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
                                                height: 110,
                                                width: width,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          gradient: property
                                                                      .status ==
                                                                  'For Sale'
                                                              ? LinearGradient(
                                                                  colors: [
                                                                      sys_green,
                                                                      sys_green,
                                                                      tp1sys_green,
                                                                      tp1sys_green,
                                                                      tp1sys_green
                                                                    ])
                                                              : LinearGradient(
                                                                  colors: [
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .blue,
                                                                      Colors
                                                                          .blue,
                                                                      Color.fromARGB(
                                                                          226,
                                                                          33,
                                                                          149,
                                                                          243),
                                                                      Color.fromARGB(
                                                                          226,
                                                                          33,
                                                                          149,
                                                                          243),
                                                                    ])),
                                                      child: Center(
                                                        child: Text(
                                                          property.status,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 3,
                                                      height: 70,
                                                      color: property.status ==
                                                              'For Sale'
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
                                  } else {
                                    return Card(
                                        color: Colors.blue,
                                        child: SizedBox(
                                          width: 400,
                                          height: 400,
                                        ));
                                  }
                                },
                              );
                            });
                      } else {
                        return SizedBox();
                      }
                    }),
              ),
              contentView(msg),
            ],
          ),
        ),
      );
    } else if (msg.type == 'Attachment') {
      return Container(
        decoration: BoxDecoration(
          color: msg.sender == currentUser!.email_address
              ? sys_green
              : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 1)
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: msg.sender == currentUser!.email_address
                ? Radius.circular(15)
                : Radius.circular(0),
            bottomRight: msg.sender == currentUser!.email_address
                ? Radius.circular(0)
                : Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('CHAT SPACE')
                      .doc(getChatRoomId(widget.user_model!.email_address,
                          currentUser!.email_address))
                      .collection('CHAT')
                      .doc(msg.id)
                      .collection('ATTACHMENT')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, msg_p_snapshot) {
                    if (msg_p_snapshot.hasData &&
                        msg_p_snapshot.data != null &&
                        msg_p_snapshot.data!.docs.length > 0) {
                      MessageAttachmentF maf = MessageAttachmentF.fromDocument(
                          msg_p_snapshot.data!.docs[0]);

                      return SizedBox(
                        width: 400,
                        height: 400,
                        child: Stack(
                          children: [
                            attachementView(maf),
                            msg_p_snapshot.data!.docs.length > 1
                                ? Positioned(
                                    bottom: 15,
                                    right: 15,
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: sys_green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            viewAttachment(maf);
                                          },
                                          child: Text(
                                            "+${msg_p_snapshot.data!.docs.length}",
                                            style: TextStyle(
                                                fontSize: 14, color: white),
                                          )),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
              contentView(msg),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: msg.sender == currentUser!.email_address
              ? sys_green
              : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 1)
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: msg.sender == currentUser!.email_address
                ? Radius.circular(15)
                : Radius.circular(0),
            bottomRight: msg.sender == currentUser!.email_address
                ? Radius.circular(0)
                : Radius.circular(15),
          ),
        ),
        child: contentView(msg),
      );
    }
  }

  Widget attachementView(MessageAttachmentF maf) {
    if (maf.file_name.toLowerCase().contains('.ppt') ||
        maf.file_name.toLowerCase().contains('.pptx') ||
        maf.file_name.toLowerCase().contains('.doc') ||
        maf.file_name.toLowerCase().contains('.docx') ||
        maf.file_name.toLowerCase().contains('.xls') ||
        maf.file_name.toLowerCase().contains('.xlsx')) {
      return SizedBox(
        width: 400,
        height: 400,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              "https://view.officeapps.live.com/op/embed.aspx?src=${maf.file_url}",
        ),
      );
    } else if (maf.file_name.toLowerCase().contains('pdf')) {
      return SizedBox(
        width: 400,
        height: 400,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: maf.file_url,
        ),
      );

      // 'asse
    } else if (maf.file_name.toLowerCase().contains('.png') ||
        maf.file_name.toLowerCase().contains('.PNG') ||
        maf.file_name.toLowerCase().contains('.jpeg') ||
        maf.file_name.toLowerCase().contains('.JPEG') ||
        maf.file_name.toLowerCase().contains('.jpg') ||
        maf.file_name.toLowerCase().contains('.JPG') ||
        maf.file_name.toLowerCase().contains('.webp')) {
      return Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage(maf.file_url))),
      );
    } else {
      return SizedBox(
          width: 400,
          height: 400,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                _launchUrl(Uri.parse(maf.file_url));
              },
              child: Text('Open'),
            ),
          ));
    }
  }

  Widget contentView(MessageF msg) {
    TimeConverter _tm = TimeConverter();
    String time = _tm.readTimestamp(msg.time.seconds);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: msg.sender == currentUser!.email_address
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          msg.content.isNotEmpty
              ? Text(
                  msg.content,
                  style: TextStyle(
                      color: msg.sender == currentUser!.email_address
                          ? white
                          : black,
                      fontSize: 16),
                )
              : SizedBox(),
          Row(
            children: [
              Text(
                time,
                style: TextStyle(
                    color: msg.sender == currentUser!.email_address
                        ? white
                        : black,
                    fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  void viewProperty(PropertyF property) {}

  void _launchUrl(Uri parse) {}

  void viewAttachment(MessageAttachmentF maf) {}
}
