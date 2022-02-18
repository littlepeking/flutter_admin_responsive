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

                            // _displayDialog(BuildContext context) async {
                            //   await showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return Expanded(
                            //         child: SimpleDialog(
                            //           title: Text('Choose food'),
                            //           children: [
                            //             SimpleDialogOption(
                            //                 onPressed: () {
                            //                   Navigator.pop(context, "Pizza");
                            //                   controller.focusNode!
                            //                       .requestFocus();
                            //                 },
                            //                 child: Container(
                            //                   width: 500,
                            //                   height: 500,
                            //                   child: EHDataGrid(
                            //                       controller:
                            //                           EHDataGridController(
                            //                     dataGridSource:
                            //                         controller._dataGridSource,
                            //                     onRowSelected: (row) {
                            //                       controller.onChanged!(
                            //                           row[controller
                            //                                   .codeColumnName]
                            //                               .toString(),
                            //                           row);

                            //                       Navigator.pop(
                            //                           context, "Pizza");

                            //                       controller.focusNode!
                            //                           .requestFocus();
                            //                     },
                            //                   )),
                            //                 )),
                            //           ],
                            //           elevation: 10,
                            //           //backgroundColor: Colors.green,
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }

                            // _displayDialog(context);