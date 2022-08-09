import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrganizationRoleViewController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTreeController orgTreeController;

  OrganizationRoleViewController._create(EHPanelController parent)
      : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrganizationRoleViewController> create(
      EHPanelController parent) async {
    OrganizationRoleViewController self =
        OrganizationRoleViewController._create(parent);

    return self;
  }
}
