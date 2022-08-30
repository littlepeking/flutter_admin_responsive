import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/components/org_role_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_edit_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'org_role_list_controller.dart';
import 'role_edit_controller.dart';

class OrgRoleListView extends EHPanel<OrgRoleListController> {
  OrgRoleListView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildToolbar(context),
      PageStorage(
        bucket: controller.pageStorageBucket,
        child: Expanded(
          child: OrgRoleComponent(
            controller: controller.orgRoleComponentController,
          ),
        ),
      )
    ]);
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            Get.find<SystemModuleController>().tabViewController.addTab(
                    EHTab<RoleEditController>(
                        'Edit User', await RoleEditController.create(),
                        (EHController controller) {
                  return RoleEditView(controller: controller);
                }, closable: true));
          },
          child: Text('Add'.tr),
        )),
        EHButton(
            controller: EHButtonController(
          child: Text('Delete'.tr),
          onPressed: () async {},
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
            items: {
              'exportToExcel': 'Export To Excel',
            },
            onChanged: (value) {},
          )),
        )
      ],
    );
  }
}
