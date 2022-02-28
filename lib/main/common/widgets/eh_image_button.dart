import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../constants.dart';

class EHImageButton<T> extends StatelessWidget {
  final Icon icon;
  final String text;
  final ValueChanged<T?> onPressed;
  final T? data;

  const EHImageButton(
      {Key? key,
      required this.icon,
      required this.text,
      this.data,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobile(context))
        ? IconButton(
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
