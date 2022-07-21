import 'package:eh_flutter_framework/main/common/base/StatefulWrapper.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_toolbar.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_tree_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';

import 'organization_model.dart';

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

    SplitViewMode splitViewMode = Responsive.isMobile(Get.context!)
        ? SplitViewMode.Vertical
        : SplitViewMode.Horizontal;

    return StatefulWrapper(
      onInit: () {
        if (controller.orgTreeController.treeNodeDataList.length == 0) {
          controller.orgTreeController.treeNodeDataList.add(EHTreeNode(
              displayName: 'All Organizations', children: [], icon: Icons.lan));
          controller.loadOrgTreeData();
        }
      },
      child: Column(children: [
        buildToolbar(context),
        SizedBox(
          height: 5,
        ),
        PageStorage(
          bucket: controller.pageStorageBucket,
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))),
              child: SplitView(
                children: [
                  EHTreeView(
                    controller: controller.orgTreeController,
                  ),
                  Obx(() => controller.model.value != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 5, top: 5),
                          child: EHTabsView(
                              expandMode: EHTabsViewExpandMode.Scrollable,
                              controller: controller.detailTabsViewController),
                        )
                      : Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.tips_and_updates_outlined),
                              SizedBox(width: 10),
                              Text(
                                  'Please create or select a organization before edit'
                                      .tr),
                            ],
                          ),
                        )),
                ],
                gripSize: 3,
                viewMode: splitViewMode,
                indicator: SplitIndicator(viewMode: splitViewMode),
                activeIndicator: SplitIndicator(
                  viewMode: splitViewMode,
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
      ]),
    );
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            this.controller.model.value = OrganizationModel();
            this.controller.isOrgDetailOpened.value = true;
          },
          child: Text('Add'.tr),
        )),
        Obx(() => EHButton(
                controller: EHButtonController(
              enabled: controller.model.value != null,
              child: Text('Save'.tr),
              onPressed: () async {},
            ))),
        EHButton(
            controller: EHButtonController(
          child: Text('Delete'.tr),
          onPressed: () async {},
        )),
      ],
    );
  }
}
