import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/header.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideMenuController controller = Get.put(SideMenuController());

    var menuItems = [
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
      if (Responsive.isMobile(context))
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getFunctionButtons())
    ];

    return Drawer(
        child: ListView(children: [
      Container(
        height: 180,
        child: DrawerHeader(
          child: Center(
              child: Column(
            children: menuItems,
          )),
          // child: Image.asset("assets/images/Home.png"),
        ),
      ),
      Obx(() => TreeView(
          iconSize: 20,
          indent: 10,
          treeController: controller.treeController,
          nodes: SideMenuController.getMenu(
              GlobalDataController.instance.system.value))),
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
