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

import 'package:eh_flutter_framework/main/common/base/eh_exception.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
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
                throw EHException('common.security.passwordNotMatch');

              bool isCreateNewUser = controller.model.value.id == null;
              await UserService()
                  .createOrUpdateRxModel(model: controller.model);

              if (isCreateNewUser) {
                controller.userRoleDataGridController.dataGridSource
                    .setParam('userId', controller.model.value.id);
              }

              controller.model.value.password = "";
              controller.model.value.rePassword = "";

              EHToastMessageHelper.showInfoMessage('common.security.userSaved'
                  .trParams({'username': controller.model.value.username!}));
            }
          },
          child: Text('common.general.save'.tr),
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
            items: {'print': 'common.general.print'},
            onChanged: (value) {},
          )),
        )
      ],
    );
  }
}
