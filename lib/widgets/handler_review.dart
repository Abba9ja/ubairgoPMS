import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/user_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:uuid/uuid.dart';

import '../model/property_model.dart';
import '../styles/sysimg_constants.dart';

class HandlerReviewWidget extends StatefulWidget {
  PropertyF? propertyF;
  String view_from;
  HandlerReviewWidget({
    required this.propertyF,
    required this.view_from,
  });

  @override
  State<HandlerReviewWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<HandlerReviewWidget> {
  SysConstants sys_constants = SysConstants();

  bool show_user = false;

  TextEditingController search_textfield = TextEditingController();

  String add_user_status = 'Property Handler';

  UserF? propertyHandle;
  String propertyHandleEmail = '';

  List<UserF> propertyTenant = [];
  List<String> propertyTenantEmails = [];

  bool show_filter = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: show_user
          ? peopleWidget(width, height)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                houseStatus(width, height),
                SizedBox(
                  height: 10,
                ),
                Text('House Handler'),
                SizedBox(
                  height: 5,
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('PROPERTY REPO')
                        .doc(widget.propertyF!.plot_no)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.exists) {
                        PropertyF pf = PropertyF.fromDocument(snapshot.data!);

                        return SizedBox(
                          width: width,
                          height: 75,
                          child: pf.property_handler.isNotEmpty
                              ? FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('USERS')
                                      .doc(pf.property_handler)
                                      .get(),
                                  builder: (context, user_snapshot) {
                                    if (user_snapshot.connectionState ==
                                        ConnectionState.none) {
                                      return sys_constants.userWview(width);
                                    }
                                    if (user_snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return sys_constants.userWview(width);
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
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              handler.status,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(width: 5),
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
                                          SizedBox(
                                            width: 110,
                                            child: Card(
                                              color: sys_green,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 5, 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    sys_constants.ratingValue(
                                                        handler.rate,
                                                        handler.is_verified),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return sys_constants.userWview(width);
                                    }
                                  })
                              : Column(
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
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 2),
                                              ],
                                            ),
                                            child: Center(
                                                child: Icon(Icons.person,
                                                    size: 50,
                                                    color: sys_green)),
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
                                                    'Handler not assign',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'hanler have\'nt been assign yet',
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
                                              Icons.real_estate_agent,
                                              color: sys_green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
                widget.view_from.isEmpty
                    ? Expanded(
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: sys_constants.imgHolder(
                                    width, realtor_pana),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                currentUser!.email_address == widget.propertyF!.registered_by
                    ? Container(
                        width: width,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.propertyF!.status == 'For Sale'
                              ? sys_green
                              : Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 0),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              show_user = true;
                            });
                          },
                          child: Center(
                              child: Text(
                            'Review Handler',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: white),
                          )),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }

  Widget houseStatus(double width, double height) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: width,
          child: Stack(
            children: [
              Positioned(
                left: 10,
                child: SizedBox(
                  height: 70,
                  width: width,
                  child: Column(
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
                        color: widget.propertyF!.status == 'For Sale'
                            ? sys_green
                            : Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 10,
                child: SizedBox(
                  height: 70,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                            gradient: widget.propertyF!.status == 'For Sale'
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
                            widget.propertyF!.status,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 50,
                        color: widget.propertyF!.status == 'For Sale'
                            ? sys_green
                            : Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "₦${widget.propertyF!.amount}",
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
      ],
    );
  }

  Widget getIconCheck(UserF registry) {
    if ((add_user_status == 'Property Handler' &&
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

  Widget userWaiting() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: sys_constants.imgHolder(150, loading),
        )
      ],
    );
  }

  Widget userNone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: sys_constants.imgHolder(150,
              add_user_status == 'Handler' ? realtor_pana : realtor_rafiki),
        )
      ],
    );
  }

  Widget peopleWidget(double width, double height) {
    return Column(
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
                  stream: FirebaseFirestore.instance
                      .collection('USERS')
                      .where('sys_status', isEqualTo: 'Estate Support')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return userNone();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    UserF registry = UserF.fromDocument(
                                        snapshot.data!.docs[index]);
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 10, 80, 5),
                                      child: SizedBox(
                                        width: width,
                                        height: 70,
                                        child: Card(
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SizedBox(
                                                  width: width,
                                                  height: 65,
                                                  child: Row(children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: registry
                                                                .profile_pic
                                                                .isEmpty
                                                            ? sys_constants
                                                                .getRandomColor(
                                                                    registry
                                                                        .sys_status)
                                                            : Colors.white,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                registry
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
                                                      child: registry
                                                              .profile_pic
                                                              .isEmpty
                                                          ? Center(
                                                              child: Text(
                                                                registry
                                                                    .full_name
                                                                    .split(
                                                                        ' ')[0]
                                                                    .split(
                                                                        '')[0],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25,
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
                                                              registry
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
                                                              height: 1,
                                                            ),
                                                            Text(
                                                              registry.status
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
                                                    child: TextButton(
                                                        onPressed: () {
                                                          if (add_user_status ==
                                                              'Property Handler') {
                                                            setState(() {
                                                              propertyHandle =
                                                                  registry;
                                                              propertyHandleEmail =
                                                                  registry
                                                                      .email_address;
                                                            });
                                                          }
                                                          if (add_user_status ==
                                                              'Property Tenants') {
                                                            if (propertyTenantEmails
                                                                .contains(registry
                                                                    .email_address)) {
                                                              setState(() {
                                                                propertyTenant.remove(
                                                                    propertyTenant[
                                                                        propertyTenantEmails
                                                                            .indexOf(registry.email_address)]);
                                                                propertyTenantEmails
                                                                    .remove(registry
                                                                        .email_address);
                                                              });
                                                            } else {
                                                              setState(() {
                                                                propertyTenant
                                                                    .add(
                                                                        registry);
                                                                propertyTenantEmails
                                                                    .add(registry
                                                                        .email_address);
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child: getIconCheck(
                                                            registry))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            ((add_user_status == 'Property Tenants' &&
                                        propertyTenant.isNotEmpty) ||
                                    (add_user_status == 'Property Handler' &&
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
                                              BorderRadius.circular(20)),
                                      child: TextButton(
                                        onPressed: () {
                                          addHandler();
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
    );
  }

  void callUrl(String phone_number) {}

  void supportAgemt() {}

  void addHandler() {
    FirebaseFirestore.instance
        .collection('PROPERTY REPO')
        .doc(widget.propertyF!.plot_no)
        .update({'property_handler': propertyHandleEmail});
    String id = Uuid().v4();
    FirebaseFirestore.instance
        .collection('USERS')
        .doc(propertyHandleEmail)
        .collection('ACTIVITIES')
        .doc(id)
        .set({
      'id': id,
      'activity_id': widget.propertyF!.plot_no,
      'activity_type': 'PROPERTY_REG',
      'activity_title': 'Registered as Handler',
      'activity_content':
          '${widget.propertyF!.plot_no.toUpperCase()}: now as the property handler',
      'activity_sq': widget.propertyF!.search_query,
      'activity_date': DateTime.now(),
      'activity_read': false,
    });
    setState(() {
      show_user = false;
    });
  }
}
