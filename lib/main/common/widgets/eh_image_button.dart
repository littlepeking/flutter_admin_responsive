import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
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

  const EHImageButton(
      {Key? key,
      this.padding = 2,
      required this.icon,
      this.iconSize,
      required this.text,
      this.data,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobile(context))
        ? IconButton(
            iconSize: iconSize ?? 24,
            padding: EdgeInsets.all(
                padding ?? (Responsive.isMobile(Get.context!) ? 2 : 8)),
            onPressed: () => onPressed(data),
            icon: icon,
            tooltip: this.text.tr,
          )
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => onPressed(data),
                child: Container(
                  margin: EdgeInsets.only(left: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
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
                )));
  }
}
