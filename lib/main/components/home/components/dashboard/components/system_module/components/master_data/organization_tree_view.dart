import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/master_data/organization_tree_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_edit_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user_edit_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';

class OrganizationTreeView extends EHPanel<OrganizationTreeController> {
  OrganizationTreeView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     buildToolbar(context),
    //     Expanded(
    //       child: SplitView(
    //         children: [],
    //         gripSize: 2,
    //         viewMode: SplitViewMode.Vertical,
    //         indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
    //         activeIndicator: SplitIndicator(
    //           viewMode: SplitViewMode.Vertical,
    //           isActive: true,
    //         ),
    //         controller: SplitViewController(
    //             limits: [WeightLimit(max: 0.8), WeightLimit(max: 0.8)],
    //             weights: [controller.splitterWeights.value]),
    //         onWeightChanged: (w) =>
    //             controller.splitterWeights.value = w.first ?? 0.5,
    //       ),
    //     ),
    //   ],
    // );

    return Column(children: [
      buildToolbar(context),
      PageStorage(
        bucket: controller.pageStorageBucket,
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              const BoxShadow(
                color: Colors.grey,
              ),
              const BoxShadow(
                color: Colors.white,
                spreadRadius: -1.0,
                blurRadius: .0,
              ),
            ]),
            child: SplitView(
              children: [
                EHTreeView(
                  controller: controller.orgTreeController,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 5),
                  child: EHTabsView(
                      expandMode: EHTabsViewExpandMode.Scrollable,
                      controller: controller.receiptDetailTabsViewController),
                ),
              ],
              gripSize: 4,
              viewMode: SplitViewMode.Horizontal,
              indicator: SplitIndicator(viewMode: SplitViewMode.Horizontal),
              activeIndicator: SplitIndicator(
                viewMode: SplitViewMode.Horizontal,
                isActive: true,
              ),
              controller: SplitViewController(
                  limits: [WeightLimit(max: 0.9), WeightLimit(max: 0.9)],
                  weights: [controller.splitterWeights.value]),
              onWeightChanged: (w) => null,
            ),
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
                        'Edit User', UserEditController(null),
                        (EHController controller) {
                  return UserEdit(controller: controller);
                }, closable: true));
          },
          child: Text('Add'.tr),
        )),
        EHButton(
            controller: EHButtonController(
          child: Text('Delete'.tr),
          onPressed: () async {},
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
