import 'package:admin/controllers/main_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child:
                  // )),
                  SizedBox(
                      child: Flexible(
                          child: Navigator(
                key: MainNavigationController.instance.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: mainNavigationMainPanelPageRoute,
              ))),
            )),
      ));
    });
  }
}
