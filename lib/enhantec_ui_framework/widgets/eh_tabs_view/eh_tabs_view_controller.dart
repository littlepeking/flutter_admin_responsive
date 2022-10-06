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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_exception.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/scrollable_positioned_list/lib/item_positions_listener.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scrollable_positioned_list/lib/scrollable_positioned_list.dart';

class EHTabsViewController extends GetxController {
  EHTabsViewController({
    Key? key,
    this.showScrollArrow = false,
    List<EHTab>? tabs,
  }) : this.tabsConfig = tabs == null ? <EHTab>[].obs : tabs.obs;

  //选中的TAB索引
  var selectedIndex = 0.obs;

  RxList<EHTab> tabsConfig = <EHTab>[].obs;

  ItemScrollController itemScrollController = ItemScrollController();

  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  var minViewPortItemIndex = 0.obs;

  var maxViewPortItemIndex = 0.obs;

  var maxFullViewPortItemIndex = 0.obs;

  var minFullViewPortItemIndex = 0.obs;

  bool showScrollArrow;

  next() {
    bool isNotFullyShownLastNotDeletedTab =
        tabsConfig.indexOf(tabsConfig.where((e) => !e.isDeleted).last) >
            maxFullViewPortItemIndex.value;
    if (maxFullViewPortItemIndex.value < tabsConfig.length - 1 &&
        isNotFullyShownLastNotDeletedTab) {
      int toIndex = minViewPortItemIndex.value + 1;
      while (tabsConfig[toIndex].isDeleted) toIndex++;
      itemScrollController.jumpTo(index: toIndex);
    }
  }

  previous() {
    if (minFullViewPortItemIndex.value > 0) {
      int toIndex = minFullViewPortItemIndex.value - 1;

      while (tabsConfig[toIndex].isDeleted) toIndex--;

      itemScrollController.jumpTo(index: (toIndex));
    }
  }

  EHTab getTab(String tabId) {
    Iterable<EHTab> iterator = tabsConfig.where((tab) => tab.tabName == tabId);

    if (iterator.isNotEmpty)
      return iterator.first;
    else
      throw EHException('Tab Id: \'' + tabId + '\' not found');
  }

  removeTab(int index) {
    // tabsData[index] = new TabData(
    //     tabsData[index].tabName,
    //     SizedBox(
    //       width: 0,
    //     ),
    //     isActive: false);

    tabsConfig[index].tabWidget = SizedBox.shrink();
    tabsConfig[index].isDeleted = true;
    tabsConfig.refresh();

    while (tabsConfig[selectedIndex.value].isDeleted) selectedIndex--;

    //add animation after removed last item
    if (!Responsive.isMobile(Get.context!))
      itemScrollController.jumpTo(index: minFullViewPortItemIndex.value);

    if ( //Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
  }

  initTabs(List<EHTab> tabs) {
    tabsConfig = tabs.obs;
  }

  getOrAddTab(EHTab tab) {
    if (Responsive.isMobile(Get.context!)) {
      List<EHTab> existedTabs = tabsConfig
          .where((t) => t.tabName == tab.tabName && t.isDeleted != true)
          .toList();

      existedTabs.length == 0 ? addTab(tab) : selectTab(existedTabs[0]);
    } else
      addTab(tab);
  }

  addTab(EHTab tab) {
    tabsConfig.add(tab);
    // itemScrollController.jumpTo(index: (tabsData.length - 1));
    if (!Responsive.isMobile(Get.context!)) {
      itemScrollController.scrollTo(
        index: (tabsConfig.length - 1),
        duration: Duration(microseconds: 1),
        curve: Curves.linear,
      );
    }

    selectedIndex.value = tabsConfig.length - 1;

    if (Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
  }

  selectTab(EHTab tab) {
    selectedTab = tab;
    Get.back();
  }

  EHTab get selectedTab {
    return tabsConfig[selectedIndex.value];
  }

  set selectedTab(tab) {
    selectedIndex.value = tabsConfig.indexOf(tab);
  }

  reset() {
    tabsConfig.value = <EHTab>[tabsConfig[0]];
    selectedIndex = 0.obs;
  }
}
