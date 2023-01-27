import 'package:flutter/material.dart';

import '../model/notice_board_model.dart';
import '../styles/colors.dart';
import '../styles/sysimg_constants.dart';

class NoticeboardWidget extends StatefulWidget {
  @override
  State<NoticeboardWidget> createState() => _NoticeboardWidgetState();
}

class _NoticeboardWidgetState extends State<NoticeboardWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.push_pin,
                  size: 22,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Notice Board',
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
            ),
            TextButton(onPressed: () {}, child: Text('View all'))
          ],
        ),
        Expanded(
          child: SizedBox(
            width: width,
            height: height,
            child: true
                ?

                // ignore: dead_code
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: AssetImage(notice_baord),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                // ignore: dead_code
                : ListView.builder(
                    itemCount: list_notice.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
                        child: Container(
                          width: 300,
                          height: height,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: Offset(0, 0),
                                    blurRadius: 2),
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: width,
                                  height: height,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              list_notice[index].date_time,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            list_notice[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (list_notice[index]
                                            .attachements
                                            .isNotEmpty)
                                          Expanded(
                                            child: SizedBox(
                                              width: width,
                                              height: height,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                      width: width,
                                                      height: height,
                                                      child: Image(
                                                        image: AssetImage(
                                                          list_notice[index]
                                                              .attachements[0],
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    if (list_notice[index]
                                                            .attachements
                                                            .length >
                                                        1)
                                                      Positioned(
                                                        bottom: 5,
                                                        right: 5,
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: sys_green,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                blurRadius: 1,
                                                                offset: Offset(
                                                                    0, 0),
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
                                        if (list_notice[index]
                                            .description
                                            .isNotEmpty)
                                          Column(
                                            children: [
                                              TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  list_notice[index]
                                                      .description,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: Icon(
                                    Icons.push_pin,
                                    color: list_notice[index].priority,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
