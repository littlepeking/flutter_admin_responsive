import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_master_detail_splitter.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/role/role_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'role_edit_controller.dart';

class RoleEditView extends EHPanel<RoleEditController> {
  RoleEditView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? Obx(() => Column(children: [
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
            ]))
        : Column(
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
            if (await controller.roleGeneralInfoController.editFormController!
                .validate()) {
              String modelStr = controller.model.value.toJsonStr();

              bool isCreateNewRole = controller.model.value.id == null;
              await RoleService()
                  .createOrUpdateRxModel(model: controller.model);

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
