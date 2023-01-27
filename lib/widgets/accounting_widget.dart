import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubairgo/model/user_modelf.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:ubairgo/widgets/payment_request.dart';
import 'package:ubairgo/widgets/register_payment.dart';

import 'package:intl/intl.dart';
import '../functions/sys_constants.dart';
import '../model/property_model.dart';

class AccountingWidget extends StatefulWidget {
  @override
  State<AccountingWidget> createState() => _AccountingWidget();
}

class _AccountingWidget extends State<AccountingWidget> {
  TextEditingController search_textfield = TextEditingController();

  bool show_filter = false;

  SysConstants sys_constants = SysConstants();

  var plot_no;

  bool show_search = false;

  bool add_screen = false;

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
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            pttopBar(height),
            SizedBox(
              height: 15,
            ),
            cltListHeader(width, height),
            Expanded(
                child: SizedBox(
                    width: width,
                    height: height,
                    child: cltlist(width, height)))
          ],
        ),
      ),
      tablet: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            pttopBar(height),
            SizedBox(
              height: 15,
            ),
            cltListHeader(width, height),
            Expanded(
                child: SizedBox(
                    width: width,
                    height: height,
                    child: cltlist(width, height)))
          ],
        ),
      ),
      largeTablet: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    topBar(height),
                    SizedBox(
                      height: 25,
                    ),
                    cltListHeader(width, height),
                    Expanded(
                        child: SizedBox(
                            width: width,
                            height: height,
                            child: cltlist(width, height)))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: width,
                height: height,
                child: paymentWidget(width, height),
              ),
            ),
          ],
        ),
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
                    topBar(height),
                    SizedBox(
                      height: 25,
                    ),
                    cltListHeader(width, height),
                    Expanded(
                        child: SizedBox(
                            width: width,
                            height: height,
                            child: cltlist(width, height)))
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

  var currencyFormat = new NumberFormat.currency(locale: "en_US", symbol: "₦");
  StreamBuilder<QuerySnapshot<Object?>> cltlist(double width, double height) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('USERS')
            .doc(currentUser!.email_address)
            .collection('REGISTERED PAYMENT RECORDS')
            .orderBy('confirm_date', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.docs.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  PrmF payment = PrmF.fromDocument(
                    snapshot.data!.docs[index],
                  );
                  return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('PAYMENT RECORDS')
                          .doc(payment.payment_id)
                          .get(),
                      builder: (context, pp_snapshot) {
                        if (pp_snapshot.hasData &&
                            pp_snapshot.data != null &&
                            pp_snapshot.data!.exists) {
                          PaymentRegistryModelF pay_reg =
                              PaymentRegistryModelF.fromDocument(
                                  pp_snapshot.data!);
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                            child: SizedBox(
                              width: width,
                              height: 40,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontSize: 14,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Text(
                                              pay_reg.plot_no,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
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
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Text(
                                              pay_reg.paid_amount,
                                              style: TextStyle(
                                                fontSize: 14,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Text(
                                              pay_reg.paid_for,
                                              style: TextStyle(
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
                                      color: white,
                                      width: width,
                                      height: height,
                                      child: Row(
                                        children: [
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
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 0, 5, 0),
                                                    child: Text(
                                                      pay_reg.transaction_id[0],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          pay_reg.transaction_id.length > 1
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: sys_green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${pay_reg.transaction_id.length - 1}+",
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      });
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: sys_constants.imgHolder(300, payments),
                )
              ],
            );
          }
        });
  }

  Padding cltListHeader(double width, double height) {
    return Padding(
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
              flex: 4,
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
                        'Paid Amount',
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
                        'Paid for',
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
                        'Transaction ID',
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
    );
  }

  Padding topBar(double height) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree),
              SizedBox(
                width: 5,
              ),
              Text(
                'Recent Payments',
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
    );
  }

  Padding pttopBar(double height) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.account_tree),
              SizedBox(
                width: 5,
              ),
              Text(
                'Recent Payments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(children: [
            searchButton(),
            SizedBox(
              width: 10,
            ),
            addButton(),
            SizedBox(
              width: 10,
            ),
            filterButton()
          ]),
        ],
      ),
    );
  }

  int payment_index = 0;

  final List<String> typeItems = [
    'House Purchase',
    'Land Purchase',
    'House Rent',
    'Facility Fees',
    'Land Lease',
  ];

  String sel_type = '';

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
                                'New Payment',
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
                                'P-Request',
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
      return RegisteredPayment();
    } else {
      return SizedBox(
        width: width,
        height: height,
        // ignore: dead_code
        child: PaymentRequest(),
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

  IconButton addButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          add_screen = true;
        });
      },
      icon: Icon(Icons.sort),
    );
  }

  IconButton searchButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          show_search = true;
        });
      },
      icon: Icon(Icons.search),
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
