import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/services/common/service_name.dart';
import 'package:eh_flutter_framework/main/common/services/security/user_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_context_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_dialog.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/components/org_role_component.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/components/org_role_component_controller.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

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
        showCheckbox: false,
        // onRowSelected: (data) =>
        //     EHToastMessageHelper.showInfoMessage(data.toString()),
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

            EHDialog.showPopupDialog(
                OrgRoleComponent(
                    controller: await OrgRoleComponentController
                        .create(this, extraColumns: [
                  EHColumnConf(
                      'assignRole',
                      EHImageButtonColumnType(
                          icon: null,
                          label: 'Assign',
                          onPressed: (dataRow) async {
                            Response userModelResponse = await EHRestService()
                                .postByServiceName(
                                    serviceName: WMSServiceNames.RoleService,
                                    actionName: 'assignToUser',
                                    body: {
                                  'userId':
                                      (await EHContextHelper.getUserInfo()).id!,
                                  'roleIds': [dataRow['id']]
                                });
                            UserModel userModelValue =
                                model.value.fromJson(userModelResponse.data!);
                            model.value = userModelValue;

                            userRoleDataGridController.dataGridSource
                                .handleRefresh();

                            EHToastMessageHelper.showInfoMessage(
                                'Role @displayName assigned to user @username successfully'
                                    .trParams({
                              'displayName': dataRow['displayName'],
                              'username': model.value.username!
                            }));
                          }),
                      columnHeaderName: 'Assign Role')
                ])),
                title: 'User role authorization'.tr);
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

  getRolesDataGridSource() {
    EHServiceDataGridSource dataGridSource = EHServiceDataGridSource(
        serviceName: WMSServiceNames.RoleService,
        actionName: 'queryUserRoleByPage',
        // loadDataAtInit: false,
        columnFilters: [],
        columnsConfig: [
          EHColumnConf('name', EHStringColumnType(),
              fullQuanifiedName: 'org.name', columnHeaderName: 'Organization'),
          EHColumnConf('roleName', EHStringColumnType(),
              fullQuanifiedName: 'r.roleName', columnHeaderName: 'Role Name'),
          EHColumnConf('displayName', EHStringColumnType(),
              fullQuanifiedName: 'r.displayName',
              columnHeaderName: 'Description'),
          EHColumnConf(
              '__delete',
              EHImageButtonColumnType(
                  icon: Icons.delete,
                  onPressed: (Map rowData) async {
                    await EHRestService().postByServiceName(
                        serviceName: WMSServiceNames.RoleService,
                        actionName: 'revokeFromUser',
                        body: {
                          'userId': (await EHContextHelper.getUserInfo()).id!,
                          'roleIds': [rowData['id']]
                        });

                    userRoleDataGridController.dataGridSource.handleRefresh();

                    EHToastMessageHelper.showInfoMessage(
                        'Role @displayName revoked from user @username successfully'
                            .trParams({
                      'displayName': rowData['displayName'],
                      'username': model.value.username!
                    }));
                  }),
              columnHeaderName: 'Delete'),
        ],
        params: {
          'userId': model.value.id
        });

    return dataGridSource;
  }
}
