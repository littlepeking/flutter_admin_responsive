import 'package:flutter/material.dart';

/// One node data of a tree.
class EHTreeNodeData {
  Key? key;

  IconData? icon;

  String displayName;

  Map data;

  bool? isChecked;

  List<EHTreeNodeData>? children;

  EHTreeNodeData(
      {this.key,
      required this.displayName,
      this.icon,
      this.isChecked,
      this.children = const [],
      this.data = const {}});
}
