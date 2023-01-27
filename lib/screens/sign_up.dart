// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/screens/splash.dart';
import 'package:ubairgo/styles/responsive.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:uuid/uuid.dart';

import '../functions/sys_constants.dart';
import '../styles/colors.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  SysConstants sys_constants = SysConstants();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  AnimationController? _controller;
  Animation<double>? _animation;
  List<bool> isShow = [false, false, false, false, false, false];
  String user_option = '';
  int switcc_index = 0;
  int switccc_index = 0;

  //DETAILS VAR
  TextEditingController full_name = TextEditingController();
  TextEditingController email_address = TextEditingController();
  TextEditingController phone_number = TextEditingController();

  List<String> genderTypes = ['Male', 'Female', 'Other'];
  String sel_gender = '';

  TextEditingController id_number = TextEditingController();
  TextEditingController extra_note = TextEditingController();

  var add_plot_txt;

  @override
  void initState() {
    super.initState();

    setTimers();
  }

  List<String> id_types = [
    'International Passport',
    'Driver\'s License',
    'National ID card '
  ];
  String sel_id = '';

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

  List<Uint8List> ref_doc_filebyte = [];
  List<dynamic> ref_doc_filename = [];

  pickRefDocPressed() async {
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
          ref_doc_filebyte = l_file;
          ref_doc_filename = l_filename;
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

  void setTimers() {
    Timer(
        Duration(seconds: 1),
        () => {
              setState(() {
                isShow[0] = true;
              })
            });
    Timer(
      Duration(seconds: 2),
      () => {
        setState(() {
          isShow[1] = true;
        })
      },
    );
    Timer(
        Duration(seconds: 7),
        () => {
              setState(() {
                isShow[2] = true;
              })
            });
    Timer(
        Duration(seconds: 9),
        () => {
              setState(() {
                isShow[3] = true;
              })
            });
    Timer(
      Duration(seconds: 11),
      () => {
        setState(() {
          isShow[4] = true;
        })
      },
    );
    Timer(
        Duration(seconds: 12),
        () => {
              setState(() {
                isShow[5] = true;
              })
            });
  }

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
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: sys_green,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 25, 100, 25),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: switcc_index == 0
                        ? defaultScreen()
                        : regScreen(width, height),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget regScreen(double width, double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.2, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  switccc_index == 2
                      ? SizedBox()
                      : Container(
                          width: width,
                          height: 400,
                          child: Image(
                            image: AssetImage(bot_amico),
                            fit: BoxFit.cover,
                          ),
                        ),
                  /* Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 2),
                        ]),
                    child: Column(
                      children: [
                        Icon(
                          getIcon(),
                          size: 60,
                          color: sys_green,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          user_option,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: sys_green),
                        )
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (user_option == 'Support')
                      ? Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 2),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: switccc_index == 0
                                          ? sys_green
                                          : white,
                                      child: Center(
                                          child: Text(
                                        'Details',
                                        style: TextStyle(
                                          color: switccc_index == 0
                                              ? white
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: switccc_index == 1
                                          ? sys_green
                                          : white,
                                      child: Center(
                                          child: Text(
                                        'Support',
                                        style: TextStyle(
                                          color: switccc_index == 1
                                              ? white
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: switccc_index == 2
                                          ? sys_green
                                          : white,
                                      child: Center(
                                          child: Text(
                                        'Verify',
                                        style: TextStyle(
                                          color: switccc_index == 2
                                              ? white
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 2),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: switccc_index == 0
                                          ? sys_green
                                          : white,
                                      child: Center(
                                          child: Text(
                                        'Details',
                                        style: TextStyle(
                                          color: switccc_index == 0
                                              ? white
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: switccc_index == 1
                                          ? sys_green
                                          : white,
                                      child: Center(
                                          child: Text(
                                        'Property',
                                        style: TextStyle(
                                          color: switccc_index == 1
                                              ? white
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: width,
                                      height: height,
                                      color: switccc_index == 2
                                          ? sys_green
                                          : white,
                                      child: Center(
                                          child: Text(
                                        'Verify',
                                        style: TextStyle(
                                          color: switccc_index == 2
                                              ? white
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  Expanded(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: (user_option == 'Support')
                          ? supportSwitch(width, height)
                          : regSwitch(width, height),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget supportSwitch(double width, double height) {
    switch (switccc_index) {
      case 0:
        return regSwichtScreen(width, height);
      case 1:
        return supportSwichtScreen(width, height);
      case 2:
        return verifySwichtScreen(width, height);
      default:
        return regSwichtScreen(width, height);
    }
  }

  Widget regSwitch(double width, double height) {
    switch (switccc_index) {
      case 0:
        return regSwichtScreen(width, height);
      case 1:
        return propertySwichtScreen(width, height);
      case 2:
        return verifySwichtScreen(width, height);
      default:
        return regSwichtScreen(width, height);
    }
  }

  bool id_error = false;
  bool detailsChecking = false;
  bool user_exist = false;

  Uint8List? profile_pic;
  String profile_pic_str = '';

  pickPPPressed() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: sys_constants.allowedext(),
      );
      if (result != null) {
        final fileBytes = result.files.first.bytes;
        final fileName = result.files.first.name;
        setState(() {
          profile_pic = fileBytes;
          profile_pic_str = fileName;
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

  SingleChildScrollView regSwichtScreen(double width, double height) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey1,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            //NAME & EMAIL
            SizedBox(
              width: width,
              height: 200,
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 5,
                          bottom: 5,
                          right: 5,
                          child: profile_pic == null
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: Icon(
                                      Icons.account_circle,
                                      color: Colors.grey.shade200,
                                      size: 195,
                                    ),
                                  ))
                              : Container(
                                  width: 200,
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 180,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(
                                                  0,
                                                  0,
                                                ),
                                                blurRadius: 2),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: Image.memory(
                                            profile_pic!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: IconButton(
                            onPressed: () {
                              pickPPPressed();
                            },
                            icon: Icon(Icons.add_a_photo, color: sys_green),
                          ),
                        ),
                      ],
                    ),
                    //child: ,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: width,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    cursorColor: sys_green,
                                    keyboardType: TextInputType.text,
                                    controller: full_name,
                                    maxLines: 1,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name required';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                      focusColor: sys_green,
                                      prefixIconColor: sys_green,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: sys_green,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelText: 'Full Name',
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    cursorColor: sys_green,
                                    keyboardType: TextInputType.text,
                                    controller: email_address,
                                    maxLines: 1,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email Address required';
                                      }
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          !value.toString().contains(
                                                RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                                              )) {
                                        return 'Invalid Email Address';
                                      }
                                      if (user_exist) {
                                        return 'Email Address already exist';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      detailsContinue(value);
                                    },
                                    onSaved: (value) {
                                      detailsContinue(value!);
                                    },
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                      focusColor: sys_green,
                                      prefixIconColor: sys_green,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: sys_green,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelText: 'Email Address',
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //PHONE NUMBER & GENDER
            SizedBox(
              width: width,
              height: 85,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width,
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                cursorColor: sys_green,
                                keyboardType: TextInputType.phone,
                                controller: phone_number,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone Number';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  focusColor: sys_green,
                                  prefixIconColor: sys_green,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: sys_green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'Phone Number',
                                  hintText: '',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width,
                            height: 75,
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
                                  'Gender',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: genderTypes
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
                                    return 'Gender required';
                                  }
                                },
                                onChanged: (value) {
                                  //Do something when changing the item if you want.
                                },
                                onSaved: (value) {
                                  sel_gender = value.toString();
                                },
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
            SizedBox(
              height: 20,
            ),
            //ID
            Row(
              children: [
                Text(
                  'IDENTIFICATION: ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: width,
              height: 86,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width,
                            height: 75,
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
                                  'ID Type',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: id_types
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
                                    return 'ID required';
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    sel_id = value.toString();
                                  });
                                  //Do something when changing the item if you want.
                                },
                                onSaved: (value) {
                                  setState(() {
                                    sel_id = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width,
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                cursorColor: sys_green,
                                keyboardType: TextInputType.text,
                                controller: id_number,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'ID Number';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  focusColor: sys_green,
                                  prefixIconColor: sys_green,
                                  prefixIcon: Icon(
                                    Icons.card_membership,
                                    color: sys_green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'ID Number',
                                  hintText: '',
                                ),
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width,
              height: 140,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      width: width,
                      height: 145,
                      child: Card(
                        color: Colors.grey.shade200,
                        child: SizedBox(
                          width: width,
                          height: 145,
                          child: Row(
                            children: [
                              Card(
                                child: SizedBox(
                                  width: 90,
                                  height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Card(
                                            child: SizedBox(
                                                width: 80,
                                                height: 70,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    color: Colors.grey.shade200,
                                                    size: 40,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: width,
                                            height: height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () {
                                                    pickIDPressed();
                                                  },
                                                  icon: Icon(Icons.add_circle),
                                                  label: Text('Add'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: id_filebyte.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: id_filebyte.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 0, 15, 0),
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
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Card(
                                                                child: SizedBox(
                                                                  height: 100,
                                                                  child: Image
                                                                      .memory(
                                                                    id_filebyte[
                                                                        index],
                                                                    height: 100,
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                                  id_filebyte[
                                                                      index]);
                                                              id_filename.remove(
                                                                  id_filename[
                                                                      index]);
                                                            });
                                                          },
                                                          child: Card(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Icon(
                                                                  Icons.close),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Upload picture\'s of your ID documennt',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            id_error
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Card(
                        color: Colors.red.shade400,
                        child: SizedBox(
                          width: 200,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'ID document requird',
                                  style: TextStyle(color: white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    id_error = false;
                                  });
                                },
                                child: Icon(Icons.close, color: white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 30,
            ),
            user_option.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: sys_green,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              switccc_index = 0;
                            });
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: white,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: sys_green,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              if (id_filebyte.isNotEmpty) {
                                hideIdError();
                                setState(() {
                                  switccc_index = 1;
                                });
                              } else {
                                showIdError();
                              }
                            }
                          },
                          child: Icon(
                            Icons.chevron_right,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void detailsContinue(String value) async {
    DocumentSnapshot checkUserQuery =
        await FirebaseFirestore.instance.collection('USERS').doc(value).get();
    if (!checkUserQuery.exists) {
      setState(() {
        user_exist = false;
      });
    } else {
      setState(() {
        user_exist = true;
      });
    }
  }

  void showIdError() {
    setState(() {
      id_error = true;
    });
  }

  void hideIdError() {
    setState(() {
      id_error = false;
    });
  }

  final List<String> support_types = [
    'Estate Support',
    'Emergency Support',
  ];

  final List<String> estate_s_role = [
    'Engineer',
    'Realtor',
    'Architect',
    'Interior Designer',
  ];

  String sel_support_type = '';

  final List<String> emergency_s_role = [
    'Police Assistant',
    'Hospital Assistant',
    'E-Security Asistant',
  ];

  String sel_es_role = '';

  List<String> list_sel_role = [];

  void setRole() {
    if (sel_support_type == 'Estate Support') {
      list_sel_role = estate_s_role;
    } else {
      list_sel_role = emergency_s_role;
    }
  }

  SingleChildScrollView supportSwichtScreen(double width, double height) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey2,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width,
              height: 85,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width,
                            height: 75,
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
                                  'Support Type',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: support_types
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
                                  setState(() {
                                    sel_support_type = value.toString();
                                  });
                                  setRole();

                                  //Do something when changing the item if you want.
                                },
                                onSaved: (value) {
                                  sel_support_type = value.toString();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width,
                            height: 75,
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
                                  'Support Role',
                                  style: TextStyle(fontSize: 14),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: list_sel_role
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
                                  setState(() {
                                    sel_es_role = value.toString();
                                  });
                                  //Do something when changing the item if you want.
                                },
                                onSaved: (value) {
                                  sel_es_role = value.toString();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      height: height,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width,
              height: 120,
              child: Row(
                children: [
                  Expanded(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
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
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      height: height,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'REF-DOCUMENT: ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width,
              height: 140,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      width: width,
                      height: 140,
                      child: Card(
                        color: Colors.grey.shade200,
                        child: SizedBox(
                          width: width,
                          height: 140,
                          child: Row(
                            children: [
                              Card(
                                child: SizedBox(
                                  width: 85,
                                  height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Card(
                                            child: SizedBox(
                                                width: 80,
                                                height: 70,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.file_present,
                                                    color: Colors.grey.shade200,
                                                    size: 40,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: width,
                                            height: height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () {
                                                    pickRefDocPressed();
                                                  },
                                                  icon: Icon(Icons.add_circle),
                                                  label: Text('Add'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: SizedBox(
                                    width: width,
                                    height: height,
                                    child: id_filebyte.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: ref_doc_filebyte.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 5, 15, 5),
                                                child: Card(
                                                  child: SizedBox(
                                                    height: 100,
                                                    child: Stack(children: [
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child: Card(
                                                                  child:
                                                                      SizedBox(
                                                                    height: 100,
                                                                    child: Image
                                                                        .memory(
                                                                      ref_doc_filebyte[
                                                                          index],
                                                                      height:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: SizedBox(
                                                                  width: width,
                                                                  height:
                                                                      height,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        ref_doc_filename[
                                                                            index],
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              ref_doc_filebyte.remove(
                                                                  ref_doc_filebyte[
                                                                      index]);
                                                              ref_doc_filename.remove(
                                                                  ref_doc_filename[
                                                                      index]);
                                                            });
                                                          },
                                                          child: Card(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Icon(
                                                                  Icons.close),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              );
                                            })
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Upload picture\'s of your ID documennt',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      height: height,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            user_option.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: sys_green,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              switccc_index = 0;
                            });
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: white,
                          ),
                        ),
                      ),
                      (sel_support_type.isNotEmpty && sel_es_role.isNotEmpty)
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: sys_green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: is_registring
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                        color: white,
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        registerUser();
                                      },
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: white,
                                      ),
                                    ),
                            )
                          : SizedBox(),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
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
      // e.g, e.code == 'canceled'
      setState(() {
        is_registring = false;
      });
    }
  }

  bool is_registring = false;
  void registerUser() async {
    setState(() {
      is_registring = true;
    });
    List<dynamic> id_document = [];
    if (id_filebyte.isNotEmpty) {
      id_document = await uploadFileWeb(id_filebyte, id_filename);
    }
    List<dynamic> ref_document = [];
    if (ref_doc_filebyte.isNotEmpty) {
      ref_document = await uploadFileWeb(ref_doc_filebyte, ref_doc_filename);
    }

    dynamic profilePicture = '';
    if (profile_pic != null) {
      profilePicture = await uploadPPFileWeb(profile_pic!, profile_pic_str);
    }

    FirebaseFirestore.instance.collection('USERS').doc(email_address.text).set({
      'id': '',
      'resident_id': '',
      'email_address': email_address.text,
      'phone_number': phone_number.text,
      'full_name': full_name.text,
      'profile_pic': profilePicture,
      'status': sel_es_role,
      'sys_status': sel_support_type,
      'rate': 0.0,
      'is_verified': false,
      'user_status': 'in_active',
      'id_type': sel_id,
      'id_number': id_number.text,
      'id_documents': id_document,
      'ref_note': extra_note.text,
      'ref_documents': ref_document,
      'date_reg': DateTime.now(),
      'date_signin': DateTime.now(),
      'search_query': full_name.text.split(' '),
    }).then((value) {
      setState(() {
        is_registring = false;
        switccc_index = 2;
        setTimer2();
      });
    });
    if (user_option == 'Landlord' || user_option == 'Tenant') {
      for (var plot in selected_plot) {
        DateTime time = DateTime.now();
        String request_id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('CLIENT PROPERTY REQUESTS')
            .doc(request_id)
            .set({
          'plot_no': plot.plot_no.toUpperCase(),
          'date_reg': time,
          'search_query': plot.search_query,
          'request': user_option,
          'request_by': email_address.text,
          'request_id': request_id,
          'status': 'Submitted',
          'extra_note': '',
          'reviewed_by': '',
        });

        FirebaseFirestore.instance
            .collection('USERS')
            .doc(email_address.text)
            .collection('MY PROPERTY REQUEST')
            .doc(request_id)
            .set({
          'plot_no': plot.plot_no.toUpperCase(),
          'date_reg': time,
          'search_query': plot.search_query,
          'request': user_option,
          'request_by': email_address.text,
          'request_id': request_id,
          'status': 'Submitted',
          'extra_note': '',
          'reviewed_by': '',
        });

        FirebaseFirestore.instance
            .collection('USERS')
            .doc(plot.registered_by)
            .collection('CLIENT PROPERTY REQUESTS')
            .doc(request_id)
            .set({
          'plot_no': plot.plot_no.toUpperCase(),
          'date_reg': time,
          'search_query': plot.search_query,
          'request': user_option,
          'request_by': email_address.text,
          'request_id': request_id,
          'status': 'Submitted',
          'extra_note': '',
          'reviewed_by': '',
        });
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(plot.registered_by)
            .collection('ACTIVITIES')
            .doc(id)
            .set({
          'id': id,
          'activity_id': request_id,
          'activity_type': 'PROPERTY REQUEST',
          'activity_title': user_option == 'Landlord'
              ? ' ${plot.plot_no} Ownership Request'
              : ' ${plot.plot_no} Tenant Request',
          'activity_content': user_option == 'Landlord'
              ? 'Landlord ownership request on property ${plot.plot_no}'
              : 'Tenant request status on property ${plot.plot_no}',
          'activity_sq': plot.search_query,
          'activity_date': time,
          'activity_read': false,
          'activity_user': currentUser!.email_address
        });
      }
    }
  }

  getFileType(filename_) {
    if (filename_.toString().toLowerCase().contains('.mp4')) {
      return 'video/mp4';
    }
    if (filename_.toString().toLowerCase().contains('.pdf')) {
      return 'application/pdf';
    }
    if (filename_.toString().toLowerCase().contains('.doc') ||
        filename_.toString().toLowerCase().contains('.docx')) {
      return 'application/msword';
    }

    if (filename_.toString().toLowerCase().contains('.ppt') ||
        filename_.toString().toLowerCase().contains('.pptx')) {
      return 'application/vnd.ms-powerpoint';
    }

    if (filename_.toString().toLowerCase().contains('.xls') ||
        filename_.toString().toLowerCase().contains('.xlsx')) {
      return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    }

    if (filename_.toLowerCase().contains('.webp')) {
      return 'image/webp';
    }
    if (filename_.toLowerCase().contains('.jpg')) {
      return 'image/jpg';
    }
    if (filename_.toLowerCase().contains('.jpeg')) {
      return 'image/jpeg';
    }
    if (filename_.toLowerCase().contains('.png')) {
      return 'image/png';
    }
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
                contentType: getFileType(id_filename[i])));

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

  List<bool> _isShow = [
    false,
    false,
    false,
  ];

  String plot_id_search = '';

  Container addHomeBar(double height, double width) {
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
        child: Form(
          key: _formKey3,
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
                        hintStyle: const TextStyle(
                            fontSize: 14, color: Colors.black45),
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
                      color: sys_green,
                      borderRadius: BorderRadius.circular(50)),
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
      ),
    );
  }

  List<String> selected_plot_id = [];
  List<PropertyF> selected_plot = [];

  bool property_exist = false;
  void propertyCheck(String value) async {
    DocumentSnapshot checkProperty = await FirebaseFirestore.instance
        .collection('PROPERTY REPO')
        .doc(value)
        .get();
    if (checkProperty.exists) {
      PropertyF property = PropertyF.fromDocument(checkProperty);
      if (property.property_owner.isNotEmpty) {
        setState(() {
          property_exist = true;
        });
      } else {
        setState(() {
          property_exist = false;
        });
      }
    } else {
      setState(() {
        property_exist = false;
      });
    }
  }

  SingleChildScrollView propertySwichtScreen(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: width,
            height: 500,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        addHomeBar(60, 500),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Card(
                              child: plot_id_search.isNotEmpty
                                  ? FutureBuilder<DocumentSnapshot>(
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
                                                child: sys_constants.imgHolder(
                                                    width, houses_searching),
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
                                                child: sys_constants.imgHolder(
                                                    width, houses_searching),
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
                                          if (!selected_plot_id
                                              .contains(property.plot_no)) {
                                            if (property
                                                .property_owner.isEmpty) {
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
                                                                              5),
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
                                                                child:
                                                                    TextButton(
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
                                                                            CrossAxisAlignment.start,
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
                                                                            MainAxisAlignment.spaceBetween,
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
                                                                    : Colors
                                                                        .blue,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Card(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons.clear,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                          Card(
                                                            child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  selected_plot_id
                                                                      .add(property
                                                                          .plot_no);
                                                                  selected_plot.add(
                                                                      property);
                                                                  plot_id_search =
                                                                      '';
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.add_home,
                                                                color:
                                                                    sys_green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
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
                                                            realtor_rafiki),
                                                  )
                                                ],
                                              );
                                            }
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
                                        } else {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: sys_constants.imgHolder(
                                                    width, houses_searching),
                                              )
                                            ],
                                          );
                                        }
                                      },
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: sys_constants.imgHolder(
                                              width, houses_searching),
                                        )
                                      ],
                                    ),
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 10, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'SELECTED ${selected_plot_id.length}:',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              width: width,
                              height: height,
                              child: GridView.builder(
                                  itemCount: selected_plot_id.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5.0,
                                          mainAxisSpacing: 5.0,
                                          childAspectRatio: 0.8),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 200,
                                      height: 180,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            height: 180,
                                            child: Image(
                                              image: AssetImage(
                                                sys_constants.houseStatusIll(
                                                    selected_plot[index]
                                                        .status),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 180,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      35, 100, 80, 35),
                                              child: Container(
                                                width: 200,
                                                height: 180,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      selected_plot[index]
                                                          .plot_no
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 0,
                                            child: SizedBox(
                                                width: 45,
                                                height: 45,
                                                child: Card(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            selected_plot.remove(
                                                                selected_plot[
                                                                    selected_plot_id
                                                                        .indexOf(
                                                                            selected_plot_id[index])]);
                                                          });
                                                        },
                                                        icon: Icon(
                                                            Icons.close)))),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          user_option.isNotEmpty
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: sys_green,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            switccc_index = 0;
                          });
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: white,
                        ),
                      ),
                    ),
                    selected_plot_id.isNotEmpty
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: sys_green,
                                borderRadius: BorderRadius.circular(20)),
                            child: is_registring
                                ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircularProgressIndicator(
                                      color: white,
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      if (selected_plot.isNotEmpty) {
                                        registerUser();
                                      }
                                    },
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: white,
                                    ),
                                  ),
                          )
                        : SizedBox(),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  void setTimer2() {
    Timer(
        Duration(seconds: 1),
        () => {
              setState(() {
                _isShow[0] = true;
              })
            });
    Timer(
      Duration(seconds: 3),
      () => {
        setState(() {
          _isShow[1] = true;
        })
      },
    );
    Timer(
        Duration(seconds: 4),
        () => {
              setState(() {
                _isShow[2] = true;
              })
            });
  }

  getIcon() {
    if (user_option == 'Landlord') {
      return Icons.real_estate_agent;
    } else if (user_option == 'Tenant') {
      return FontAwesomeIcons.houseUser;
    } else if (user_option == 'Support') {
      return Icons.support_agent;
    } else {
      return Icons.home;
    }
  }

  Row defaultScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 250,
                  height: 400,
                  child: Image(
                    image: AssetImage(bot_amico),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                AnimatedOpacity(
                  opacity: isShow[0] ? 1 : 0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedOpacity(
                  opacity: isShow[1] ? 1 : 0,
                  duration: const Duration(seconds: 3),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'I\'m Ubair Bot and i will guide you through\ncreating your account.\n\nLets get started.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AnimatedOpacity(
                  opacity: isShow[2] ? 1 : 0,
                  duration: const Duration(seconds: 3),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Are you a',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    AnimatedOpacity(
                      opacity: isShow[3] ? 1 : 0,
                      duration: const Duration(seconds: 4),
                      child: Card(
                        color: user_option == 'Landlord'
                            ? sys_green
                            : Colors.white,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              user_option = 'Landlord';
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      user_option == 'Landlord'
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: user_option == 'Landlord'
                                          ? white
                                          : Colors.black87,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  Icons.real_estate_agent,
                                  size: 30,
                                  color: user_option == 'Landlord'
                                      ? white
                                      : Colors.black87,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Landlord',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: user_option == 'Landlord'
                                              ? white
                                              : Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AnimatedOpacity(
                      opacity: isShow[4] ? 1 : 0,
                      duration: const Duration(seconds: 5),
                      child: Card(
                        color:
                            user_option == 'Tenant' ? sys_green : Colors.white,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              user_option = 'Tenant';
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      user_option == 'Tenant'
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: user_option == 'Tenant'
                                          ? white
                                          : Colors.black87,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  FontAwesomeIcons.houseUser,
                                  size: 27,
                                  color: user_option == 'Tenant'
                                      ? white
                                      : Colors.black87,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tenant',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: user_option == 'Tenant'
                                              ? white
                                              : Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AnimatedOpacity(
                      opacity: isShow[5] ? 1 : 0,
                      duration: const Duration(seconds: 6),
                      child: Card(
                        color:
                            user_option == 'Support' ? sys_green : Colors.white,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              user_option = 'Support';
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      user_option == 'Support'
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: user_option == 'Support'
                                          ? white
                                          : Colors.black87,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  Icons.support_agent,
                                  size: 30,
                                  color: user_option == 'Support'
                                      ? white
                                      : Colors.black87,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Support',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: user_option == 'Support'
                                              ? white
                                              : Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            user_option.isNotEmpty
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: sys_green,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              switcc_index = 1;
                              ;
                            });
                          },
                          child: Icon(
                            Icons.chevron_right,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }

  Widget verifySwichtScreen(double width, double height) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 250,
                    height: 400,
                    child: Image(
                      image: AssetImage(bot_amico),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      AnimatedOpacity(
                        opacity: _isShow[0] ? 1 : 0,
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Successfully 🥳',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AnimatedOpacity(
                        opacity: _isShow[1] ? 1 : 0,
                        duration: const Duration(seconds: 3),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '${full_name.text.split(' ')[0]} Your\'ve successfully sign up on Ubairgo, go ahead \nand sign in while we validate your account 👨‍💻.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AnimatedOpacity(
                        opacity: _isShow[2] ? 1 : 0,
                        duration: const Duration(seconds: 4),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Thank you ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _isShow[2]
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Sign In'),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void registerLandlord() {}
}
