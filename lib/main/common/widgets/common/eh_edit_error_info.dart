import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_controller.dart';

class EHEditErrorInfo extends StatelessWidget {
  EHEditErrorInfo({
    Key? key,
    required this.errorBucket,
    this.errorFieldKey,
  });
  final Map errorBucket;
  final Key? errorFieldKey;
  @override
  Widget build(BuildContext context) {
    return EHUtilHelper.isEmpty(errorBucket[errorFieldKey])
        ? SizedBox(height: Responsive.isMobile(context) ? 0 : 5)
        : Center(
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    size: 18,
                    color: ThemeController.getThemeColor(
                        Colors.yellow.shade200, Colors.red)),
                Flexible(
                  child: Text(
                    errorBucket[errorFieldKey],
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    style: TextStyle(
                        color: ThemeController.getThemeColor(
                            Colors.yellow.shade200, Colors.red)),
                  ),
                )
              ],
            ),
          );
  }
}
