// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ubairgo/model/messeages.dart';
import 'package:ubairgo/model/user_model.dart';

import '../functions/sys_constants.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';

class ChatWidget extends StatefulWidget {
  UserModel? user_model;
  bool? is_back;
  ChatWidget({
    required this.user_model,
    required this.is_back,
  });
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  SysConstants sys_constants = SysConstants();

  var msg_textfield;

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
              ? Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (widget.is_back!)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(Icons.chevron_left),
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
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(width: 3),
                                        (widget.user_model!.is_verified)
                                            ? Icon(Icons.verified,
                                                size: 15, color: Colors.grey)
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              widget.user_model!.profile_pic),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ratingValue(
                                          widget.user_model!.rate, false),
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
                        child: SizedBox(
                      width: width,
                      height: height,
                      child: widget.user_model!.email_address ==
                              fatima.email_address
                          ? ListView.builder(
                              itemCount: conversation.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                MessageModel msg = conversation[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: SizedBox(
                                    width: 400,
                                    child: Row(
                                      mainAxisAlignment: msg.isme
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        msg.msg_type == 'shared_house'
                                            ? Container(
                                                width: 400,
                                                height: 350,
                                                decoration: BoxDecoration(
                                                    color: msg.isme
                                                        ? sys_green
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomLeft: msg.isme
                                                          ? Radius.circular(15)
                                                          : Radius.circular(0),
                                                      bottomRight: msg.isme
                                                          ? Radius.circular(0)
                                                          : Radius.circular(15),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(0, 0),
                                                          blurRadius: 1)
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: msg.isme
                                                        ? CrossAxisAlignment.end
                                                        : CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: SizedBox(
                                                          width: 400,
                                                          height: 290,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                width: 400,
                                                                height: 290,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Colors.white,
                                                                        image: DecorationImage(
                                                                            image: AssetImage(
                                                                              msg.attachement[0],
                                                                            ),
                                                                            fit: BoxFit.cover),
                                                                        boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors
                                                                              .grey,
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                          blurRadius:
                                                                              1)
                                                                    ]),
                                                              ),
                                                              Positioned(
                                                                bottom: 5,
                                                                right: 5,
                                                                child:
                                                                    Container(
                                                                  width: 35,
                                                                  height: 35,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          sys_green,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${msg.attachement.length - 1}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: msg.isme
                                                            ? CrossAxisAlignment
                                                                .end
                                                            : CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            msg.msg_content,
                                                            style: TextStyle(
                                                                color: msg.isme
                                                                    ? white
                                                                    : black,
                                                                fontSize: 16),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                msg.time,
                                                                style: TextStyle(
                                                                    color: msg
                                                                            .isme
                                                                        ? white
                                                                        : black,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: msg.isme
                                                      ? sys_green
                                                      : Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        offset: Offset(0, 0),
                                                        blurRadius: 1)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft: msg.isme
                                                        ? Radius.circular(15)
                                                        : Radius.circular(0),
                                                    bottomRight: msg.isme
                                                        ? Radius.circular(0)
                                                        : Radius.circular(15),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment: msg.isme
                                                        ? CrossAxisAlignment.end
                                                        : CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        msg.msg_content,
                                                        style: TextStyle(
                                                            color: msg.isme
                                                                ? white
                                                                : black,
                                                            fontSize: 16),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            msg.time,
                                                            style: TextStyle(
                                                                color: msg.isme
                                                                    ? white
                                                                    : black,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 250,
                                    child: sys_constants.imgHolder(
                                        250, work_chat)),
                              ],
                            ),
                    )),
                    Container(
                      width: width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(0, 0),
                              blurRadius: 5),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: TextField(
                                      controller: msg_textfield,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      decoration: InputDecoration(
                                        prefix: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.add),
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Message',
                                        hintStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45),
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
                    ),
                  ],
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
}
