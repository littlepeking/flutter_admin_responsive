import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/dashboard_navigation_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/controllers/wms_panel_navigation_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../dashboard/components/wmsPanel/components/TestComponent/test2.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideMenuController controller = Get.put(SideMenuController());

    return Drawer(
        child: ListView(children: [
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
      TreeView(
          iconSize: 20,
          indent: 10,
          treeController: controller.treeController,
          nodes: [
            TreeNode(
              content: Text(
                'Warehouse Management'.tr,
                textAlign: TextAlign.center,
              ),
              children: [
                TreeNode(
                  content: Text("Inbound".tr),
                  children: [
                    TreeNode(
                      content: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Text("Asn".tr),
                          onTap: () {
                            EHTabsViewController controller =
                                Get.find<EHTabsViewController>(
                                    tag: wmsMainPanelTabsViewTag);

                            controller.addTab("Orders", Test2(tabName: '1'),
                                closeable: true);
                          },
                        ),
                      ),
                    ),
                    TreeNode(content: Text("Asn Details".tr)),
                  ],
                ),
                TreeNode(
                  content: Text("Outbound".tr),
                  children: [
                    TreeNode(content: Text("Orders".tr)),
                    TreeNode(content: Text("Order Details".tr)),
                    TreeNode(content: Text("Pick Details".tr)),
                  ],
                ),
              ],
            ),
            TreeNode(
              content: Text("Transport Management".tr),
              children: [
                TreeNode(
                  content: Text("Shipment Orders".tr),
                ),
              ],
            )
          ]
          // DrawerListTile(
          //   title: 'Inbound'.tr,
          //   svgSrc: "assets/icons/menu_dashbord.svg",
          //   press: () {
          //     DashBoardNavigationController.instance.navigateTo("/wmsPanel");
          //   },
          // ),
          // DrawerListTile(
          //   title: "Outbound".tr,
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Inventory".tr,
          //   svgSrc: "assets/icons/menu_task.svg",
          //   press: () {
          //     EHTabsViewController controller =
          //         Get.find<EHTabsViewController>(tag: wmsMainPanelTabsViewTag);

          //     controller.addTab("Orders", Test2(tabName: '1'), closeable: true);
          //   },
          // ),
          // DrawerListTile(
          //   title: "Configuration".tr,
          //   svgSrc: "assets/icons/menu_doc.svg",
          //   press: () {
          //     DashBoardNavigationController.instance.navigateTo("/myTasks");
          //   },
          // ),
          // DrawerListTile(
          //   title: "SystemManagement".tr,
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {},
          // ),

          ),
    ]));
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
