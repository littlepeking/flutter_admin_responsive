import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/services/security/user_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_detail_general_view.dart';
import 'user_detail_general_controller.dart';
import 'user_model.dart';

class UserEditController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late Rx<UserModel> model;

  late EHTabsViewController headerTabsViewController;

  late EHTabsViewController detailTabsViewController;

  late EHDataGridController userRoleDataGridController;

  EHDropDownController? ehDropDownMenuController;

  late UserDetailGeneralController userGeneralInfoController;

  FocusNode fnButton = FocusNode();

  UserEditController._create(Map<String, dynamic> params)
      : super(null, params: params);

  static Future<UserEditController> create(
      {Map<String, dynamic> params = const {}}) async {
    UserEditController self = UserEditController._create(params);

    self.model = self.params.isEmpty
        ? UserModel().obs
        : (UserModel.fromJson(
                await UserService().findById(id: self.params['id'].toString())))
            .obs;

    self.userGeneralInfoController = UserDetailGeneralController(self, params);

    self.headerTabsViewController = EHTabsViewController(tabs: [
      EHTab('General Info', self.userGeneralInfoController, (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: UserDetailGeneralView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    self.userRoleDataGridController = EHDataGridController(
        wrapWithExpanded: !Responsive.isMobile(Get.context!),
        showCheckbox: true,
        onRowSelected: (data) =>
            EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: self.getRolesDataGridSource());

    self.detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Assigned Roles', self.userRoleDataGridController,
          (EHController c) {
        return PageStorage(
            bucket: self.pageStorageBucket,
            child: Column(
              children: [
                self.buildUserRoleToolbar(),
                //EHDataGridController need wrapWithExpanded, bc ehgrid has child element 'column' which is already expanded in non-mobile mode, so we need tell ehgrid expanded in parent column as well. otherwise, exception will be thrown.
                EHDataGrid(
                  controller: c,
                )
              ],
            ));
      }),
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
            await userGeneralInfoController.editFormController!.validate();
            String modelStr = model.value.toJsonStr();
            print(modelStr);

            model.refresh();

            EHToastMessageHelper.showInfoMessage(modelStr);
          },
          child: Text('Add Role'.tr),
        )),
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            await userGeneralInfoController.editFormController!.validate();
            String modelStr = model.value.toJsonStr();
            print(modelStr);

            //controller.receiptDetailInfoController.receiptModel.value = model;

            model.refresh();

            EHToastMessageHelper.showInfoMessage(modelStr);
          },
          child: Text('Revoke Roles'.tr),
        )),
      ],
    );
  }

  getRolesDataGridSource() {
    EHServiceDataGridSource dataGridSource = EHServiceDataGridSource(
        serviceName: '/security/role',
        actionName: 'queryUserRoleByPage',
        // loadDataAtInit: false,
        columnFilters: [],
        columnsConfig: [
          EHColumnConf('roleName', EHStringColumnType(),
              columnHeaderName: 'Role Name'),
          EHColumnConf('description', EHStringColumnType(),
              columnHeaderName: 'Description'),
        ],
        params: {
          'userId': model.value.id
        });

    return dataGridSource;
  }
}
