import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/scrollable_positioned_list/lib/item_positions_listener.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'scrollable_positioned_list/lib/scrollable_positioned_list.dart';

class EHTabsViewController extends GetxController {
  //选中的TAB索引
  var selectedIndex = 0.obs;

  //var _innerScrollingIndex = 0.obs;

  RxList<TabData> tabsData = <TabData>[].obs;

  ItemScrollController itemScrollController = ItemScrollController();

  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  var minViewPortItemIndex = 0.obs;

  var maxViewPortItemIndex = 0.obs;

  var maxFullViewPortItemIndex = 0.obs;

  var minFullViewPortItemIndex = 0.obs;

  next() {
    if (maxFullViewPortItemIndex.value < tabsData.length - 1) {
      itemScrollController.jumpTo(index: (minViewPortItemIndex.value + 1));
    }
  }

  previous() {
    if (minFullViewPortItemIndex.value > 0) {
      int tempIndex = minFullViewPortItemIndex.value - 1;

      while (tempIndex > 0 && !tabsData[tempIndex].isActive) tempIndex--;

      itemScrollController.jumpTo(index: (tempIndex));
    }
  }

  removeTab(int index) {
    // tabsData[index] = new TabData(
    //     tabsData[index].tabName,
    //     SizedBox(
    //       width: 0,
    //     ),
    //     isActive: false);

    tabsData[index].isActive = false;
    tabsData.refresh();

    if (index == selectedIndex.value) {
      while (selectedIndex.value != 0 &&
          !tabsData[selectedIndex.value].isActive) selectedIndex--;
    }

    if (Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
  }

  addTab(String tabName, Widget widget, {bool closeable = false}) {
    tabsData.add(TabData(tabName.tr, widget, closable: closeable));
    // _innerScrollingIndex.value = tabsData.length - 1;
    itemScrollController.jumpTo(index: (tabsData.length - 1));

    selectedIndex.value = tabsData.length - 1;

    if (Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
  }
}
