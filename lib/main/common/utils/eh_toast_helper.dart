import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHToastMessageHelper {
  static showInfoMessage(String message,
      {String title = 'Message Infomation'}) {
    Get.snackbar(title.tr, message.tr,
        maxWidth: 500,
        barBlur: 5.0,
        //backgroundColor: Colors.grey,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.info,
            color: ThemeController.instance.isDarkMode.value
                ? Colors.yellow
                : Colors.red),
        // forwardAnimationCurve: Curves.easeOutBack,
        //colorText: Colors.black,
        shouldIconPulse: false,

        // backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 2000),
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
