import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubairgo/model/user_modelf.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/widgets/chat_screenf.dart';

import '../functions/sys_constants.dart';
import '../model/user_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';
import 'chat_screen.dart';

class VSWidget extends StatefulWidget {
  @override
  State<VSWidget> createState() => _VSWidgetState();
}

class _VSWidgetState extends State<VSWidget> {
  SysConstants sys_constants = SysConstants();

  var search_textfield;

  var msg_textfield;

  bool show_messenger = false;

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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      peopleTop(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                            color: sys_green,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.sort),
                            color: black,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: agentsGridView(context, width, height, 2, 1, true),
                  ),
                ),
              ],
            ),
          ),
        ),
        tablet: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      peopleTop(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                            color: sys_green,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.sort),
                            color: black,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                      width: width,
                      height: height,
                      child: agentsGridView(context, width, height, 2, 1, true)

                      /* Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(     
                                    width: 300,
                                    child: sys_constants.imgHolder(
                                      width,
                                      business_pana,
                                    ),
                                  )
                                ],
                              ),*/ //2003722640
                      ),
                ),
              ],
            ),
          ),
        ),
        largeTablet: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      peopleTop(),
                      Row(
                        children: [
                          searchBar(height, 350),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.sort),
                            color: sys_green,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: SizedBox(
                                width: width,
                                height: height,
                                child: agentsGridView(
                                    context, width, height, 2, 1, false)

                                /* Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(     
                                    width: 300,
                                    child: sys_constants.imgHolder(
                                      width,
                                      business_pana,
                                    ),
                                  )
                                ],
                              ),*/ //2003722640
                                ),
                          ),
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: selected_user != null
                                  ? ChatWidgetF(
                                      is_back: false,
                                      user_model: selected_user!,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: sys_constants.imgHolder(
                                            width,
                                            realtor,
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
            ),
          ),
        ),
        computer: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      peopleTop(),
                      Row(
                        children: [
                          searchBar(height, 350),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.sort),
                            color: sys_green,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: SizedBox(
                                width: width,
                                height: height,
                                child: agentsGridView(
                                    context, width, height, 3, 1, false)

                                /* Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(     
                                    width: 300,
                                    child: sys_constants.imgHolder(
                                      width,
                                      business_pana,
                                    ),
                                  )
                                ],
                              ),*/ //2003722640
                                ),
                          ),
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: Card(
                                color: Colors.grey.shade50,
                                child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: selected_user != null
                                      ? ChatWidgetF(
                                          is_back: false,
                                          user_model: selected_user!,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 250,
                                              child: sys_constants.imgHolder(
                                                width,
                                                realtor,
                                              ),
                                            ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UserF? selected_user;

  Widget agentsGridView(BuildContext context, double width, double height,
      int grid, double aspect, bool isback) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('USERS')
            .where('sys_status', isEqualTo: 'Estate Support')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return noneWidget(300);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: grid,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: aspect,
              ),
              itemBuilder: (BuildContext context, int index) {
                return gridWaiting(width, height, aspect);
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
                childAspectRatio: aspect,
              ),
              itemBuilder: (BuildContext context, int index) {
                SupportAgentF support =
                    SupportAgentF.fromDocument(snapshot.data!.docs[index]);

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('USERS')
                      .doc(support.email_address)
                      .get(),
                  builder: (context, user_snapshot) {
                    if (user_snapshot.hasData &&
                        user_snapshot.data != null &&
                        user_snapshot.data!.exists) {
                      UserF user = UserF.fromDocument(user_snapshot.data!);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: (selected_user != null &&
                                    selected_user!.email_address ==
                                        user.email_address)
                                ? sys_green
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: aspect,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    width: width,
                                    height: height,
                                    child: Container(
                                      width: width,
                                      height: height,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            user.profile_pic,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 0),
                                            blurRadius: aspect,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: width,
                                    height: height,
                                    color: (selected_user != null &&
                                            selected_user!.email_address ==
                                                user.email_address)
                                        ? sys_green
                                        : Colors.grey.shade400,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: TextButton(
                                        onPressed: () {
                                          if (isback) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => ChatWidgetF(
                                                  is_back: true,
                                                  user_model: user,
                                                ),
                                              ),
                                            );
                                          }
                                          setState(() {
                                            selected_user = user;
                                          });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user.full_name,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: (selected_user !=
                                                                  null &&
                                                              user.email_address ==
                                                                  selected_user!
                                                                      .email_address)
                                                          ? Colors.white
                                                          : black),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      user.status,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: (selected_user !=
                                                                      null &&
                                                                  selected_user!
                                                                          .email_address ==
                                                                      user.email_address)
                                                              ? white
                                                              : Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    (user.is_verified)
                                                        ? Icon(Icons.verified,
                                                            size: 15,
                                                            color: (selected_user !=
                                                                        null &&
                                                                    selected_user!
                                                                            .email_address ==
                                                                        user.email_address)
                                                                ? white
                                                                : sys_green)
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ],
                                            ),
                                            ratingValue(
                                                verified_people[index].rate,
                                                user.is_verified),
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
                      );
                    } else {
                      return gridWaiting(width, height, aspect);
                    }
                  },
                );
              },
            );
          } else {
            return noneWidget(300);
          }
        });
  }

  Padding gridWaiting(double width, double height, double aspect) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: aspect,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: aspect,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.grey.shade200,
                                child: Text(
                                  '                            ',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: black),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Container(
                                    color: Colors.grey.shade200,
                                    child: Text(
                                      '                       ',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.grey.shade200,
                          ),
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
    );
  }

  Row ratingValue(double rating, bool is_verify) {
    if (rating == 0.0) {
      return Row(
        children: [
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 0.5) {
      return Row(
        children: [
          Icon(
            Icons.star_half,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 1) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 1.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_half,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 2) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 2.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_half,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 3) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
    } else if (rating == 3.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_half,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
        ],
      );
    } else if (rating == 4) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star,
            color: is_verify ? white : sys_green,
            size: 15,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.star_outline,
            color: is_verify ? Colors.grey.shade200 : Colors.grey,
            size: 15,
          ),
        ],
      );
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

  Row peopleTop() {
    return Row(
      children: [
        Icon(
          Icons.people,
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
              'Verified agents',
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

  Widget noneWidget(double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 350,
          child: sys_constants.imgHolder(
            width,
            business_pana,
          ),
        )
      ],
    );
  }
}
