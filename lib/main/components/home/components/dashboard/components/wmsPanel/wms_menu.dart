import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/TestComponent/test2.dart';

WmsPanelController controller = Get.find<WmsPanelController>();

List<EHTreeNode> wmsMenu = [
  EHTreeNode(
    menuName: "Inbound",
    children: [
      EHTreeNode(
          menuName: "Asn",
          icon: Icons.access_alarm,
          onTap: () {
            controller.tabViewController
                .addTab("Asn", Test2(param: '1'), closeable: true);
          }),
      EHTreeNode(
          menuName: "Asn Details",
          icon: Icons.access_alarm,
          onTap: () {
            controller.tabViewController
                .addTab("Asn Details", Test2(param: '1'), closeable: true);
          }),
    ],
  ),
  EHTreeNode(
    menuName: "Outbound",
    children: [
      EHTreeNode(menuName: "Orders"),
      EHTreeNode(menuName: "Order Details"),
      EHTreeNode(menuName: "Pick Details"),
    ],
  ),
];
