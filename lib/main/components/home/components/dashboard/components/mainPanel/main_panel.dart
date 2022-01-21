import 'package:eh_flutter_framework/common/Utils/responsive.dart';
import 'package:eh_flutter_framework/common/constants.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/mainPanel/controllers/test_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/Notifications/Notifications.dart';

class MainPanelWidget extends GetView {
  const MainPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              if (Responsive.isMobile(context))
                SizedBox(height: defaultPadding),
              if (Responsive.isMobile(context)) Notifications(),
              //Biz widget goes here
              Expanded(
                  child: Navigator(
                key: TestNavigationController.instance.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: '/myTest',
              )),
            ],
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we dont want to show it
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: Notifications(),
          ),
      ],
    ));
  }
}
