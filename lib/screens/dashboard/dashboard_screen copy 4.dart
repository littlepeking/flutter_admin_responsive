import 'package:admin/controllers/main_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Header(),
      Flexible(
          child: Navigator(
        key: MainNavigationController.instance.navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: mainNavigationMainPanelPageRoute,
      ))
    ]);
  }
}
