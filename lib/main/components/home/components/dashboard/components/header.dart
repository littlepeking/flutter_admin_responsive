import 'package:eh_flutter_framework/main/common/constants/navigation_keys.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_navigator.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_image_button.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/utils/theme_controller.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: getHeaderButtons(context),
    );
  }
}

List<Widget> getHeaderButtons(BuildContext context) {
  List<Widget> buttons = [
    if (!Responsive.isDesktop(context))
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: SideMenuController.instance.toggleDrawer,
      ),
    if (!Responsive.isMobile(context) && !Responsive.isTablet(context))
      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
    // Expanded(flex: 2, child: SearchField()),

    // EHImageButton(text: 'quit'.tr, icon: Icon(Icons.logout), onPressed: () {})
  ];
  buttons.addAll(getFunctionButtons());

  return buttons;
}

getFunctionButtons() {
  return [
    EHImageButton(
      text: 'WMS',
      icon: Icon(Icons.cabin),
      onPressed: (data) {
        // if (System.wms != GlobalDataController.instance.system.value) {
        GlobalDataController.instance.system.value = System.wms;
        EHNavigator.navigateTo(NavigationKeys.dashBoardNavKey, "/wmsPanel");
        // }
      },
    ),
    EHImageButton(
      text: 'TMS',
      icon: Icon(Icons.local_shipping),
      onPressed: (data) {
        if (System.tms != GlobalDataController.instance.system.value) {
          GlobalDataController.instance.system.value = System.tms;
          EHNavigator.navigateTo(NavigationKeys.dashBoardNavKey, "/tmsPanel");
        }
      },
    ),
    EHImageButton(
      text: 'Notification',
      icon: Icon(Icons.notifications),
      onPressed: (data) {
        if (System.notification != GlobalDataController.instance.system.value) {
          GlobalDataController.instance.system.value = System.notification;
          EHNavigator.navigateTo(NavigationKeys.dashBoardNavKey, "/myTasks");
        }
      },
    ),
    SizedBox(width: 0),
    EHImageButton(
        text: 'changeTheme',
        icon: Icon(Icons.ac_unit_sharp),
        onPressed: (data) {
          Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          ThemeController.instance.isDarkMode.value = !Get.isDarkMode;
          // WmsPanelNavigationController.instance.isDarkMode.value =
          //     !Get.isDarkMode;
          //  print(ThemeController.instance.isDarkMode);
        }),
    SizedBox(width: 0),
    EHImageButton(
        text: 'changeLocale',
        icon: Icon(Icons.language),
        onPressed: (data) {
          var enLocale = Locale('en', 'US');
          var cnLocale = Locale('zh', 'CN');
          if (Get.locale == enLocale) {
            Get.updateLocale(cnLocale);
          } else {
            Get.updateLocale(enLocale);
          }
        }),
    SizedBox(width: 0)
  ];
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Theme.of(context).canvasColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
