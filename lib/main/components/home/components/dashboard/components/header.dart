import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/constants/navigation_keys.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_context_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_navigator.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_image_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/task_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tmsPanel/tms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  buttons.addAll(getSystemBtnBar());
  buttons.addAll(getFunctionBtnBar());

  return buttons;
}

getSystemBtnBar() {
  return [
    //SizedBox(width: 10),
    EHImageButton(
      text: 'WMS',
      icon: Icon(Icons.warehouse),
      onPressed: (data) {
        // if (System.wms != GlobalDataController.instance.system.value) {
        GlobalDataController.instance.system.value = SystemModule.wms;
        EHNavigator.navigateTo(
          "/wmsModule",
          navigatorKey: NavigationKeys.dashBoardNavKey,
        );
        // }
      },
    ),
    SizedBox(width: 15),
    EHImageButton(
      text: 'TMS',
      icon: Icon(Icons.local_shipping),
      onPressed: (data) {
        if (SystemModule.tms != GlobalDataController.instance.system.value) {
          GlobalDataController.instance.system.value = SystemModule.tms;
          EHNavigator.navigateTo(
            "/tmsModule",
            navigatorKey: NavigationKeys.dashBoardNavKey,
          );
        }
      },
    ),
    SizedBox(width: 15),
    EHImageButton(
      text: 'System',
      icon: Icon(Icons.monitor),
      onPressed: (data) {
        if (SystemModule.system != GlobalDataController.instance.system.value) {
          GlobalDataController.instance.system.value = SystemModule.system;
          EHNavigator.navigateTo(
            "/systemModule",
            navigatorKey: NavigationKeys.dashBoardNavKey,
          );
        }
      },
    ),
  ];
}

getFunctionBtnBar() {
  return [
    EHImageButton(
      text: 'Notification',
      icon: Icon(
        Icons.notifications,
        // color: Color.fromARGB(255, 67, 67, 67),
      ),
      onPressed: (data) {
        if (SystemModule.notification !=
            GlobalDataController.instance.system.value) {
          GlobalDataController.instance.system.value =
              SystemModule.notification;
          EHNavigator.navigateTo(
            "/myTasks",
            navigatorKey: NavigationKeys.dashBoardNavKey,
          );
        }
      },
    ),
    EHImageButton(
        text: 'changeTheme',
        icon: Icon(
          Icons.ac_unit_sharp,
          //   color: Color.fromARGB(255, 67, 67, 67),
        ),
        onPressed: (data) {
          Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
          ThemeController.instance.isDarkMode.value = !Get.isDarkMode;
          // WmsPanelNavigationController.instance.isDarkMode.value =
          //     !Get.isDarkMode;
          //  print(ThemeController.instance.isDarkMode);
        }),
    EHImageButton(
        text: 'changeLocale',
        icon: Icon(
          Icons.language,
          //   color: Color.fromARGB(255, 67, 67, 67),
        ),
        onPressed: (data) {
          var enLocale = Locale('en', 'US');
          var cnLocale = Locale('zh', 'CN');
          if (Get.locale == enLocale) {
            Get.updateLocale(cnLocale);
          } else {
            Get.updateLocale(enLocale);
          }
        }),
    EHImageButton(
        text: 'Logout'.tr,
        icon: Icon(
          Icons.exit_to_app,
          //  color: Color.fromARGB(255, 67, 67, 67),
        ),
        onPressed: (data) {
          EHNavigator.logout();
        }),
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
