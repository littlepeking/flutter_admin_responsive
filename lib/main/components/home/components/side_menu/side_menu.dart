import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/header.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menuItems = [
      // if (Responsive.isMobile(context))
      //   Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: getFunctionBtnBar())
      // else
      SizedBox(height: 20),
      SizedBox(
        height: 10,
      ),
      Text(
        'Enhantec',
        style: TextStyle(fontFamily: 'Righteous', fontSize: 30),
      ),
      // Image.asset(
      //   "assets/images/enhantec.png",
      //   height: 70,
      // ),
      SizedBox(
        height: 10,
      ),
      if (Responsive.isMobile(context))
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getSystemBtnBar()),
    ];

    getDrawerContent() => [
          Container(
            height: Responsive.isMobile(context) ? 135 : 100,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: Center(
                  child: Column(
                children: menuItems,
              )),
              // child: Image.asset("assets/images/Home.png"),
            ),
          ),
          Obx(() => SideMenuController.getSideBarTreeView()),
        ];

    return Drawer(
      child: Responsive.isMobile(Get.context!)
          ? Scaffold(
              body: Column(children: getDrawerContent()),
              persistentFooterButtons:
                  Responsive.isMobile(Get.context!) ? getFunctionBtnBar() : [],
            )
          : ListView(children: getDrawerContent()),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: getFunctionBtnBar()),
      // ),
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
