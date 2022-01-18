import 'package:admin/controllers/main_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            // MainPanelWidget(),
            Expanded(
              // child: ListView(
              //   padding: const EdgeInsets.all(8),
              //   children: <Widget>[
              //     Text('List 1'),
              //     Text('List 2'),
              //     Text('List 3'),
              //   ],
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
