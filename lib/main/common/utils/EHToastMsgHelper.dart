import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHToastMessageHelper {
  static showInfoMessage(String message,
      {String title = 'Message Infomation'}) {
    Get.snackbar(title.tr, message.tr,
        barBlur: 13.0,
        margin: EdgeInsets.all(10),
        //colorText: Colors.black,
        // backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 2000));
  }
}
