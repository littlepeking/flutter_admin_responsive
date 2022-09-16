import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class EHImageButton<T> extends StatelessWidget {
  final Icon icon;
  final double? iconSize;
  final String text;
  final ValueChanged<T?> onPressed;
  final T? data;
  final double? padding;
  final bool? isSelected;

  const EHImageButton(
      {Key? key,
      this.padding = 2,
      required this.icon,
      this.isSelected,
      this.iconSize,
      required this.text,
      this.data,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobile(context))
        ? Obx(() => Container(
              child: IconButton(
                iconSize: iconSize ?? 24,
                padding: EdgeInsets.all(
                    padding ?? (Responsive.isMobile(Get.context!) ? 2 : 8)),
                onPressed: () => onPressed(data),
                icon: icon,
                tooltip: this.text.tr,
              ),
              decoration: BoxDecoration(
                border: isSelected == true
                    ? Border(
                        bottom: BorderSide(
                            width: 3.0, color: EHThemeHelper.getTextColor()))
                    : Border(
                        bottom: BorderSide(
                            width: 3.0,
                            color: EHThemeHelper.getBackgroundColor())),
              ),
            ))
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => onPressed(data),
                child: Obx(() => Container(
                      margin: EdgeInsets.only(left: defaultPadding),
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: isSelected == true
                                  ? BorderSide(
                                      width: 3.0,
                                      color: EHThemeHelper.getTextColor())
                                  : BorderSide(
                                      width: 3.0,
                                      color:
                                          EHThemeHelper.getBackgroundColor()))),
                      child: Row(
                        children: [
                          icon,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: Text(text.tr),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ))));
  }
}
