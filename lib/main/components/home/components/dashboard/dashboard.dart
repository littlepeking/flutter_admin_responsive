import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/dashboard_navigation_controller.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:flutter/material.dart';
import '../../../../common/constants/map_constant.dart';
import 'components/header.dart';
import 'package:get/get.dart';

class Dashboard extends GetView<DashBoardNavigationController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashBoardNavigationController());
    return SafeArea(
      child: Container(
        padding: !Responsive.isMobile(context)
            ? EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
                top: defaultPadding)
            : EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Column(
          children: [
            if (!Responsive.isMobile(context)) Header(),
            //SizedBox(height: defaultPadding),
            Expanded(
              child: Navigator(
                key: controller.navigatorKey,
                onGenerateRoute: controller.generateRoute,
                initialRoute: MapConstant.systemModuleRoute[
                    GlobalDataController.instance.currentModule.value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
