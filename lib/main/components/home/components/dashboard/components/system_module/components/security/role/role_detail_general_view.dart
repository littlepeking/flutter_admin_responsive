import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'role_detail_general_controller.dart';

class RoleDetailGeneralView extends EHPanel<RoleDetailGeneralController> {
  RoleDetailGeneralView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => EHEditForm<RoleModel>(
            controller: controller.getEditFormController!())),
      ],
    );
  }
}
