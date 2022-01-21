import 'package:eh_flutter_framework/common/constants.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/controllers/main_panel_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'package:get/get.dart';

class Dashboard extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
            left: defaultPadding, right: defaultPadding, top: defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Expanded(
              child: Navigator(
                key: MainPanelNavigationController.instance.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: "/mainPanel",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
