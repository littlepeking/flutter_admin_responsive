import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/TestComponent/test.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/controllers/dashboard_navigation_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/controllers/wms_panel_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tabbed_view/tabbed_view.dart';

import 'dashboard/components/wmsPanel/components/TestComponent/TestController.dart';
import 'dashboard/components/wmsPanel/components/TestComponent/test2.dart';

class SideMenu extends GetView<WmsPanelNavigationController> {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 135,
            child: DrawerHeader(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/enhantec.png",
                    height: 70,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
              // child: Image.asset("assets/images/Home.png"),
            ),
          ),
          DrawerListTile(
            title: 'Inbound'.tr,
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              DashBoardNavigationController.instance.navigateTo("/wmsPanel");
            },
          ),
          DrawerListTile(
            title: "Outbound".tr,
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              controller.addTab(
                  TabData(text: "OutBound", content: Test2(), keepAlive: true),
                  () {
                Get.create<TestController>(() => TestController());
              });
            },
          ),
          DrawerListTile(
            title: "Inventory".tr,
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              WmsPanelNavigationController.instance.navigateTo('/myTest');
            },
          ),
          DrawerListTile(
            title: "Configuration".tr,
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              DashBoardNavigationController.instance.navigateTo("/myTasks");
            },
          ),
          DrawerListTile(
            title: "SystemManagement".tr,
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
