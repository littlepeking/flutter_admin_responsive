import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class EHImageButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;

  const EHImageButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: onPressed,
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
                  // if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(text),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            )));
  }
}
