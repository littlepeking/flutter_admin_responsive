import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tmsPanel/tms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/TestComponent/test2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TmsPanelController controller = Get.find<TmsPanelController>();

List<EHTreeNode> tmsMenu = [
  EHTreeNode(
    menuName: "Transport Management",
    children: [
      EHTreeNode(
          menuName: "Shipment Orders",
          icon: Icons.access_alarm,
          onTap: () {
            controller.tabViewController
                .addTab("Shipment Orders", Test2(param: '1'), closeable: true);
          })
    ],
  ),
  EHTreeNode(
    menuName: "Routes",
    children: [],
  ),
];
