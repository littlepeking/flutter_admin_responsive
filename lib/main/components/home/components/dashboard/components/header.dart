import 'package:eh_flutter_framework/main/common/constants/map_constant.dart';
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
  buttons.addAll(getSystemBtnBar());
  buttons.addAll(getFunctionBtnBar());

  return buttons;
}

getSystemBtnBar() {
  return [
    Obx(() => EHImageButton(
          text: 'WMS',
          icon: Icon(Icons.warehouse),
          isSelected: GlobalDataController.instance.currentModule.value ==
              SystemModule.wms,
          onPressed: (data) {
            if (SystemModule.wms !=
                GlobalDataController.instance.currentModule.value) {
              GlobalDataController.instance.currentModule.value =
                  SystemModule.wms;
              EHNavigator.navigateTo(
                MapConstant.systemModuleRoute[SystemModule.wms]!,
                navigatorKey: NavigationKeys.dashBoardNavKey,
              );
            }
          },
        )),
    SizedBox(width: 15),
    Obx(() => EHImageButton(
          text: 'TMS',
          icon: Icon(Icons.local_shipping),
          isSelected: GlobalDataController.instance.currentModule.value ==
              SystemModule.tms,
          onPressed: (data) {
            if (SystemModule.tms !=
                GlobalDataController.instance.currentModule.value) {
              GlobalDataController.instance.currentModule.value =
                  SystemModule.tms;
              EHNavigator.navigateTo(
                MapConstant.systemModuleRoute[SystemModule.tms]!,
                navigatorKey: NavigationKeys.dashBoardNavKey,
              );
            }
          },
        )),
    SizedBox(width: 15),
    Obx(() => EHImageButton(
          text: 'System',
          icon: Icon(Icons.monitor),
          isSelected: GlobalDataController.instance.currentModule.value ==
              SystemModule.system,
          onPressed: (data) {
            if (SystemModule.system !=
                GlobalDataController.instance.currentModule.value) {
              GlobalDataController.instance.currentModule.value =
                  SystemModule.system;
              EHNavigator.navigateTo(
                MapConstant.systemModuleRoute[SystemModule.system]!,
                navigatorKey: NavigationKeys.dashBoardNavKey,
              );
            }
          },
        )),
    SizedBox(width: 15),
  ];
}

getFunctionBtnBar() {
  return [
    Obx(() => EHImageButton(
          text: 'Workbench',
          icon: Icon(
            Icons.dvr,
            // color: Color.fromARGB(255, 67, 67, 67),
          ),
          isSelected: GlobalDataController.instance.currentModule.value ==
              SystemModule.workbench,
          onPressed: (data) {
            if (SystemModule.workbench !=
                GlobalDataController.instance.currentModule.value) {
              GlobalDataController.instance.currentModule.value =
                  SystemModule.workbench;
              EHNavigator.navigateTo(
                MapConstant.systemModuleRoute[SystemModule.workbench]!,
                navigatorKey: NavigationKeys.dashBoardNavKey,
              );
            }
          },
        )),
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
          // WmsModuleNavigationController.instance.isDarkMode.value =
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
