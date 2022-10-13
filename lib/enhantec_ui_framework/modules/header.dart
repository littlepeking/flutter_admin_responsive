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
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/eh_module_manager.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_config_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_context_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_image_button.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/side_menu/side_menu_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/eh_theme_helper.dart';

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
  List<Widget> buttons = List.empty(growable: true);

  EHModuleManager.systemModuleMap.forEach((moduleId, moduleWidget) => {
        buttons.add(Obx(() =>
            EHContextHelper.getUserOrgModules().contains(moduleId) ||
                    moduleWidget.controller.isPermissionControl == false
                ? EHImageButton(
                    textMsgKey: moduleWidget.controller.moduleMsgKey,
                    icon: moduleWidget.controller.moduleIcon,
                    decoration: getDecoration(
                        EHContextHelper.currentModuleId.value == moduleId,
                        !Responsive.isDesktop(Get.context!)),
                    onPressed: (data) {
                      if (moduleId != EHContextHelper.currentModuleId.value) {
                        EHContextHelper.switchModule(moduleId);
                      }
                    })
                : SizedBox.shrink()))
      });

  return buttons;
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
          EHModuleManager.resetAllModuleTabs();
          EHContextHelper.switchModule(EHConfigHelper.instance
              .getConfigItemWithDef('common.defaultModuleName', 'system'));
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
