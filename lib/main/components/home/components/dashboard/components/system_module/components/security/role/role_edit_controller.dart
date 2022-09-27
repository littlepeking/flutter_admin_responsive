import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_locale_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/components/perm_tree_component_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/permission/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import 'role_detail_general_view.dart';
import 'role_detail_general_controller.dart';
import 'role_model.dart';
import 'role_service.dart';

class RoleEditController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late Rx<RoleModel> model;

  late EHTabsViewController headerTabsViewController;

  late RoleDetailGeneralController roleGeneralInfoController;

  late PermTreeComponentController permTreeCompController;

  RoleEditController._create(Map<String, dynamic> params)
      : super(null, params: params);

  static Future<RoleEditController> create(
      {required Map<String, dynamic> params}) async {
    RoleEditController self = RoleEditController._create(params);

    self.permTreeCompController =
        await PermTreeComponentController.create(self, showCheckBox: true);

    self.model = RoleModel(orgId: params['orgId'], id: params['id']).obs;

    self.roleGeneralInfoController =
        await RoleDetailGeneralController.create(self, params);

    self.headerTabsViewController = EHTabsViewController(tabs: [
      EHTab('generalInfo', 'common.general.generalInfo',
          self.roleGeneralInfoController, (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: RoleDetailGeneralView(
              controller: c,
            ));
      }),
      EHTab(
          'funcPerms', 'common.security.funcPerms', self.permTreeCompController,
          (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: PermTreeComponent(
              controller: c,
            ));
      }),
    ]);

    await self.reloadData();

    return self;
  }

  reloadData() async {
    if (model.value.id != null) {
      model.value = (RoleModel.fromJson(
          await RoleService().findById(id: model.value.id!)));
      List permData =
          await PermissionService().buildTreeByRoleId(this.model.value.id!);
      permTreeCompController.reloadPermTreeData(permData);
      headerTabsViewController.getTab('funcPerms').isHide = false;
    } else {
      headerTabsViewController.getTab('funcPerms').isHide = true;
    }
    headerTabsViewController.tabsConfig.refresh();
  }

  Future<List> updateRolePermissions({required String roleId}) async {
    List<EHTreeNode> treeNodeList = permTreeCompController.permTreeController
        .getAllFilteredNodes((node) =>
            (node.data as PermissionModel).type == 'P' &&
            node.isChecked == true);

    List<String> permissionIds = treeNodeList.map((e) => e.id!).toList();

    List treeMapData =
        await PermissionService().updateRolePermissions(roleId, permissionIds);

    return treeMapData;
  }

  buildUserRoleToolbar() {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            await roleGeneralInfoController.editFormController!.validate();
            String modelStr = model.value.toJsonStr();
            print(modelStr);

            model.refresh();
          },
          //TO DO: deep reclusively defined text cannot be translate dynamically, need reopen the page as a workaround.
          child:
              Obx(() => Text(EHLocaleHelper.tr('common.security.assignRole'))),
        )),
        // EHButton(
        //     controller: EHButtonController(
        //   onPressed: () async {
        //     await userGeneralInfoController.editFormController!.validate();
        //     String modelStr = model.value.toJsonStr();
        //     print(modelStr);

        //     //controller.receiptDetailInfoController.receiptModel.value = model;

        //     model.refresh();

        //     EHToastMessageHelper.showInfoMessage(modelStr);
        //   },
        //   child: Text('Revoke Roles'.tr),
        // )),
      ],
    );
  }
}
