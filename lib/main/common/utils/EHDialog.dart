import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'responsive.dart';

class EHDialog {
  static getPopupDialog(Widget widget,
      {String title = 'Please Select Item', FocusNode? focusNode}) async {
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

    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.only(top: 10),
          title: Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Expanded(
                  child: Text(
                title.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  onPressed: () {
                    Get.back();
                    focusNode?.requestFocus();
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          children: [
            Container(
                height: Responsive.dialogHeight(Get.context!) - 70,
                width: Responsive.dialogWidth(Get.context!),
                child: widget)
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
