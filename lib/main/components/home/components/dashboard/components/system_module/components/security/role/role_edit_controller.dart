import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
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

  late EHTabsViewController detailTabsViewController;

  late RoleDetailGeneralController roleGeneralInfoController;

  FocusNode fnButton = FocusNode();

  RoleEditController._create(Map<String, dynamic> params)
      : super(null, params: params);

  static Future<RoleEditController> create(
      {Map<String, dynamic> params = const {}}) async {
    RoleEditController self = RoleEditController._create(params);

    self.model = self.params.isEmpty
        ? RoleModel().obs
        : (RoleModel.fromJson(
                await RoleService().findById(id: self.params['id'].toString())))
            .obs;

    self.roleGeneralInfoController = RoleDetailGeneralController(self, params);

    self.headerTabsViewController = EHTabsViewController(tabs: [
      EHTab('General Info', self.roleGeneralInfoController, (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: RoleDetailGeneralView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    self.detailTabsViewController = EHTabsViewController(tabs: [
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    return self;
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
          child: Obx(() => Text(GlobalDataController.tr('Assign Role'))),
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
