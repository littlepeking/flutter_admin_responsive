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

import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'responsive.dart';

class EHDialog {
  static showPopupDialog(Widget widget,
      {String titleMsgKey = 'common.general.selectItem',
      FocusNode? focusNode,
      bool barrierDismissible = true,
      double? width,
      double? height}) async {
    // return Get.dialog(
    //   titlePadding: EdgeInsets.only(top: 20),
    //   titleStyle: TextStyle(fontWeight: FontWeight.bold),
    //   radius: 5,
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: Text("Close".tr),
    //       onPressed: () {
    //         Get.back();
    //       },
    //     )
    //   ],
    //   barrierDismissible: false,
    //   title: title.tr,
    //   content: Container(
    //       height: 500,
    //       width: Responsive.dialogWidth(Get.context!),
    //       child: widget),
    // );

    return await showDialog<bool>(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: Responsive.isMobile(Get.context!)
              ? EdgeInsets.zero
              : EdgeInsets.only(left: 0, right: 0, bottom: 15, top: 5),
          insetPadding: EdgeInsets.zero,
          children: [
            Container(
              child: Row(
                children: [
                  if (!Responsive.isDesktop(Get.context!))
                    IconButton(
                      padding: EdgeInsets.only(left: 10),
                      onPressed: () {
                        Get.back(result: false);
                        focusNode?.requestFocus();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: EHThemeHelper.getTextColor(),
                      ),
                    ),
                  Expanded(
                      child: Text(
                    titleMsgKey.tr,
                    style: TextStyle().copyWith(
                        fontSize: Theme.of(Get.context!)
                            .textTheme
                            .displaySmall!
                            .fontSize,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  if (Responsive.isDesktop(Get.context!))
                    IconButton(
                        padding: EdgeInsets.only(right: 20),
                        onPressed: () {
                          Get.back(result: false);
                          focusNode?.requestFocus();
                        },
                        icon: Icon(Icons.close))
                ],
              ),
            ),
            Container(
                height: height ?? Responsive.dialogHeight(Get.context!) - 73,
                width: width ?? Responsive.dialogWidth(Get.context!),
                child: widget),
          ],
          elevation: 10,
          //backgroundColor: Colors.green,
        );
      },
    );
  }
}

                            // set up the button
                            // Widget okButton = TextButton(
                            //   child: Text("OK"),
                            //   onPressed: () {
                            //     Navigator.pop(context, "Pizza");
                            //   },
                            // );

                            // // set up the AlertDialog
                            // AlertDialog alert = AlertDialog(
                            //   title: Text("My title"),
                            //   content: Text("This is my message."),
                            //   actions: [
                            //     okButton,
                            //   ],
                            // );

                            // // show the dialog
                            // await showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return alert;
                            //   },
                            // );
