import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_tabs_view_controller.dart';

class EHTabsHeaderMobile extends StatelessWidget {
  final EHTabsViewController controller;

  EHTabsHeaderMobile({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, String> translatedTabParams = {};

    controller.tabsConfig.forEach((tab) {
      if (tab.tabTranslateParams != null) {
        tab.tabTranslateParams!.forEach((key, value) {
          translatedTabParams[key] = value.tr;
        });
      }
    });

    return Obx(() => Container(
          height: 30,
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: EHText(
                weight: FontWeight.bold,
                text: controller
                    .tabsConfig[controller.selectedIndex.value].tabName
                    .trParams(translatedTabParams),
                size: 15,
              ))),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: showBottomList,
                  icon: Icon(Icons.auto_awesome_motion)),
            ],
          ),
        ));
  }

  showBottomList() {
    if (controller.tabsConfig.length == 0 ||
        controller.tabsConfig.where((e) => e.showInBottomList).length == 0) {
      EHToastMessageHelper.showInfoMessage("Window list is empty".tr,
          type: EHToastMsgType.Error);
    } else {
      Get.bottomSheet(
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              child: EHText(
                text: 'Window List'.tr,
                weight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                  color: Get.theme.canvasColor,
                  border: Border(bottom: BorderSide(color: Colors.grey))),
            ),
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: controller.tabsConfig
                          .asMap()
                          .entries
                          .where((e) => !e.value.isDeleted)
                          .map((entry) {
                        if (!entry.value.showInBottomList)
                          return SizedBox();
                        else
                          return ListTile(
                            tileColor:
                                controller.selectedIndex.value == entry.key
                                    ? Get.theme.hoverColor
                                    : ThemeController.instance.isDarkMode.value
                                        ? Get.theme.backgroundColor
                                        : Get.theme.canvasColor,
                            title: EHText(
                              text: entry.value.tabName.tr,
                            ),
                            leading: Icon(Icons.domain_verification),
                            trailing: entry.value.closable
                                ? IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () =>
                                        controller.removeTab(entry.key))
                                : SizedBox(),
                            onTap: () {
                              controller.selectedIndex.value = entry.key;
                              Get.back();
                            },
                          );
                      }).toList(),
                    )),
              ),
            ),
          ],
        ),
        backgroundColor: ThemeController.instance.isDarkMode.value
            ? Get.theme.backgroundColor
            : Get.theme.canvasColor,
        elevation: 5.0,
        enableDrag: true,
        //isScrollControlled: true,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(30.0),
        //   topRight: Radius.circular(30.0),
        // ))
      );
    }
  }
}
