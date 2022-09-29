/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:eh_flutter_framework/main/common/utils/eh_theme_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_custom_attributes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/eh_check_mark.dart';

enum EHToastMsgType { Successful, Error }

class EHToastMessageHelper {
  static showInfoMessage(String message,
      {String titleMsgKey = 'common.general.messageInfo',
      EHToastMsgType type = EHToastMsgType.Successful}) {
    final ThemeCustomAttributes themeCustomAttributes =
        Theme.of(Get.context!).extension<ThemeCustomAttributes>()!;

    late SnackbarController snackbarController;

    snackbarController = Get.snackbar(titleMsgKey.tr, message.tr,
        maxWidth: 500,
        barBlur: 20.0,
        boxShadows: [
          BoxShadow(
              color: EHThemeHelper.isDarkMode.value
                  ? Color.fromARGB(255, 81, 80, 80)
                  : Colors.grey,
              offset: Offset(2, 2),
              spreadRadius: 2,
              blurRadius: 8)
        ],
        backgroundColor: EHThemeHelper.isDarkMode.value
            ? Color.fromARGB(255, 68, 68, 68)
            : Colors.white,
        //backgroundColor: Colors.grey,
        margin: EdgeInsets.all(10),
        icon: Icon(Icons.info,
            color: type == EHToastMsgType.Successful
                ? Colors.green
                : EHThemeHelper.isDarkMode.value
                    ? Color.fromARGB(255, 249, 164, 164)
                    : Colors.red),
        // forwardAnimationCurve: Curves.easeOutBack,
        //colorText: Colors.black,
        shouldIconPulse: true,

        // backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 3000),
        animationDuration: Duration(milliseconds: 500),
        titleText: Text(
          titleMsgKey.tr,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        messageText: Row(
          children: [
            if (type == EHToastMsgType.Successful)
              EHCheckMark()
            else if (type == EHToastMsgType.Error)
              Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 2,
                          color: EHThemeHelper.isDarkMode.value
                              ? Color.fromARGB(255, 249, 164, 164)
                              : Colors.red)),
                  child: Icon(
                    Icons.close,
                    color: EHThemeHelper.isDarkMode.value
                        ? Color.fromARGB(255, 249, 164, 164)
                        : Colors.red,
                    size: 35,
                  )),
            Expanded(
              child: Text(
                message.tr,
                style: Theme.of(Get.context!).textTheme.bodyLarge,
                softWrap: true,
                maxLines: 5,
              ),
            ),
          ],
        ),
        isDismissible: true,
        mainButton: TextButton(
          child: Text(
            'common.general.close'.tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeCustomAttributes.textColor),
          ),
          onPressed: () => snackbarController.close(),
        ));
  }

  static showLoginErrorMessage(String message,
      {String title = 'common.general.messageInfo'}) {
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
