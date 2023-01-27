import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubairgo/model/user_modelf.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:ubairgo/widgets/new_user_widget.dart';

import '../functions/sys_constants.dart';
import '../model/user_model.dart';

class UsersMngt extends StatefulWidget {
  @override
  State<UsersMngt> createState() => _UsersMngt();
}

class _UsersMngt extends State<UsersMngt> {
  TextEditingController search_textfield = TextEditingController();

  bool show_filter = false;

  SysConstants sys_constants = SysConstants();

  var plot_no;

  UserF? selected_user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveLayout(
      tiny: SizedBox(
        width: width,
        height: height,
      ),
      phone: SizedBox(
        width: width,
        height: height,
      ),
      tablet: SizedBox(
        width: width,
        height: height,
      ),
      largeTablet: SizedBox(
        width: width,
        height: height,
      ),
      computer: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'System users',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            searchBar(height, 300),
                            SizedBox(
                              width: 10,
                            ),
                            filterButton()
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                              flex: 5,
                              child: Container(
                                width: width,
                                height: height,
                                color: white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        'User',
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
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        'Rating',
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
                              flex: 4,
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        'System Status',
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
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Text(
                                        'Role',
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
                                    .orderBy('date_reg', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.length > 0) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          UserF user = UserF.fromDocument(
                                              snapshot.data!.docs[index]);
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 10, 15, 5),
                                            child: Container(
                                              width: width,
                                              height: 40,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {});
                                                },
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      5,
                                                                      0,
                                                                      5,
                                                                      0),
                                                              child: Text(
                                                                '${index + 1}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        width: width,
                                                        height: height,
                                                        color: white,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 35,
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: user
                                                                        .profile_pic
                                                                        .isEmpty
                                                                    ? sys_constants
                                                                        .getRandomColor(user
                                                                            .sys_status)
                                                                    : Colors
                                                                        .white,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(user
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
                                                              child: user
                                                                      .profile_pic
                                                                      .isEmpty
                                                                  ? Center(
                                                                      child:
                                                                          Text(
                                                                        user.full_name
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
                                                                      user.full_name,
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
                                                                      user.email_address,
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            (user.is_verified)
                                                                ? SizedBox(
                                                                    width: 90,
                                                                    child: Card(
                                                                        color: Colors
                                                                            .blue,
                                                                        child: sys_constants.ratingValue(
                                                                            user.rate,
                                                                            user.is_verified)))
                                                                : SizedBox()
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
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
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      5,
                                                                      0,
                                                                      5,
                                                                      0),
                                                              child: Text(
                                                                user.sys_status,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
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
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            user.is_verified
                                                                ? Icon(
                                                                    Icons
                                                                        .verified,
                                                                    color:
                                                                        sys_green,
                                                                  )
                                                                : SizedBox(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      5,
                                                                      0,
                                                                      5,
                                                                      0),
                                                              child: Text(
                                                                user.status,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          );
                                        });
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: sys_constants.imgHolder(
                                              300, add_user),
                                        )
                                      ],
                                    );
                                  }
                                })))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: width,
                height: height,
                child: paymentWidget(width, height),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int payment_index = 0;

  final List<String> typeItems = [
    'Estate Client',
    'Estate Support',
    'Emergency Support',
    'Facility Fees',
    'Land Lease',
  ];

  String sel_type = '';

  final List<String> ec_role = [
    'Lanlord',
    'Owner',
    'Tenant',
  ];

  String sel_ec_role = '';

  final List<String> es_role = [
    'Engineer',
    'Realtor',
    'Architect',
    'Interior Designer',
  ];

  String sel_es_role = '';

  Widget paymentWidget(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, offset: Offset(0, 0), blurRadius: 2),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: width,
                          height: height,
                          color: payment_index == 0 ? sys_green : white,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  payment_index = 0;
                                });
                              },
                              child: Text(
                                'New User',
                                style: TextStyle(
                                    color: payment_index == 0
                                        ? white
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: payment_index == 0
                                        ? FontWeight.bold
                                        : FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: width,
                          height: height,
                          color: payment_index == 1 ? sys_green : white,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  payment_index = 1;
                                });
                              },
                              child: Text(
                                'Users-Request',
                                style: TextStyle(
                                    color: payment_index == 1
                                        ? white
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: payment_index == 1
                                        ? FontWeight.bold
                                        : FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: paymentSwitch(width, height),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentSwitch(double width, double height) {
    if (payment_index == 0) {
      return UserRegWidget();
    } else {
      return SizedBox(
        width: width,
        height: height,
        // ignore: dead_code
        child: false
            // ignore: dead_code
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: width,
                      height: 45,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.chevron_left),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: Text('New Request'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Request User:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: width,
                                      height: 40,
                                      color: white,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      user22.profile_picture),
                                                  fit: BoxFit.cover),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 1),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    user22.full_name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),
                                                  Text(
                                                    user22.email_address,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
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
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'System Status:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: Text('Estate Client'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Role:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: Text('Owner'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Attachment:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: width,
                                      height: 60,
                                      child: ListView.builder(
                                          itemCount: 2,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: SizedBox(
                                                width: 80,
                                                height: 60,
                                              ),
                                            );
                                          }),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Extra note:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                        'Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.'),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.radio_button_unchecked,
                                                color: Colors.grey,
                                              ),
                                              label: Text(
                                                'Verified',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.radio_button_unchecked,
                                                color: Colors.grey,
                                              ),
                                              label: Text(
                                                'Invalid',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.radio_button_unchecked,
                                                color: Colors.grey,
                                              ),
                                              label: Text(
                                                'Review',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(Icons.person_add),
                                      ),
                                      label: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text('Submit'),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            // ignore: dead_code
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.people_alt,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Requests',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(onPressed: () {}, icon: Icon(Icons.sort))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('0: New'), Text('0: On-Review')],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                                Center(
                                    child: Icon(
                                  Icons.numbers,
                                  size: 15,
                                )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            width: width,
                            height: height,
                            color: white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    'User',
                                    style: TextStyle(
                                      fontSize: 13,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    'Role',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                Center(
                                    child: Icon(
                                  Icons.payment,
                                  size: 15,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: sys_constants.imgHolder(200, add_user),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      );
    }
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
}
