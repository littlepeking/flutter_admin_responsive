import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/task_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TaskPanelController controller = Get.find<TaskPanelController>();

List<EHTreeNode> taskMenu = [
  EHTreeNode(menuName: "Tasks", icon: Icons.access_alarm, onTap: () {}),
  EHTreeNode(menuName: "Notifications", icon: Icons.access_alarm, onTap: () {}),
];
