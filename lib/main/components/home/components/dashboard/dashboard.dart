import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/utils/NavigationKeys.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/controllers/dashboard_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'package:get/get.dart';

class Dashboard extends GetView<DashBoardNavigationController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashBoardNavigationController());
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Expanded(
              child: Navigator(
                key: Get.nestedKey(NavigationKeys.dashBoardNavKey),
                onGenerateRoute: generateRoute,
                initialRoute: "/wmsPanel",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
