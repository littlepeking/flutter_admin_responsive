import 'package:eh_flutter_framework/main/common/base/eh_exception.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_edit_controller.dart';
import 'user_service.dart';

class UserEditView extends EHPanel<UserEditController> {
  UserEditView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return
        // If want to make the page use full screen scroll in mobile mode, please enable following code and also make userRoleDataGridController.disableFixedHeight = false and make root tab expandMode = scroll.

        // Responsive.isMobile(context)
        //     ? Obx(() => Column(children: [
        //           buildToolbar(context),
        //           // KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        //           //   return !isKeyboardVisible && !Responsive.isExtraSmall(context)
        //           //       ?
        //           EHTabsView(
        //               useBottomList: false,
        //               expandMode: EHTabsViewExpandMode.None,
        //               controller: controller.headerTabsViewController),
        //           if (controller.model.value.id != null)
        //             EHTabsView(
        //                 useBottomList: false,
        //                 expandMode: EHTabsViewExpandMode.None,
        //                 controller: controller.detailTabsViewController),
        //         ]))
        //     :
        Column(
      children: [
        buildToolbar(context),
        Expanded(
            child: Obx(() => EHMasterDetailSplitView(
                controller: EHMasterDetailSplitterController(
                    splitterWeights: 0.4,
                    masterPanel: EHTabsView(
                        controller: controller.headerTabsViewController),
                    detailPanel: EHTabsView(
                        expandMode: EHTabsViewExpandMode.Expand,
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
              if (EHUtilHelper.nvl(controller.model.value.password, '') !=
                  EHUtilHelper.nvl(controller.model.value.rePassword, ''))
                throw EHException("Password does not match.");

              bool isCreateNewUser = controller.model.value.id == null;
              await UserService()
                  .createOrUpdateRxModel(model: controller.model);

              if (isCreateNewUser) {
                controller.userRoleDataGridController.dataGridSource
                    .setParam('userId', controller.model.value.id);
              }

              controller.model.value.password = "";
              controller.model.value.rePassword = "";

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
