import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'role_edit_controller.dart';

class RoleEditView extends EHPanel<RoleEditController> {
  RoleEditView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildToolbar(context),
        Expanded(
          child: EHTabsView(controller: controller.headerTabsViewController),
        ),
      ],
    );
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            if (await controller.roleGeneralInfoController.editFormController!
                .validate()) {
              //bool isCreateNewRole = controller.model.value.id == null;
              await RoleService()
                  .createOrUpdateRxModel(model: controller.model);
              await controller.updateRolePermissions(
                  roleId: controller.model.value.id!);
              controller.reloadData();
              EHToastMessageHelper.showInfoMessage('Role @displayName saved'
                  .trParams(
                      {'displayName': controller.model.value.displayName!}));
            }
          },
          child: Text('Save'.tr),
        )),
        Container(
          // width: 90,
          child: EHDropdown(
              controller: EHDropDownController(
            key: GlobalKey(),
            focusNode: FocusNode(),
            isMenu: true,
            dropDownWidth: 150,
            label: 'Actions',
            items: {'print': 'Print'},
            onChanged: (value) {},
          )),
        )
      ],
    );
  }
}
