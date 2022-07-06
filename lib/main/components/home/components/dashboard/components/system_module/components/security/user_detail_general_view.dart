import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/models/user_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_detail_general_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailGeneralView extends EHPanel<UserDetailGeneralController> {
  UserDetailGeneralView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => EHEditForm<UserModel>(
            controller: controller.getEditFormController!())),
      ],
    );
  }
}
