import 'package:flutter/material.dart';

/// One node data of a tree.
class EHTreeNode {
  Key? key;

  String? id;

  EHTreeNode? parentTreeNode;

  IconData? icon;

  String displayName;

  dynamic data;

  bool? isChecked;

  bool isSelected;

  bool? isExpanded;

  List<EHTreeNode>? children;

  VoidCallback? onTap;

  EHTreeNode(
      {this.key,
      this.id,
      this.parentTreeNode,
      required this.displayName,
      this.icon,
      this.isExpanded,
      this.isChecked = false,
      this.onTap,
      this.children = const [],
      this.isSelected = false,
      this.data});
}
