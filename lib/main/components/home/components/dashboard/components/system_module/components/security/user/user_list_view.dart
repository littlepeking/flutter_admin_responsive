import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
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
                    EHTab<UserEditController>(
                        'Edit User', await UserEditController.create(),
                        (EHController controller) {
                  return UserEditView(controller: controller);
                }, closable: true, expandMode: EHTabsViewExpandMode.Expand));
          },
          child: Text('Add'.tr),
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
            EHToastMessageHelper.showInfoMessage('Selected users deleted');
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
