import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubairgo/configs/time.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:ubairgo/widgets/chat_screenf.dart';

import '../model/messeages.dart';
import '../styles/colors.dart';
import 'chat_screen.dart';

class MessengerWidget extends StatefulWidget {
  @override
  State<MessengerWidget> createState() => _MessengerWidgetState();
}

class _MessengerWidgetState extends State<MessengerWidget> {
  var search_textfield;
  SysConstants sys_constants = SysConstants();

  UserF? sel_user;
  String selrecentId = '';

  bool isback = false;

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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: width,
                          height: 50,
                          child: searchBar(50, width),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.sort),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                      width: width,
                      height: height,
                      child: recentChats(width, height, 'Phone')),
                ),
              ],
            ),
          ),
        ),
        tablet: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: width,
                          height: 50,
                          child: searchBar(50, width),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.sort),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                      width: width,
                      height: height,
                      child: recentChats(width, height, 'Tablet')),
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
                flex: 4,
                child: Container(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: width,
                                  height: 50,
                                  child: searchBar(50, width),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.sort),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              width: width,
                              height: height,
                              child: recentChats(width, height, 'Computer')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  width: width,
                  height: height,
                  color: Colors.grey.shade100,
                  // ignore: dead_code
                  child: sel_user == null
                      ?
                      // ignore: dead_code
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 450,
                              child: sys_constants.imgHolder(400, work_chat),
                            )
                          ],
                        )
                      : ChatWidgetF(
                          is_back: isback,
                          user_model: sel_user,
                        ),
                ),
              ),
            ],
          ),
        ),
        computer: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: width,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: width,
                                    height: 50,
                                    child: searchBar(50, width),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.sort),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                                width: width,
                                height: height,
                                child: recentChats(width, height, 'Computer')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.grey.shade100,
                    // ignore: dead_code
                    child: sel_user == null
                        ?
                        // ignore: dead_code
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 450,
                                child: sys_constants.imgHolder(400, work_chat),
                              )
                            ],
                          )
                        : ChatWidgetF(
                            is_back: isback,
                            user_model: sel_user,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> recentChats(
      double width, double height, String s) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('REG USERS')
            .doc(currentUser!.email_address)
            .collection('RECENT CHATS')
            .orderBy('messageTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return noRecentChat();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: sys_constants.imgHolder(250, loading),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.length >= 1) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  RecentChatModel recent =
                      RecentChatModel.fromDocument(snapshot.data!.docs[index]);

                  return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('CHAT SPACE')
                          .doc(recent.messageSpaceId)
                          .collection('CHAT')
                          .doc(recent.messageId)
                          .get(),
                      builder: (context, msgsnapshot) {
                        if (msgsnapshot.hasData &&
                            msgsnapshot.data != null &&
                            msgsnapshot.data!.exists) {
                          MessageF msg =
                              MessageF.fromDocument(msgsnapshot.data!);
                          TimeConverter time = TimeConverter();
                          String msgtime = time.readTimestamp(msg.time.seconds);
                          return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('USERS')
                                  .doc(
                                      (msg.sender != currentUser!.email_address)
                                          ? msg.sender
                                          : msg.receiver)
                                  .get(),
                              builder: (context, usrsnapshot) {
                                if (usrsnapshot.hasData &&
                                    usrsnapshot.data != null &&
                                    usrsnapshot.data!.exists) {
                                  UserF userf =
                                      UserF.fromDocument(usrsnapshot.data!);

                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: TextButton(
                                      onPressed: () {
                                        if (s == 'Computer' ||
                                            s == 'LargeTablet') {
                                          setState(() {
                                            isback = false;
                                            sel_user = userf;
                                            selrecentId = recent.messageSpaceId;
                                          });
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ChatWidgetF(
                                                is_back: true,
                                                user_model: userf,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: width,
                                        height: 60,
                                        color:
                                            selrecentId == recent.messageSpaceId
                                                ? sys_green
                                                : Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Container(
                                            width: width,
                                            height: 60,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Stack(
                                                    children: [
                                                      userf.profile_pic
                                                              .isNotEmpty
                                                          ? Container(
                                                              width: 45,
                                                              height: 45,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: NetworkImage(
                                                                        userf
                                                                            .profile_pic)),
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                                // ignore: prefer_const_literals_to_create_immutables
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      blurRadius:
                                                                          5),
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              width: 45,
                                                              height: 45,
                                                              decoration: BoxDecoration(
                                                                  color: sys_constants
                                                                      .getRandomColor(
                                                                          userf
                                                                              .sys_status),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  // ignore: prefer_const_literals_to_create_immutables
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            5),
                                                                  ]),
                                                              child: Center(
                                                                child: Text(
                                                                  userf
                                                                      .full_name
                                                                      .substring(
                                                                          0, 1),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          30,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                      StreamBuilder<
                                                              DocumentSnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'USERS')
                                                              .doc(userf
                                                                  .email_address)
                                                              .collection(
                                                                  'ONLINE STATUS')
                                                              .doc('status')
                                                              .snapshots(),
                                                          builder: (context,
                                                              online_snapshot) {
                                                            if (online_snapshot
                                                                    .hasData &&
                                                                snapshot.data !=
                                                                    null &&
                                                                online_snapshot
                                                                    .data!
                                                                    .exists) {
                                                              bool isonline =
                                                                  online_snapshot
                                                                      .data!
                                                                      .get(
                                                                          'online_status');
                                                              if (isonline) {
                                                                return Positioned(
                                                                  top: 0,
                                                                  right: 0,
                                                                  child:
                                                                      Container(
                                                                    width: 18,
                                                                    height: 18,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            14,
                                                                        height:
                                                                            14,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                sys_green,
                                                                            shape:
                                                                                BoxShape.circle),
                                                                        child:
                                                                            Center(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return SizedBox();
                                                              }
                                                            } else {
                                                              return SizedBox();
                                                            }
                                                          })
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    child: SizedBox(
                                                  width: width,
                                                  height: height,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: width,
                                                          height: 20,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: SizedBox(
                                                                  width: width,
                                                                  height: 20,
                                                                  child: Text(
                                                                    userf
                                                                        .full_name,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: selrecentId ==
                                                                              recent
                                                                                  .messageSpaceId
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                msgtime,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  color: selrecentId ==
                                                                          recent
                                                                              .messageSpaceId
                                                                      ? Colors
                                                                          .white70
                                                                      : Colors
                                                                          .black54,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        SizedBox(
                                                            width: width,
                                                            height: 20,
                                                            child: displayMessageUserkMsg2(
                                                                msg,
                                                                userf,
                                                                width,
                                                                height,
                                                                selrecentId ==
                                                                        recent
                                                                            .messageSpaceId
                                                                    ? 0
                                                                    : 1))
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              });
                        } else {
                          return SizedBox();
                        }
                      });
                });
          } else {
            return noRecentChat();
          }
        });
  }

  displayMessageUserkMsg2(
      MessageF msg, UserF userf, double width, double height, int index) {
    bool isread = msg.views.contains(currentUser!.email_address);
    bool isme = msg.sender == currentUser!.email_address;
    bool isattach = msg.type == 'Attachment';
    bool isproperty = msg.type == 'Property';

    return SizedBox(
      width: width,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isme ? 'Me:' : userf.full_name.split(' ').first + ":",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: index == 0 ? Colors.white70 : Colors.black54,
            ),
          ),
          contentIcon(index, isattach, isproperty),
          SizedBox(
            width: 2,
          ),
          Expanded(
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    msg.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: index == 0 ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          isread
              ? SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      color: sys_green, borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      'new',
                      style: TextStyle(
                        color: index == 0 ? Colors.white70 : Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget contentIcon(int index, bool isa, bool isp) {
    if (isa) {
      return Icon(
        Icons.file_present_rounded,
        color: index == 0 ? Colors.white70 : Colors.black54,
        size: 15,
      );
    } else if (isp) {
      return Icon(
        Icons.real_estate_agent,
        color: index == 0 ? Colors.white70 : Colors.black54,
        size: 15,
      );
    } else {
      return SizedBox();
    }
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
                width: 50,
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

  getMsgIcon(MessageModel msg) {
    if (msg.msg_type == 'img') {
      return Icon(
        Icons.image,
        size: 15,
        color: Colors.grey,
      );
    } else if (msg.msg_type == 'shared_house') {
      return Icon(
        Icons.real_estate_agent,
        size: 15,
        color: Colors.grey,
      );
    } else {
      return SizedBox();
    }
  }

  Widget noRecentChat() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: sys_constants.imgHolder(250, group_chat),
        )
      ],
    );
  }
}
