import 'package:flutter/material.dart';

/// One node data of a tree.
class EHTreeNodeData {
  Key? key;

  IconData? icon;

  String displayName;

  Map data;

  bool? isChecked;

  bool isExpanded;

  List<EHTreeNodeData>? children;

  VoidCallback? onTap;

  EHTreeNodeData(
      {this.key,
      required this.displayName,
      this.icon,
      this.isExpanded = false,
      this.isChecked,
      this.onTap,
      this.children = const [],
      this.data = const {}});
}
