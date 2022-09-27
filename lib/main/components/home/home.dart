import 'package:eh_flutter_framework/main/common/Utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/dashboard/dashboard.dart';
import 'components/side_menu/side_menu.dart';
import 'components/side_menu/side_menu_controller.dart';

class Home extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: SideMenuController.instance.scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // We want this side menu only for large screen
                    if (Responsive.isDesktop(context))
                      SizedBox(
                        width: 250,
                        child: SideMenu(),
                      ),
                    Expanded(
                      child: Dashboard(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: Responsive.isDesktop(context) ? 20 : 13,
                  child: EHText(
                    size: Responsive.isDesktop(context) ? 13 : 10,
                    textMsgKey: " Copyright © 2022 Enhantec",
                  ))
            ]),
          ),
        ));
  }
}
