import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'responsive.dart';

class EHDialog {
  static getPopupDialog(Widget widget, {String title = 'Please Select Item'}) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 20),
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      radius: 5,
      actions: <Widget>[
        ElevatedButton(
          child: Text("Close".tr),
          onPressed: () {
            Get.back();
          },
        )
      ],
      barrierDismissible: false,
      title: title.tr,
      content: Container(
          height: 500,
          width: Responsive.dialogWidth(Get.context!),
          child: widget),
    );
  }
}
