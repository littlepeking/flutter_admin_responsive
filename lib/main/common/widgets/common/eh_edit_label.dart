import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHEditLabel extends StatelessWidget {
  EHEditLabel({Key? key, this.label = '', this.mustInput = false});

  final String label;
  final bool mustInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(children: [
        SizedBox(width: 5),
        Text(
          EHUtilHelper.isEmpty(label) ? '' : label + ':',
          style: TextStyle(

              // fontWeight:
              //     EHUtilHelper.isEmpty(controller.errorBucket![key])
              //         ? FontWeight.w500
              //         : FontWeight.bold,
              // color: EHUtilHelper.isEmpty(controller.errorBucket![key])
              //     ? ThemeController.getThemeColor(
              //         Colors.white, Colors.black)
              //     : ThemeController.getThemeColor(
              //         Colors.yellow.shade200, Colors.red)
              ),
        ),
        mustInput
            ? Obx(() => Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.check_circle,
                    color: EHThemeHelper.getThemeColor(
                        Colors.yellow.shade200, Colors.red),
                    size: 12,
                  ),
                ))
            : SizedBox()
      ]),
    );
  }
}
