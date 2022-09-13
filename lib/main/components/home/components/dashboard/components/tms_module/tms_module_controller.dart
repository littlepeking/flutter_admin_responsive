import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/TestController.dart';
import 'package:eh_flutter_framework/main/components/home/components/examples/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmsModuleController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  EHTreeController get sideMenuTreeController => EHTreeController(
      allNodesExpanded: true,
      treeNodeDataList: [
        EHTreeNode(
          displayName: "Transport Management",
          children: [
            EHTreeNode(
                icon: Icons.assignment,
                displayName: "Shipment Orders",
                onTap: () {
                  tabViewController.addTab((EHTab<TestController>(
                      'Shipment Orders', TestController(),
                      (EHController controller) {
                    return Test2(controller: controller);
                  }, closable: true)));
                }),
            EHTreeNode(
              icon: Icons.alt_route,
              displayName: "Routes",
              children: [],
            ),
          ],
        ),
      ].obs);

  reset() {
    tabViewController.reset();
  }
}
