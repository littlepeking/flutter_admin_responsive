/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_platform_ui/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/module_registry.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_context_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_image_button.dart';
import 'package:enhantec_platform_ui/main/common/constants/constants.dart';
import 'package:enhantec_platform_ui/main/common/utils/context_helper.dart';
import 'package:enhantec_platform_ui/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../enhantec_ui_framework/utils/eh_theme_helper.dart';

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
  if (Responsive.isDesktop(context)) buttons.addAll(getSystemBtnBar());
  buttons.addAll(getFunctionBtnBar());

  return buttons;
}

getDecoration(isSelected, isVertical) {
  return isVertical
      ? BoxDecoration(
          border: Border(
              right: isSelected
                  ? BorderSide(width: 3.0, color: EHThemeHelper.getTextColor())
                  : BorderSide(
                      width: 3.0, color: EHThemeHelper.getBackgroundColor())))
      : BoxDecoration(
          border: Border(
              bottom: isSelected
                  ? BorderSide(width: 3.0, color: EHThemeHelper.getTextColor())
                  : BorderSide(
                      width: 3.0, color: EHThemeHelper.getBackgroundColor())));
}

getSystemBtnBar() {
  return [
    Obx(() => EHImageButton(
          textMsgKey: 'common.module.workbench',
          icon: Icon(
            Icons.dvr,
            // color: Color.fromARGB(255, 67, 67, 67),
          ),
          decoration: getDecoration(
              ContextHelper.currentModule.value == SystemModule.workbench.name,
              !Responsive.isDesktop(Get.context!)),
          onPressed: (data) {
            if (SystemModule.workbench.name !=
                ContextHelper.currentModule.value) {
              ContextHelper.switchModule(SystemModule.workbench.name);
            }
          },
        )),
    Obx(() => EHContextHelper.getUserOrgModules().contains('WMS')
        ? EHImageButton(
            textMsgKey: 'WMS',
            icon: Icon(Icons.warehouse),
            decoration: getDecoration(
                ContextHelper.currentModule.value == SystemModule.wms.name,
                !Responsive.isDesktop(Get.context!)),
            onPressed: (data) {
              if (SystemModule.wms.name != ContextHelper.currentModule.value) {
                ContextHelper.switchModule(SystemModule.wms.name);
                // EHNavigator.navigateTo(
                //   MapConstant.systemModuleRoute[SystemModule.wms]!,
                //   navigatorKey: NavigationKeys.dashBoardNavKey,
                // );
              }
            },
          )
        : SizedBox.shrink()),
    Obx(() => EHContextHelper.getUserOrgModules().contains('TMS')
        ? EHImageButton(
            textMsgKey: 'TMS',
            icon: Icon(Icons.local_shipping),
            decoration: getDecoration(
                ContextHelper.currentModule.value == SystemModule.tms.name,
                !Responsive.isDesktop(Get.context!)),
            onPressed: (data) {
              if (SystemModule.tms.toString() !=
                  ContextHelper.currentModule.value) {
                ContextHelper.switchModule(SystemModule.tms.name);
                // EHNavigator.navigateTo(
                //   MapConstant.systemModuleRoute[SystemModule.tms]!,
                //   navigatorKey: NavigationKeys.dashBoardNavKey,
                // );
              }
            },
          )
        : SizedBox.shrink()),
    Obx(() => EHContextHelper.getUserOrgModules().contains('SYSTEM')
        ? EHImageButton(
            textMsgKey: 'common.module.system',
            icon: Icon(Icons.monitor),
            decoration: getDecoration(
                ContextHelper.currentModule.value ==
                    SystemNativeModule.system.name,
                !Responsive.isDesktop(Get.context!)),
            onPressed: (data) {
              if (SystemNativeModule.system.toString() !=
                  ContextHelper.currentModule.value) {
                ContextHelper.switchModule(SystemNativeModule.system.name);
                // EHNavigator.navigateTo(
                //   MapConstant.systemModuleRoute[SystemModule.system]!,
                //   navigatorKey: NavigationKeys.dashBoardNavKey,
                // );
              }
            },
          )
        : SizedBox.shrink()),
  ];
}

getFunctionBtnBar() {
  return [
    EHImageButton(
        textMsgKey: 'common.general.changeTheme',
        icon: Icon(
          Icons.ac_unit_sharp,
          //   color: Color.fromARGB(255, 67, 67, 67),
        ),
        showButtonText: !Responsive.isMobile(Get.context!),
        onPressed: (data) {
          EHThemeHelper.changeTheme();
          // WmsModuleNavigationController.instance.isDarkMode.value =
          //     !Get.isDarkMode;
          //  print(ThemeController.instance.isDarkMode);
        }),
    EHImageButton(
        textMsgKey: 'common.general.changeLocale',
        icon: Icon(
          Icons.language,
          //   color: Color.fromARGB(255, 67, 67, 67),
        ),
        showButtonText: !Responsive.isMobile(Get.context!),
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
        textMsgKey: 'common.security.logout'.tr,
        icon: Icon(
          Icons.exit_to_app,
          //  color: Color.fromARGB(255, 67, 67, 67),
        ),
        showButtonText: !Responsive.isMobile(Get.context!),
        onPressed: (data) async {
          await EHContextHelper.logout();
          ContextHelper.resetAllModuleTabs();
          ContextHelper.switchModule(SystemModule.workbench.toString());
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
            padding: EdgeInsets.all(LayoutConstant.defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(
                horizontal: LayoutConstant.defaultPadding / 2),
            decoration: BoxDecoration(
              color: LayoutConstant.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
