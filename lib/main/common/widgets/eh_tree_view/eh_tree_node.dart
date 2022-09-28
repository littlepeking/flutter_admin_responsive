/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

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
