import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/primitives/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../base/eh_edit_widget_controller.dart';

class EHTreeNode extends TreeNode {
  EHTreeNode(
      {Key? key,
      List<EHTreeNode>? children,
      required String displayName,
      bool showCheckBox = false,
      bool? checked,
      GestureTapCallback? onTap,
      IconData? icon})
      : super(
            key: key,
            children: children,
            content: Row(
              children: [
                if (showCheckBox) Checkbox(value: true, onChanged: (val) {}),
                if (icon != null) Icon(icon),
                SizedBox(width: 2),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Text(displayName.tr),
                    onTap: onTap,
                  ),
                ),
              ],
            ));
}
