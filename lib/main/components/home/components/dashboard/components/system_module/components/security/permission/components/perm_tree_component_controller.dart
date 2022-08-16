import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../permission_services.dart';
import '../permission_model.dart';

typedef PermTreeNodeOnTap = void Function(PermissionModel? model);

class PermTreeComponentController extends EHPanelController {
  late EHTreeController permTreeController;

  late PermTreeNodeOnTap onTap;

  PermTreeComponentController._create(EHPanelController parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<PermTreeComponentController> create(EHPanelController parent,
      {PermTreeNodeOnTap? onTap}) async {
    PermTreeComponentController self =
        PermTreeComponentController._create(parent);

    self.onTap = onTap ?? ((model) => {});

    self.permTreeController = EHTreeController(
        displaySelectedItems: true,
        allNodesExpanded: true,
        treeNodeDataList: <EHTreeNode>[].obs);

    await self.reloadPermTreeData();

    return self;
  }
}
