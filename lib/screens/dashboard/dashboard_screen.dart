import 'package:admin/common/controllers/main_navigation_controller.dart';
import 'package:admin/common/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import 'components/header.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView {
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
                key: MainNavigationController.instance.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: mainNavigationMainPanelPageRoute,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
