import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHToastMessageHelper {
  static showInfoMessage(String message,
      {String title = 'Message Infomation'}) {
    Get.snackbar(title.tr, message.tr,
        colorText: Colors.black,
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 2000));
  }
}
