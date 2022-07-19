import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// One node data of a tree.
class EHTreeNode {
  Key? key;

  IconData? icon;

  String displayName;

  Map data;

  bool? isChecked;

  bool isSelected;

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
      this.isSelected = false,
      this.data = const {}});
}
