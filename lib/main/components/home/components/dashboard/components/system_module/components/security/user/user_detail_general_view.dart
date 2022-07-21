import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_detail_general_controller.dart';
import 'user_model.dart';

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
