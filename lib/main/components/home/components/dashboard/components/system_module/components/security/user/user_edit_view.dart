import 'package:eh_flutter_framework/main/common/base/eh_exception.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/services/security/user_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_edit_controller.dart';
import 'package:split_view/split_view.dart';

class UserEdit extends EHPanel<UserEditController> {
  UserEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Column(children: [
            buildToolbar(context),
            // KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            //   return !isKeyboardVisible && !Responsive.isExtraSmall(context)
            //       ?
            EHTabsView(
                useBottomList: false,
                expandMode: EHTabsViewExpandMode.None,
                controller: controller.headerTabsViewController),
            if (controller.model.value.id != null)
              EHTabsView(
                  useBottomList: false,
                  expandMode: EHTabsViewExpandMode.None,
                  controller: controller.detailTabsViewController),
          ])
        : Column(
            children: [
              buildToolbar(context),
              Expanded(
                  child: Obx(() => EHMasterDetailSplitter(
                      controller: EHMasterDetailSplitterController(
                          splitterWeights: 0.4,
                          masterPanel: EHTabsView(
                              controller: controller.headerTabsViewController),
                          detailPanel: EHTabsView(
                              expandMode: EHTabsViewExpandMode.Flexible,
                              controller: controller.detailTabsViewController),
                          showDetail: controller.model.value.id != null)))),
            ],
          );
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            if (await controller.userGeneralInfoController.editFormController!
                .validate()) {
              String modelStr = controller.model.value.toJsonStr();
              print(modelStr);
              if (controller.model.value.password !=
                  controller.model.value.rePassword)
                throw EHException("Password does not match.");

              bool isCreateNewUser = controller.model.value.id == null;
              await UserService()
                  .createOrUpdateRxModel(model: controller.model);

              if (isCreateNewUser) {
                (controller.userRoleDataGridController.dataGridSource
                        as EHServiceDataGridSource)
                    .setParam('userId', controller.model.value.id);
              }

              controller.model.value.password = null;
              controller.model.value.rePassword = null;

              //controller.receiptDetailInfoController.receiptModel.value = model;

              //controller.receiptDetailInfoController.receiptModel.value = model;
              //controller.model.refresh();

              EHToastMessageHelper.showInfoMessage(modelStr);
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
