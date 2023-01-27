import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../model/property_model.dart';
import '../screens/splash.dart';
import '../styles/sysimg_constants.dart';

class MessegeContainer extends StatefulWidget {
  UserF? user_model;

  MessegeContainer({
    required this.user_model,
  });
  @override
  State<MessegeContainer> createState() => _MessegeContainerState();
}

class _MessegeContainerState extends State<MessegeContainer> {
  TextEditingController msg_textfield = TextEditingController();

  bool showAttach = false;

  bool isUploading = false;

  var sys_constants;

  TextEditingController add_plot_txt = TextEditingController();

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return '$b\_$a';
    } else {
      return '$a\_$b';
    }
  }

  bool property_view = false;

  List<Uint8List> id_filebyte = [];
  List<dynamic> id_filename = [];
  dynamic _pickImageError;

  pickIDPressed() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
          'pdf',
        ],
      );
      if (result != null) {
        List<Uint8List> l_file = result.files.map((e) => e.bytes!).toList();
        List<dynamic> l_filename = result.files.map((e) => e.name).toList();
        setState(() {
          id_filebyte = l_file;
          id_filename = l_filename;
          hide_addbtns = true;
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

  bool hide_addbtns = false;

  Future<bool> checkOnline() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.user_model!.email_address)
        .collection('ONLINE STATUS')
        .doc('status')
        .get();
    if (doc.exists) {
      return doc.get('online_status');
    } else {
      return false;
    }
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
            showAttach && !hide_addbtns
                ? Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              property_view = true;
                              hide_addbtns = true;
                            });
                          },
                          icon: Icon(
                            Icons.add_home,
                            color: sys_green,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        child: IconButton(
                          onPressed: () {
                            pickIDPressed();
                          },
                          icon: Icon(
                            Icons.file_present,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                : SizedBox(),
            TextButton(
              onPressed: () {
                if (showAttach) {
                  setState(() {
                    showAttach = false;
                  });
                } else {
                  setState(() {
                    showAttach = true;
                  });
                }
              },
              child:
                  Icon(showAttach && !hide_addbtns ? Icons.close : Icons.add),
            ),
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
                        border: InputBorder.none,
                        hintText: showAttach ? 'Caption' : 'Message',
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
              child: !is_sending
                  ? IconButton(
                      onPressed: () {
                        if (property_list.isNotEmpty) {
                          sendMessage('Property');
                        } else if (id_filebyte.isNotEmpty) {
                          sendMessage('Attachment');
                        } else {
                          sendMessage('txt');
                        }
                      },
                      icon: Icon(Icons.arrow_forward),
                      color: sys_green,
                    )
                  : SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(
                        color: sys_green,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  bool is_sending = false;
  void sendMessage(String s) async {
    String msg_id = Uuid().v4();
    bool isonline = await checkOnline();

    List<String> views = [];
    if (isonline) {
      views.add(widget.user_model!.email_address);
    }
    views.add(currentUser!.email_address);
    setState(() {
      is_sending = true;
    });
    FirebaseFirestore.instance
        .collection('CHAT SPACE')
        .doc(getChatRoomId(
            widget.user_model!.email_address, currentUser!.email_address))
        .collection('CHAT')
        .doc(msg_id)
        .set({
      'id': msg_id,
      'type': s,
      'content': msg_textfield.text,
      'sender': currentUser!.email_address,
      'receiver': widget.user_model!.email_address,
      'time': DateTime.now(),
      'views': views,
      'search_query': msg_textfield.text.toString().toLowerCase().split(' ')
    });
    if (property_ids.isNotEmpty) {
      for (var plot_no in property_ids) {
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('CHAT SPACE')
            .doc(getChatRoomId(
                widget.user_model!.email_address, currentUser!.email_address))
            .collection('CHAT')
            .doc(msg_id)
            .collection(s)
            .doc(id)
            .set({
          'id': id,
          'plot_no': plot_no,
          'caption': '',
          'time': DateTime.now()
        });
      }
    }
    if (id_filebyte.isNotEmpty) {
      for (var i = 0; i < id_filebyte.length; i++) {
        String id = Uuid().v4();
        String download_url =
            await uploadPPFileWeb(id_filebyte[i], id_filename[i]);
        FirebaseFirestore.instance
            .collection('CHAT SPACE')
            .doc(getChatRoomId(
                widget.user_model!.email_address, currentUser!.email_address))
            .collection('CHAT')
            .doc(msg_id)
            .collection(s)
            .doc(id)
            .set({
          'id': id,
          'file_name': id_filename[i],
          'file_url': download_url,
          'time': DateTime.now(),
          'alt': '',
        });
      }
    }

    if (!isonline) {
      String a_id = Uuid().v4();
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(widget.user_model!.email_address)
          .collection('ACTIVITIES')
          .doc(a_id)
          .set({
        'id': a_id,
        'activity_id': getChatRoomId(
            widget.user_model!.email_address, currentUser!.email_address),
        'activity_type': 'MESSAGE TYPE ${s.toUpperCase()}',
        'activity_title': '${s} shared with you vai messenger',
        'activity_content': msg_textfield.text.isNotEmpty
            ? msg_textfield.text
            : id_filebyte.isNotEmpty
                ? ' ${id_filebyte.length} ${s} shared, view now!'
                : '${property_ids.length} ${s} shared, view now!',
        'activity_sq': msg_textfield.text.toString().split(''),
        'activity_date': DateTime.now(),
        'activity_read': false,
        'activity_user': currentUser!.email_address
      });
    }

    FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.user_model!.email_address)
        .collection('RECENT CHATS')
        .doc(getChatRoomId(
            widget.user_model!.email_address, currentUser!.email_address))
        .set({
      'messageId': msg_id,
      'messageFrom': 'CHAT',
      'messageSpaceId': getChatRoomId(
          widget.user_model!.email_address, currentUser!.email_address),
      'messageTime': DateTime.now(),
      'messageSender': currentUser!.email_address,
      'messageReciever': widget.user_model!.email_address,
      'messageViews': [
        currentUser!.email_address,
      ],
      'search_query': msg_textfield.text.toString().toLowerCase().split(' ')
    });
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(currentUser!.email_address)
        .collection('RECENT CHATS')
        .doc(getChatRoomId(
            widget.user_model!.email_address, currentUser!.email_address))
        .set({
      'messageId': msg_id,
      'messageFrom': 'CHAT',
      'messageSpaceId': getChatRoomId(
          widget.user_model!.email_address, currentUser!.email_address),
      'messageTime': DateTime.now(),
      'messageSender': currentUser!.email_address,
      'messageReciever': widget.user_model!.email_address,
      'messageViews': [
        currentUser!.email_address,
      ],
      'search_query': msg_textfield.text.toString().toLowerCase().split(' ')
    });

    setState(() {
      is_sending = false;
      msg_textfield.text = '';
      id_filebyte.clear();
      id_filename.clear();
      property_view = false;
      property_ids.clear();
      property_list.clear();
      showAttach = false;
      hide_addbtns = true;
    });
  }

  uploadPPFileWeb(Uint8List id_filebyte, dynamic id_filename) async {
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
      showSnackBar(context, e.code);
      // e.g, e.code == 'canceled'
      /* setState(() {
        is_registring = false;
      });*/
    }
  }

  void showSnackBar(
    BuildContext context,
    String s,
  ) {
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
          Text(s),
        ],
      ),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      width: 400,
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String plot_id_search = '';

  Container addHomeBar(double height, double width) {
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
              child: Container(
                height: height,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: TextFormField(
                    controller: add_plot_txt,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Plot ID',
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                    onSaved: (value) {
                      setState(() {
                        plot_id_search = value!;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        plot_id_search = value;
                      });
                    },
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
                    color: sys_green, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    setState((() {
                      plot_id_search = add_plot_txt.text;
                    }));
                  },
                  child: Icon(
                    Icons.add_home,
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

  List<PropertyF> property_list = [];
  List<String> property_ids = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      height: id_filebyte.isNotEmpty || property_view ? 600 : 50,
      child: Column(
        children: [
          id_filebyte.isNotEmpty || property_view
              ? Expanded(
                  child: SizedBox(
                      width: width,
                      height: height,
                      child: id_filebyte.isNotEmpty
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          id_filebyte.clear();
                                          id_filename.clear();
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
                                      child: ScaledList(
                                        itemCount: id_filebyte.length,
                                        itemColor: (index) {
                                          return sys_green;
                                        },
                                        itemBuilder: (index, selectedIndex) {
                                          return Container(
                                            width: width,
                                            height: selectedIndex == index
                                                ? 800
                                                : 600,
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
                                                  child: getFileView(
                                                      width,
                                                      height,
                                                      id_filebyte[index],
                                                      id_filename[index],
                                                      selectedIndex == index
                                                          ? true
                                                          : false),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                ),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: width,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              property_view = false;
                                              property_ids.clear();
                                              property_list.clear();
                                            });
                                          },
                                          icon: Icon(Icons.close),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            width: width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                              child: addHomeBar(50, width),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    height: height,
                                    width: width,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('PROPERTY REPO')
                                            .where('search_query',
                                                arrayContains: plot_id_search)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null &&
                                              snapshot.data!.docs.length > 0) {
                                            return ScaledList(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemColor: (index) {
                                                return sys_green;
                                              },
                                              itemBuilder:
                                                  (index, selectedIndex) {
                                                PropertyF property =
                                                    PropertyF.fromDocument(
                                                        snapshot
                                                            .data!.docs[index]);
                                                return Container(
                                                  width: width,
                                                  height: selectedIndex == index
                                                      ? 800
                                                      : 600,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(0, 0),
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
                                                                              .all(
                                                                          5.0),
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
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                            property.featured_img,
                                                                          ),
                                                                          fit: BoxFit.cover),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors
                                                                                .grey,
                                                                            offset: Offset(0,
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
                                                              height: 55,
                                                              width: width,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        20,
                                                                        10,
                                                                        10,
                                                                        10),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            property.plot_no.toString().toUpperCase(),
                                                                            maxLines:
                                                                                1,
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: black),
                                                                          ),
                                                                          Text(
                                                                            "${property.size} m²",
                                                                            style:
                                                                                TextStyle(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                        ],
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
                                                          height: 100,
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
                                                                height: 70,
                                                                color: property
                                                                            .status ==
                                                                        'For Sale'
                                                                    ? sys_green
                                                                    : Colors
                                                                        .blue,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: Card(
                                                          child: SizedBox(
                                                            width: 45,
                                                            height: 45,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                if (property_ids
                                                                    .contains(
                                                                        property
                                                                            .plot_no)) {
                                                                  setState(() {
                                                                    property_list
                                                                        .remove(
                                                                            property_list[index]);
                                                                    property_ids
                                                                        .remove(
                                                                            property_ids[index]);
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    property_ids.add(
                                                                        property
                                                                            .plot_no);
                                                                    property_list
                                                                        .add(
                                                                            property);
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon((property_ids
                                                                      .contains(
                                                                          property
                                                                              .plot_no))
                                                                  ? Icons
                                                                      .check_box
                                                                  : Icons
                                                                      .check_box_outline_blank),
                                                              color: (property_ids
                                                                      .contains(
                                                                          property
                                                                              .plot_no))
                                                                  ? sys_green
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: 200,
                                                    child: Image(
                                                        image: AssetImage(
                                                          houses_searching,
                                                        ),
                                                        fit: BoxFit.fitWidth))
                                              ],
                                            );
                                          }
                                        }),
                                  ))
                                ],
                              ),
                            )),
                )
              : SizedBox(),
          messageContainer(width, 50),
        ],
      ),
    );
  }

  List image_filetype = [
    '.png',
    '.jpeg',
    '.jpg',
  ];
  Widget getFileIcon(int _size, String id_name) {
    if (id_name.toLowerCase().contains('.pdf')) {
      return Icon(
        FontAwesomeIcons.filePdf,
        size: _size + 0.0,
        color: Colors.red,
      );
    } else if (id_name.toLowerCase().contains('.doc')) {
      return Icon(
        FontAwesomeIcons.fileWord,
        size: _size + 0.0,
        color: Colors.blue,
      );
    } else if (id_name.toLowerCase().contains('.docs')) {
      return Icon(
        FontAwesomeIcons.fileWord,
        size: _size + 0.0,
        color: Colors.blue,
      );
    } else if (id_name.toLowerCase().contains('.docx')) {
      return Icon(
        FontAwesomeIcons.fileWord,
        size: _size + 0.0,
        color: Colors.blue,
      );
    } else if (id_name.toLowerCase().contains('.xlsx')) {
      return Icon(
        FontAwesomeIcons.fileExcel,
        size: _size + 0.0,
        color: Colors.teal,
      );
    } else if (id_name.toLowerCase().contains('.xls')) {
      return Icon(
        FontAwesomeIcons.fileExcel,
        size: _size + 0.0,
        color: Colors.teal,
      );
    } else if (id_name.toLowerCase().contains('.ppt')) {
      return Icon(
        FontAwesomeIcons.filePowerpoint,
        size: _size + 0.0,
        color: Colors.redAccent,
      );
    } else if (id_name.toLowerCase().contains('.pptx')) {
      return Icon(
        FontAwesomeIcons.filePowerpoint,
        size: _size + 0.0,
        color: Colors.redAccent,
      );
    } else {
      return Icon(
        FontAwesomeIcons.file,
        size: _size + 0.0,
        color: Colors.blue,
      );
    }
  }

  Widget getFileView(double width, double height, Uint8List id_filebyte,
      String id_name, bool sel) {
    if (id_name.contains('.png') ||
        id_name.contains('.jpeg') ||
        id_name.contains('.jpg')) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              SizedBox(
                height: height,
                width: width,
                child: Image.memory(
                  id_filebyte,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Card(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          id_filebyte.remove(
                              id_filebyte[id_filename.indexOf(id_name)]);
                          id_filename.remove(id_name);
                        });
                      },
                      icon: Icon(
                        Icons.close,
                      )),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getFileIcon(sel ? 100 : 70, id_name),
            Text(
              id_name,
              maxLines: 3,
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      );
    }
  }
}
