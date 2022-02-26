import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHToastMessageHelper {
  static showInfoMessage(String message,
      {String title = 'Message Infomation'}) {
    Get.snackbar(title.tr, message.tr,
        maxWidth: 600,
        barBlur: 13.0,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.info, color: Colors.yellow),
        forwardAnimationCurve: Curves.easeOutBack,
        //colorText: Colors.black,
        // backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 3000),
        titleText: Text(
          title.tr,
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ),
        messageText: Text(
          message.tr,
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ));
  }
}
