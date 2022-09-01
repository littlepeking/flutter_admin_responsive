import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_custom_attributes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EHToastMsgType { Successful, Error }

class EHToastMessageHelper {
  static showInfoMessage(String message,
      {String title = 'Message Infomation',
      EHToastMsgType type = EHToastMsgType.Successful}) {
    final ThemeCustomAttributes themeCustomAttributes =
        Theme.of(Get.context!).extension<ThemeCustomAttributes>()!;

    Get.snackbar(title.tr, message.tr,
        maxWidth: 500,
        barBlur: 20.0,
        boxShadows: [
          BoxShadow(
              color: ThemeController.instance.isDarkMode.value
                  ? Color.fromARGB(255, 81, 80, 80)
                  : Colors.grey,
              offset: Offset(2, 2),
              spreadRadius: 2,
              blurRadius: 8)
        ],
        backgroundColor: ThemeController.instance.isDarkMode.value
            ? Color.fromARGB(255, 68, 68, 68)
            : Colors.white,
        //backgroundColor: Colors.grey,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.info,
            color: type == EHToastMsgType.Successful
                ? Colors.green
                : ThemeController.instance.isDarkMode.value
                    ? Colors.yellow
                    : Colors.red),
        // forwardAnimationCurve: Curves.easeOutBack,
        //colorText: Colors.black,
        shouldIconPulse: true,

        // backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 3000),
        titleText: Text(
          title.tr,
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ),
        messageText: Text(
          message.tr,
          style: Theme.of(Get.context!).textTheme.bodyText1,
        ),
        isDismissible: true,
        mainButton: TextButton(
          child: Text(
            'Close'.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeCustomAttributes.textColor),
          ),
          onPressed: () => Get.closeCurrentSnackbar(),
        ));
  }

  static showLoginErrorMessage(String message,
      {String title = 'Message Infomation'}) {
    Get.snackbar(title.tr, message.tr,
        maxWidth: 500,
        barBlur: 5.0,
        //backgroundColor: Colors.grey,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.info, color: Colors.yellow),
        // forwardAnimationCurve: Curves.easeOutBack,
        //colorText: Colors.black,
        shouldIconPulse: true,

        // backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 3000),
        titleText: Text(
          title.tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        messageText: Text(
          message.tr,
          style: TextStyle(color: Colors.white),
        ));
  }
}
