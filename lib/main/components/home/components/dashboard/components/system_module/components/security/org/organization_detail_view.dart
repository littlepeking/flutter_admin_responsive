import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'organization_detail_view_controller.dart';

class OrganizationDetailView extends EHPanel<OrganizationDetailViewController> {
  OrganizationDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => EHEditForm<OrganizationModel>(
            controller: controller.getWidgetControllerFormController!())),
      ],
    );
  }
}
