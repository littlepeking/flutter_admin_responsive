import 'package:admin/common/controllers/test_navigation_controller.dart';
import 'package:admin/common/routing/routes.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/Utils/responsive.dart';
import 'package:get/get.dart';

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
              if (Responsive.isMobile(context)) StarageDetails(),
              //Biz widget goes here
              Expanded(
                  child: Navigator(
                key: TestNavigationController.instance.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: mainNavigationMyTestPageRoute,
              )),
            ],
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we dont want to show it
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: StarageDetails(),
          ),
      ],
    ));
  }
}
