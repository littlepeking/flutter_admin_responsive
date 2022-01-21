import 'package:eh_flutter_framework/main/controllers/menu_controller.dart';
import '/common/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/dashboard/dashboard.dart';
import 'components/side_menu.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: MenuController.instance.scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: Column(children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Expanded(
                      // default flex = 1
                      // and it takes 1/6 part of the screen
                      child: SideMenu(),
                    ),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: Dashboard(),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 20,
                child: Text(
                  " Copyright © 2022 Enhantec",
                  style: TextStyle(
                    color: Get.theme.backgroundColor,
                  ),
                ))
          ]),
        ));
  }
}
