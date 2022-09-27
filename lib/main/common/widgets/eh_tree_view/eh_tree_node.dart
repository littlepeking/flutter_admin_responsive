import 'package:flutter/material.dart';

/// One node data of a tree.
class EHTreeNode {
  Key? key;

  String? id;

  EHTreeNode? parentTreeNode;

  IconData? icon;

  String displayNameMsgKey;

  dynamic data;

  bool? isChecked;

  bool hideCheckBox;

  bool isSelected;

  bool? isExpanded;

  List<EHTreeNode>? children;

  VoidCallback? onTap;

  bool? disableTap;

  Set<String> permissionCodes;

  EHTreeNode(
      {this.key,
      this.id,
      this.parentTreeNode,
      required this.displayNameMsgKey,
      this.icon,
      this.isExpanded,
      this.isChecked = false,
      this.hideCheckBox = false,
      this.onTap,
      this.children = const [],
      this.isSelected = false,
      this.data,
      this.disableTap,
      this.permissionCodes = const {}});
}
