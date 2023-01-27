import 'package:flutter/material.dart';
import 'package:ubairgo/styles/colors.dart';
import 'package:ubairgo/styles/sysimg_constants.dart';

class SysConstants {
  Widget ubairgoHorizontal(double width) {
    return Image(
      image: AssetImage(ubair_w_hr_h),
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  Widget ubairgoHorizontalTM(double height) {
    return Image(
      image: AssetImage(ubairgo_hr_tm),
      height: height,
      fit: BoxFit.fitHeight,
    );
  }

  Widget ubairgoWhite(double height) {
    return Image(
      image: AssetImage(ubairgo_white),
      height: height,
      fit: BoxFit.fitWidth,
    );
  }

  Widget fromQima(double width) {
    return Image(
      image: AssetImage(qima_dev),
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  Widget houseAmico(double width) {
    return Image(
      image: AssetImage(houses_amico),
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  Widget googleImg(double width) {
    return Image(
      image: AssetImage(google),
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  Widget houseImages(String img) {
    return Image(
      image: AssetImage(img),
      fit: BoxFit.cover,
    );
  }

  Widget houseWaiting(double width) {
    return Image(
      image: AssetImage(house_waiting),
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  Color getRandomColor(String s) {
    //int ran = random.nextInt(5);
    if (s.toUpperCase() == 'Estate Support') {
      return Colors.blue;
    } else if (s.toUpperCase() == 'Emergency Support') {
      return Colors.teal;
    } else {
      return sys_green;
    }
  }

  Column userWview(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey.shade100,
                        child: Text(
                          '                                     ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.grey.shade100,
                            child: Text(
                              '                     ',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: Colors.grey.shade100,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade100,
          width: 90,
          height: 15,
        )
      ],
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

  List<String> allowedext() {
    return [
      'png',
      'jpg',
      'jpeg',
      'pdf',
    ];
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return '$b\_$a';
    } else {
      return '$a\_$b';
    }
  }

  Widget imgHolder(double width, String img) {
    return Image(
      image: AssetImage(img),
      width: width,
      fit: BoxFit.fitWidth,
    );
  }

  String houseStatusIll(String status) {
    if (status == 'For Rent') {
      return for_rent;
    } else if (status == 'For Sale') {
      return for_sale;
    } else if (status == 'For Lease') {
      return for_lease;
    } else {
      return occupied;
    }
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
        ],
      );
    }
  }
}
