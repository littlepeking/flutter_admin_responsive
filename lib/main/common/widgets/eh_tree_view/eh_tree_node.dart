import 'package:flutter/material.dart';

/// One node data of a tree.
class EHTreeNode {
  Key? key;

  IconData? icon;

  String displayName;

  Map data;

  bool? isChecked;

  bool? isExpanded;

  List<EHTreeNode>? children;

  VoidCallback? onTap;

  EHTreeNode(
      {this.key,
      required this.displayName,
      this.icon,
      this.isExpanded,
      this.isChecked = false,
      this.onTap,
      this.children = const [],
      this.data = const {}});
}
