import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/models/user_model.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../common/base/eh_panel_controller.dart';
import 'user_detail_general_view.dart';
import 'user_detail_general_controller.dart';

class UserEditController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  Rx<UserModel> model = UserModel().obs;

  late EHTabsViewController headerTabsViewController;

  late EHTabsViewController detailTabsViewController;

  late EHDataGridController userRoleDataGridController;

  EHDropDownController? ehDropDownMenuController;

  late UserDetailGeneralController userGeneralInfoController;

  RxDouble splitterWeights = 0.5.obs;

  FocusNode fnButton = FocusNode();
  UserEditController(String? userId) : super(null) {
    userGeneralInfoController = UserDetailGeneralController(this);

    headerTabsViewController = EHTabsViewController(tabs: [
      EHTab('General Info', userGeneralInfoController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: UserDetailGeneralView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    userRoleDataGridController = EHDataGridController(
        wrapWithExpanded: !Responsive.isMobile(Get.context!),
        showCheckbox: true,
        onRowSelected: (data) =>
            EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: getServiceDataGridSource());

    detailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Assigned Roles', userRoleDataGridController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: Column(
              children: [
                buildUserRoleToolbar(),
                //need add expanded, bc ehgrid has child element 'column' which is already expanded in non-mobile mode, so we need tell ehgrid expanded in parent column as well. otherwise, exception will be thrown.
                EHDataGrid(
                  controller: c,
                )
              ],
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);
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

            //controller.receiptDetailInfoController.receiptModel.value = model;

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
          child: Text('Delete Role'.tr),
        )),
      ],
    );
  }

  getServiceDataGridSource() {
    return EHServiceDataGridSource(serviceName: '/security/role',
        // loadDataAtInit: false,
        columnFilters: [], columnsConfig: [
      EHColumnConf('roleName', EHStringColumnType(),
          columnHeaderName: 'Role Name'),
      EHColumnConf('description', EHStringColumnType(),
          columnHeaderName: 'Description'),
    ]);
  }
}
