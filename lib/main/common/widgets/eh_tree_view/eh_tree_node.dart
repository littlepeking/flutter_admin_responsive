import 'package:flutter/widgets.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class EHTreeNode extends TreeNode {
  EHTreeNode(
      {Key? key,
      List<EHTreeNode>? children,
      required String menuName,
      GestureTapCallback? onTap,
      IconData? icon})
      : super(
            key: key,
            children: children,
            content: Row(
              children: [
                if (icon != null) Icon(icon),
                SizedBox(width: 5),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Text(menuName.tr),
                    onTap: onTap,
                  ),
                ),
              ],
            ));
}
