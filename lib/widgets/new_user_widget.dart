import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:ubairgo/functions/sys_constants.dart';
import 'package:ubairgo/model/property_model.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../screens/splash.dart';

class UserRegWidget extends StatefulWidget {
  @override
  State<UserRegWidget> createState() => _UserRegWidget();
}

class _UserRegWidget extends State<UserRegWidget> {
  String plot_id_search = '';
  SysConstants sys_constants = SysConstants();
  final _formKey1 = GlobalKey<FormState>();

  final List<String> support_types = [
    'Estate Client',
    'Estate Support',
    'Emergency Support',
  ];

  String sel_support = '';

  final List<String> ec_role = [
    'Lanlord',
    'Tenant',
    'Client',
  ];
  String sel_ec_role = '';

  final List<String> estate_s_role = [
    'Engineer',
    'Realtor',
    'Architect',
    'Interior Designer',
  ];
  String sel_es_role = '';

  final List<String> emergency_s_role = [
    'Police Assistant',
    'Hospital Assistant',
    'E-Security Asistant',
  ];
  String sel_ems_role = '';

  List<String> list_sel_role = [];
  String selected_role = '';

  TextEditingController add_plot_txt = TextEditingController();

  void setRole() {
    if (sel_support == 'Estate Support') {
      list_sel_role = estate_s_role;
    } else if (sel_support == 'Emergency Support') {
      list_sel_role = emergency_s_role;
    } else if (sel_support == 'Estate Client') {
      list_sel_role = ec_role;
    } else {
      list_sel_role = [];
    }
  }

  TextEditingController full_name = TextEditingController();
  TextEditingController email_address = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController id_number = TextEditingController();

  bool user_exist = false;

  List<String> genderTypes = ['Male', 'Female', 'Other'];
  String sel_gender = '';

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

  Uint8List? profile_pic;
  String profile_pic_str = '';
  dynamic _pickImageError;

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

  List<Uint8List> id_filebyte = [];
  List<dynamic> id_filename = [];

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

  List<String> id_types = [
    'International Passport',
    'Driver\'s License',
    'National ID card '
  ];
  String sel_id = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: sys_green,
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'NOTE: Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    height: 185,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 5,
                                left: 5,
                                bottom: 5,
                                right: 5,
                                child: profile_pic == null
                                    ? Container(
                                        width: 150,
                                        height: 150,
                                        child: Center(
                                          child: Icon(
                                            Icons.account_circle,
                                            color: Colors.grey.shade200,
                                            size: 130,
                                          ),
                                        ))
                                    : Container(
                                        width: 150,
                                        height: 150,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 140,
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
                                bottom: 10,
                                right: 10,
                                child: IconButton(
                                  onPressed: () {
                                    pickPPPressed();
                                  },
                                  icon:
                                      Icon(Icons.add_a_photo, color: sys_green),
                                ),
                              ),
                            ],
                          ),
                          //child: ,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: 185,
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Full Name Required';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                              color: Colors.black,
                                              fontSize: 14),
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: width,
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      labelText: 'Phone Number',
                                      hintText: '',
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
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 10),
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
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                      buttonPadding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: id_types
                                          .map((item) =>
                                              DropdownMenuItem<String>(
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
                          width: 10,
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.card_membership,
                            size: 15,
                          ),
                          label: Text('Add ID'))
                    ],
                  ),
                  id_filebyte.isNotEmpty
                      ? SizedBox(
                          width: width,
                          height: 100,
                          child: Card(
                            color: Colors.grey.shade200,
                            child: SizedBox(
                              width: width,
                              height: 100,
                              child: id_filebyte.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: id_filebyte.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: Card(
                                            child: SizedBox(
                                              height: 100,
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 100,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Card(
                                                            child: SizedBox(
                                                              height: 100,
                                                              child:
                                                                  Image.memory(
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
                                                          child:
                                                              Icon(Icons.close),
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
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    height: 85,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                      buttonPadding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: support_types
                                          .map((item) =>
                                              DropdownMenuItem<String>(
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
                                          sel_support = value.toString();
                                        });
                                        setRole();

                                        //Do something when changing the item if you want.
                                      },
                                      onSaved: (value) {
                                        sel_support = value.toString();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        //Add more decoration as you want here
                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                      ),
                                      isExpanded: true,
                                      hint: const Text(
                                        'Role',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                      buttonHeight: 60,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: list_sel_role
                                          .map((item) =>
                                              DropdownMenuItem<String>(
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
                                          selected_role = value.toString();
                                        });
                                        //Do something when changing the item if you want.
                                      },
                                      onSaved: (value) {
                                        selected_role = value.toString();
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
                  extraWidget(
                    width,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: width,
                    height: 50,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.check_box_outline_blank,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'By clicking the check box you agree that this Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.',
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (!is_registring)
                          ? ElevatedButton.icon(
                              onPressed: () {
                                registerUser();
                              },
                              icon: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.person_add),
                              ),
                              label: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('Register'),
                              ))
                          : Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: sys_green,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
      'status': selected_role,
      'sys_status': sel_support,
      'rate': 0.0,
      'is_verified': true,
      'user_status': 'in_active',
      'id_type': sel_id,
      'id_number': id_number.text,
      'id_documents': id_document,
      'ref_note': '',
      'ref_documents': ref_document,
      'date_reg': DateTime.now(),
      'date_signin': DateTime.now(),
      'search_query': full_name.text.split(' '),
    }).then((value) {
      setState(() {
        is_registring = false;
      });
    });
    if (selected_role == 'Landlord' || selected_role == 'Tenant') {
      for (var i = 0; i < property_list.length; i++) {
        DateTime time = DateTime.now();
        String request_id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(email_address.text)
            .collection(selected_role == 'Landlord'
                ? 'OWN PROPERTY'
                : 'RENTED PROPERTY')
            .doc(property_list[i].plot_no)
            .set({
          'plot_no': property_list[i].plot_no,
          'date_reg': time,
          'search_query': property_list[i].search_query,
        });
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(currentUser!.email_address)
            .collection('REGISTERED PROPERTY')
            .doc(property_list[i].plot_no)
            .set({
          'plot_no': property_list[i].plot_no,
          'date_reg': time,
          'search_query': property_list[i].search_query,
        });
        String id = Uuid().v4();
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(email_address.text)
            .collection('ACTIVITIES')
            .doc(id)
            .set({
          'id': id,
          'activity_id': property_list[i].plot_no.toUpperCase(),
          'activity_type': 'PROPERTY_REG',
          'activity_title': 'Registered as ${selected_role}',
          'activity_content':
              'You are now a ${selected_role} at property ${property_list[i].plot_no.toUpperCase()}',
          'activity_sq': property_list[i].search_query,
          'activity_date': time,
          'activity_read': false,
          'activity_user': currentUser!.email_address
        });

        if (property_list[i].property_handler.isNotEmpty) {
          FirebaseFirestore.instance
              .collection('USERS')
              .doc(property_list[i].property_handler)
              .collection('HANDLE PROPERTY')
              .doc(property_list[i].plot_no.toUpperCase())
              .set({
            'plot_no': property_list[i].plot_no.toUpperCase(),
            'date_reg': time,
            'search_query': property_list[i].search_query,
          }).then((value) {
            String id = Uuid().v4();
            FirebaseFirestore.instance
                .collection('USERS')
                .doc(property_list[i].property_handler)
                .collection('ACTIVITIES')
                .doc(id)
                .set({
              'id': id,
              'activity_id': property_list[i].plot_no.toUpperCase(),
              'activity_type': 'PROPERTY_REG',
              'activity_title':
                  '${selected_role} registered on ${property_list[i].plot_no.toUpperCase()}',
              'activity_content':
                  '${email_address.text}: now as the property ${selected_role}',
              'activity_sq': property_list[i].search_query,
              'activity_date': time,
              'activity_read': false,
              'activity_user': currentUser!.email_address
            });
          });
        }
      }
    }
    if (sel_support == 'Estate Support') {
      FirebaseFirestore.instance
          .collection('SUPPORT AGENTS')
          .doc(email_address.text)
          .set({
        'id': email_address.text,
        'date_reg': DateTime.now(),
        'email_address': email_address.text,
        'search_query': full_name.text.split(' '),
      });
    } else if (sel_support == 'Emergency Support') {
      FirebaseFirestore.instance
          .collection(selected_role.toUpperCase())
          .doc(email_address.text)
          .set({
        'id': email_address.text,
        'date_reg': DateTime.now(),
        'email_address': email_address.text,
        'search_query': full_name.text.split(' '),
      });
    }

    setState(() {
      is_registring = false;
      full_name.text = '';
      email_address.text = '';
      phone_number.text = '';
      sel_gender = '';
      sel_support = '';
      selected_role = '';
      id_number.text = '';
      list_sel_role.clear();
      plot_id_search = '';
      add_plot_txt.text = '';
      property_ids.clear();
      property_list.clear();
      profile_pic = null;
      profile_pic_str = '';
      id_filebyte.clear();
      id_filename.clear();
      ref_doc_filebyte.clear();
      ref_doc_filename.clear();
    });
  }

  List<PropertyF> property_list = [];
  List<String> property_ids = [];
  Widget extraWidget(
    double width,
  ) {
    if (sel_support == 'Landlord' || selected_role == 'Tenant') {
      return SizedBox(
          width: width,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: width,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: addHomeBar(50, width),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  height: 500,
                  width: width,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('PROPERTY REPO')
                          .where('search_query', arrayContains: plot_id_search)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data!.docs.length > 0) {
                          return ScaledList(
                            itemCount: snapshot.data!.docs.length,
                            itemColor: (index) {
                              return sys_green;
                            },
                            itemBuilder: (index, selectedIndex) {
                              PropertyF property = PropertyF.fromDocument(
                                  snapshot.data!.docs[index]);
                              return Container(
                                width: width,
                                height: selectedIndex == index ? 800 : 600,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
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
                                      height: 500,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: width,
                                              height: 500,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: width,
                                                  height: 500,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
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
                                                          color: Colors.grey,
                                                          offset: Offset(0, 0),
                                                          blurRadius: 1.5),
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
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 10, 10),
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {});
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          property.plot_no
                                                              .toString()
                                                              .toUpperCase(),
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: black),
                                                        ),
                                                        Text(
                                                          "${property.size} m²",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "₦${property.amount}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
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
                                                          Color.fromARGB(226,
                                                              33, 149, 243),
                                                          Color.fromARGB(226,
                                                              33, 149, 243),
                                                        ])),
                                              child: Center(
                                                child: Text(
                                                  property.status,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 3,
                                              height: 70,
                                              color:
                                                  property.status == 'For Sale'
                                                      ? sys_green
                                                      : Colors.blue,
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
                                                  .contains(property.plot_no)) {
                                                setState(() {
                                                  property_list.remove(
                                                      property_list[index]);
                                                  property_ids.remove(
                                                      property_ids[index]);
                                                });
                                              } else {
                                                setState(() {
                                                  property_ids
                                                      .add(property.plot_no);
                                                  property_list.add(property);
                                                });
                                              }
                                            },
                                            icon: Icon((property_ids
                                                    .contains(property.plot_no))
                                                ? Icons.check_box
                                                : Icons
                                                    .check_box_outline_blank),
                                            color: (property_ids
                                                    .contains(property.plot_no))
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
          ));
    } else if (sel_support == 'Estate Support' ||
        sel_support == 'Emergency Support') {
      return SizedBox(
        width: width,
        height: 150,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    onPressed: () {
                      pickRefDocPressed();
                    },
                    icon: Icon(
                      Icons.file_present,
                      size: 15,
                    ),
                    label: Text('Refence Document'))
              ],
            ),
            Expanded(
              child: SizedBox(
                width: width,
                height: 150,
                child: Card(
                  color: Colors.grey.shade200,
                  child: SizedBox(
                    width: width,
                    height: 150,
                    child: id_filebyte.isNotEmpty
                        ? ListView.builder(
                            itemCount: ref_doc_filebyte.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Card(
                                  child: SizedBox(
                                    height: 100,
                                    child: Stack(children: [
                                      SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Card(
                                                  child: SizedBox(
                                                    height: 100,
                                                    child: Image.memory(
                                                      ref_doc_filebyte[index],
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                  ref_doc_filebyte[index]);
                                              ref_doc_filename.remove(
                                                  ref_doc_filename[index]);
                                            });
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Icon(Icons.close),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upload picture\'s of your ID documennt',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
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
}
