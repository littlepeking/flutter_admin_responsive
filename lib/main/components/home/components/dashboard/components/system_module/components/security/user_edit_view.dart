import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/services/security/user_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../../../../common/widgets/eh_button.dart';
import '../../../../../../../../common/widgets/eh_toolbar.dart';
import 'user_edit_controller.dart';
import 'package:split_view/split_view.dart';

class UserEdit extends EHPanel<UserEditController> {
  UserEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(children: [
        buildToolbar(context),
        // KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        //   return !isKeyboardVisible && !Responsive.isExtraSmall(context)
        //       ?
        EHTabsView(
            useBottomList: false,
            expandMode: EHTabsViewExpandMode.Growable,
            controller: controller.headerTabsViewController),
        EHTabsView(
            useBottomList: false,
            expandMode: EHTabsViewExpandMode.Growable,
            controller: controller.detailTabsViewController),
      ]);
    } else {
      return Column(
        children: [
          buildToolbar(context),
          Expanded(
            child: SplitView(
              children: [
                EHTabsView(controller: controller.headerTabsViewController),
                EHTabsView(
                    expandMode: EHTabsViewExpandMode.Flexible,
                    controller: controller.detailTabsViewController),
              ],
              gripSize: 2,
              viewMode: SplitViewMode.Vertical,
              indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
              activeIndicator: SplitIndicator(
                viewMode: SplitViewMode.Vertical,
                isActive: true,
              ),
              controller: SplitViewController(
                  limits: [WeightLimit(max: 0.8), WeightLimit(max: 0.8)],
                  weights: [controller.splitterWeights.value]),
              onWeightChanged: (w) =>
                  controller.splitterWeights.value = w.first ?? 0.5,
            ),
          ),
        ],
      );
    }
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            await controller.userGeneralInfoController.editFormController!
                .validate();
            String modelStr = controller.model.value.toJsonStr();
            print(modelStr);

            await UserService()
                .createOrUpdateModel(model: controller.model.value);

            //controller.receiptDetailInfoController.receiptModel.value = model;

            controller.model.refresh();

            EHToastMessageHelper.showInfoMessage(modelStr);
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
