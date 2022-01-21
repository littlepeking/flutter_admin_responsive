import 'package:admin/common/controllers/main_navigation_controller.dart';
import 'package:admin/common/controllers/test_navigation_controller.dart';
import 'package:admin/common/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
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
            title: "DashBoard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              MainNavigationController.instance
                  .navigateTo(mainNavigationMainPanelPageRoute);
            },
          ),
          DrawerListTile(
            title: "Inbound",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              MainNavigationController.instance
                  .navigateTo(mainNavigationMyTasksPageRoute);
            },
          ),
          DrawerListTile(
            title: "Outbound",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              TestNavigationController.instance
                  .navigateTo(mainNavigationMyTestPageRoute);
            },
          ),
          DrawerListTile(
            title: "Inventory",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              TestNavigationController.instance
                  .navigateTo(mainNavigationMyTestPageRoute2);
            },
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Alert",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
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
