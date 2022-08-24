import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'permission_detail_view_controller.dart';
import 'permission_model.dart';

class PermissionDetailView extends EHPanel<PermissionDetailViewController> {
  PermissionDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => EHEditForm<PermissionModel>(
            controller: controller.getWidgetControllerFormController!())),
      ],
    );
  }
}
