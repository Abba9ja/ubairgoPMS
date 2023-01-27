import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:uuid/uuid.dart';

import '../model/user_model.dart';
import '../styles/sysimg_constants.dart';

class PaymentRequest extends StatefulWidget {
  @override
  State<PaymentRequest> createState() => _PaymentRequest();
}

class _PaymentRequest extends State<PaymentRequest> {
  TextEditingController plot_no = TextEditingController();
  SysConstants sys_constants = SysConstants();

  bool show_details = false;

  PaymentRegistryModelF? sel_prmf;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: show_details
          ? showDetails(width, height)
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
                            Icons.payment,
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
                    children: [Text('0: New'), Text('0: Waiting')],
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
                          color: white,
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
                                  'Plot no',
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
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(
                                  'Transaction ID',
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
                        flex: 5,
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
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('PAYMENT RECORDS REQUEST')
                              .orderBy('request_date')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child:
                                        sys_constants.imgHolder(200, payments),
                                  )
                                ],
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child:
                                        sys_constants.imgHolder(200, loading),
                                  )
                                ],
                              );
                            }
                            if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.docs.length > 0) {
                              int count = snapshot.data!.docs.length;
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    PaymentRegistryModelF prmf =
                                        PaymentRegistryModelF.fromDocument(
                                            snapshot.data!.docs[index]);
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        width: width,
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              sel_prmf = prmf;
                                              show_details = true;
                                            });
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
                                                      Center(
                                                          child: Text(
                                                              "${count + 1}")),
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5, 0, 5, 0),
                                                        child: Text(
                                                          prmf.plot_no,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
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
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 5, 0),
                                                            child: Text(
                                                              prmf.transaction_id[
                                                                  0],
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      prmf.transaction_id
                                                                  .length >
                                                              1
                                                          ? Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      sys_green,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Center(
                                                                child: Text(
                                                                  "${prmf.transaction_id.length}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          white),
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
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
                                                                5, 0, 5, 0),
                                                        child: Text(
                                                          "₦${prmf.paid_amount}",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                          child: Icon(
                                                        Icons.file_present,
                                                        size: 15,
                                                        color:
                                                            prmf.transactoin_reciept
                                                                        .length >
                                                                    0
                                                                ? sys_green
                                                                : Colors.grey
                                                                    .shade100,
                                                      )),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child:
                                        sys_constants.imgHolder(200, payments),
                                  )
                                ],
                              );
                            }
                          })),
                )
              ],
            ),
    );
  }

  String payment_status = '';
  bool isconfirm = false;

  Padding showDetails(double width, double height) {
    return Padding(
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
                  onPressed: () {
                    setState(() {
                      sel_prmf = null;
                      show_details = false;
                    });
                  },
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
                          'Plot No:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: Text(sel_prmf!.plot_no.toUpperCase()),
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
                          'Submitted By:',
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
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('USERS')
                                    .doc(sel_prmf!.request_by)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.exists) {
                                    UserF user =
                                        UserF.fromDocument(snapshot.data!);
                                    return Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    user.profile_pic),
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
                                                  user.full_name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Text(
                                                  user.sys_status,
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
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
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
                                                Container(
                                                  color: Colors.grey.shade100,
                                                  child: Text(
                                                    '                                   ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  color: Colors.grey.shade100,
                                                  child: Text(
                                                    '                                 ',
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
                                }),
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
                          'Transaction ID:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: width,
                          height: 220,
                          child: ListView.builder(
                            itemCount: sel_prmf!.transaction_id.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Card(
                                  child: SizedBox(
                                    width: 250,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Text(
                                          sel_prmf!.transaction_id[index],
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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
                          'Amount:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: Text(
                                '₦${sel_prmf!.paid_amount}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
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
                          child: Container(
                            width: width,
                            height: 200,
                            color: Colors.grey.shade100,
                            child: ListView.builder(
                              itemCount: sel_prmf!.transactoin_reciept.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Card(
                                    child: SizedBox(
                                      height: 200,
                                      child: Image(
                                        image: NetworkImage(
                                          sel_prmf!.transactoin_reciept[index],
                                        ),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          child: Linkable(text: sel_prmf!.extra_note),
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
                                color: payment_status == 'Varified'
                                    ? sys_green
                                    : Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        payment_status = 'Varified';
                                        isconfirm = true;
                                      });
                                    },
                                    icon: Icon(
                                      payment_status == 'Varified'
                                          ? Icons.radio_button_unchecked
                                          : Icons.radio_button_checked,
                                      color: payment_status == 'Varified'
                                          ? white
                                          : Colors.grey,
                                    ),
                                    label: Text(
                                      'Verified',
                                      style: TextStyle(
                                        color: payment_status == 'Varified'
                                            ? white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Card(
                                color: payment_status == 'Invalid'
                                    ? Colors.red
                                    : white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        payment_status = 'Invalid';
                                      });
                                    },
                                    icon: Icon(
                                      payment_status == 'Invalid'
                                          ? Icons.radio_button_unchecked
                                          : Icons.radio_button_checked,
                                      color: payment_status == 'Invalid'
                                          ? white
                                          : Colors.grey,
                                    ),
                                    label: Text(
                                      'Invalid',
                                      style: TextStyle(
                                        color: payment_status == 'Invalid'
                                            ? white
                                            : Colors.black,
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
                                color: payment_status == 'Waiting'
                                    ? Colors.orange
                                    : white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        payment_status = 'Waiting';
                                      });
                                    },
                                    icon: Icon(
                                      payment_status == 'Waiting'
                                          ? Icons.radio_button_unchecked
                                          : Icons.radio_button_checked,
                                      color: payment_status == 'Waiting'
                                          ? white
                                          : Colors.grey,
                                    ),
                                    label: Text(
                                      'Waiting',
                                      style: TextStyle(
                                        color: payment_status == 'Waiting'
                                            ? white
                                            : Colors.black,
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
                            onPressed: () {
                              submitReview();
                            },
                            icon: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.check),
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
    );
  }

  getOutStanding(double parse, double parse2) {
    return parse2 - parse;
  }

  getStatus(PropertyF propertyF) {
    if (propertyF.status == 'For Sale') {
      return 'Occupied Landlord';
    } else if (propertyF.status == 'For Rent') {
      return 'Occupied Tenant';
    } else {
      return propertyF.status;
    }
  }

  getOwner(PropertyF propertyF) {
    if (propertyF.status == 'For Sale') {
      return sel_prmf!.request_by;
    } else {
      return propertyF.property_owner;
    }
  }

  getTenant(PropertyF propertyF) {
    if (propertyF.status == 'For Rent') {
      return [sel_prmf!.request_by];
    } else {
      return propertyF.property_tenants;
    }
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

  void submitReview() async {
    DocumentSnapshot plot_doc = await FirebaseFirestore.instance
        .collection('PROPERTY REPO')
        .doc(sel_prmf!.plot_no)
        .get();
    if (plot_doc.exists) {
      PropertyF propertyF = PropertyF.fromDocument(plot_doc);

      if (payment_status == 'Verified' && isconfirm) {
        FirebaseFirestore.instance
            .collection('PAYMENT RECORDS')
            .doc(sel_prmf!.payment_id)
            .set({
          'payment_id': sel_prmf!.payment_id,
          'plot_no': sel_prmf!.plot_no,
          'paid_for': sel_prmf!.paid_for,
          'paid_amount': sel_prmf!.paid_amount,
          'transaction_id': sel_prmf!.transaction_id,
          'transactoin_reciept': sel_prmf!.transactoin_reciept,
          'extra_note': sel_prmf!.extra_note,
          'discount_id': '',
          'registeredby': currentUser!.email_address,
          'request_date': sel_prmf!.request_date,
          'confirm_date': DateTime.now(),
          'handler': sel_prmf!.handler,
          'request_by': sel_prmf!.request_by,
          'search_query': sel_prmf!.search_query,
          'confirm_status': isconfirm,
          'payment_status': payment_status,
        });
      }

      if (sel_prmf!.handler.isNotEmpty) {
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(sel_prmf!.handler)
            .collection('ACTIVITIES')
            .doc(id)
            .set({
          'id': id,
          'activity_id': sel_prmf!.payment_id,
          'activity_type': 'CLIENT PAYMENT RECORDS',
          'activity_title':
              '${sel_prmf!.plot_no} payment ${sel_prmf!.payment_status.toUpperCase()}',
          'activity_content':
              "have reviewed payment request to  ${sel_prmf!.payment_status}",
          'activity_sq': [sel_prmf!.payment_status],
          'activity_date': DateTime.now(),
          'activity_read': false,
          'activity_user': currentUser!.email_address
        });
      }

      if (isconfirm) {
        FirebaseFirestore.instance
            .collection('PROPERTY REPO')
            .doc(sel_prmf!.plot_no)
            .collection('PAYMENT RECORDS')
            .doc(sel_prmf!.payment_id)
            .set({
          'payment_id': sel_prmf!.payment_id,
          'plot_no': sel_prmf!.plot_no,
          'paid_amount': sel_prmf!.paid_amount,
          'search_query': [
            sel_prmf!.payment_status,
            sel_prmf!.plot_no,
          ],
          'confirm_date': DateTime.now(),
          'confirm_status': isconfirm,
          'payment_status': 'Varified',
        });

        FirebaseFirestore.instance
            .collection('PROPERTY REPO')
            .doc(sel_prmf!.plot_no)
            .update({
          'status': getStatus(propertyF),
          'property_owner': getOwner(propertyF),
          'property_tenants': FieldValue.arrayUnion(getTenant(propertyF))
        });

        DocumentSnapshot acc_doc = await FirebaseFirestore.instance
            .collection('PROPERTY REPO')
            .doc(propertyF.plot_no)
            .collection('PAYMENT ACCOUNT')
            .doc(sel_prmf!.request_by)
            .get();
        if (acc_doc.exists) {
          PaymentAccountF paf = PaymentAccountF.fromDocument(acc_doc);
          FirebaseFirestore.instance
              .collection('PROPERTY REPO')
              .doc(propertyF.plot_no)
              .collection('PAYMENT ACCOUNT')
              .doc(sel_prmf!.request_by)
              .update({
            'payments_id': FieldValue.arrayUnion([sel_prmf!.payment_id]),
            'paid_amount':
                "${double.parse(paf.paid_amount) + double.parse(sel_prmf!.paid_amount)}",
            'outstanding_amount': getOutStanding(
                    double.parse(paf.paid_amount) +
                        double.parse(sel_prmf!.paid_amount),
                    double.parse(paf.total_amount_num))
                .toString(),
            'paid_complete': getPaidStatus(
                double.parse(paf.paid_amount) +
                    double.parse(sel_prmf!.paid_amount),
                double.parse(paf.total_amount_num))
          });
        } else {
          FirebaseFirestore.instance
              .collection('PROPERTY REPO')
              .doc(propertyF.plot_no)
              .collection('PAYMENT ACCOUNT')
              .doc(sel_prmf!.request_by)
              .set({
            'client_email': sel_prmf!.request_by,
            'payments_id': [sel_prmf!.payment_id],
            'total_amount_num': propertyF.amount,
            'paid_amount': sel_prmf!.paid_amount,
            'outstanding_amount': getOutStanding(
                double.parse(sel_prmf!.paid_amount),
                double.parse(propertyF.amount)),
            'paid_complete': getPaidStatus(double.parse(sel_prmf!.paid_amount),
                double.parse(propertyF.amount))
          });
        }
        DocumentSnapshot own_p = await FirebaseFirestore.instance
            .collection('USERS')
            .doc(sel_prmf!.request_by)
            .collection('OWN PROPERTY')
            .doc(plot_no.text.toUpperCase())
            .get();
        if (!own_p.exists) {
          FirebaseFirestore.instance
              .collection('USERS')
              .doc(sel_prmf!.request_by)
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

      if (sel_prmf!.request_by.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(sel_prmf!.request_by)
            .collection('PAYMENT RECORDS')
            .doc(sel_prmf!.payment_id)
            .update({
          'confirm_date': DateTime.now(),
          'confirm_status': isconfirm,
          'payment_status': payment_status,
        });
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(sel_prmf!.request_by)
            .collection('ACTIVITIES')
            .doc(id)
            .set({
          'id': id,
          'activity_id': sel_prmf!.payment_id,
          'activity_type': 'PAYMENT RECORDS',
          'activity_title':
              '${sel_prmf!.plot_no} payment ${sel_prmf!.payment_status.toUpperCase()}',
          'activity_content':
              "${currentUser!.email_address} have reviewed payment request to  ${sel_prmf!.payment_status}",
          'activity_sq': [sel_prmf!.payment_status],
          'activity_date': DateTime.now(),
          'activity_read': false,
          'activity_user': currentUser!.email_address
        });
      }
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(currentUser!.email_address)
          .collection('REGISTERED PAYMENT RECORDS')
          .doc(sel_prmf!.payment_id)
          .set({
        'payment_id': sel_prmf!.payment_id,
        'plot_no': sel_prmf!.plot_no,
        'search_query': [
          sel_prmf!.payment_status,
          sel_prmf!.plot_no,
        ],
        'confirm_date': DateTime.now(),
        'confirm_status': isconfirm,
        'payment_status': payment_status,
      });
    }
    setState(() {
      sel_prmf = null;
      show_details = false;
    });
  }
}
