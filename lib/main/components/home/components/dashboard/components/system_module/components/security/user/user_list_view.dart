/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_context_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_service.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_edit_controller.dart';
import 'user_edit_view.dart';
import 'user_list_controller.dart';

class UserList extends EHPanel<UserListController> {
  UserList({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildToolbar(context),
      PageStorage(
        bucket: controller.pageStorageBucket,
        child: Expanded(
          child: EHDataGrid(
            controller: controller.userDataGridController,
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
                    EHTab<UserEditController>('edit', 'common.general.edit',
                        await UserEditController.create(),
                        (EHController controller) {
                  return UserEditView(controller: controller);
                }, closable: true, expandMode: EHTabsViewExpandMode.Expand));
          },
          child: Text('common.general.add'.tr),
        )),
        EHButton(
            controller: EHButtonController(
          enabled: true,
          child: Text('Delete'.tr),
          onPressed: () async {
            List<String> userIds = controller
                .userDataGridController.dataGridSource
                .getSelectedRows()
                .map((e) => e['id'].toString())
                .toList();
            UserService().deleteByIds(userIds);
            EHToastMessageHelper.showInfoMessage(
                'common.security.selectedUsersDeleted');
            controller.userDataGridController.dataGridSource.handleRefresh();
          },
        )),
        Container(
          // width: 90,
          child: EHDropdown(
              controller: EHDropDownController(
            key: GlobalKey(),
            focusNode: FocusNode(),
            isMenu: true,
            dropDownWidth: 150,
            labelMsgKey: 'common.general.actions',
            items: {
              'exportToExcel': 'common.general.Export2Excel',
            },
            onChanged: (value) async {
              print((EHContextHelper.getUserOrgPermissions()));
            },
          )),
        )
      ],
    );
  }
}
