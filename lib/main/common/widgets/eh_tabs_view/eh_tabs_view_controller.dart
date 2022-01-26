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

  List<TabData> tabsData = <TabData>[].obs;

  ItemScrollController itemScrollController = ItemScrollController();

  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  var minViewPortItemIndex = 0.obs;

  var maxViewPortItemIndex = 0.obs;

  var maxFullViewPortItemIndex = 0.obs;

  var minFullViewPortItemIndex = 0.obs;

  next() {
    // if (_innerScrollingIndex.value < tabsData.length - 1 &&
    //     maxFullViewPortItemIndex.value < tabsData.length - 1) {
    //   _innerScrollingIndex++;
    //   itemScrollController.jumpTo(index: _innerScrollingIndex.value);
    // }

    if (maxFullViewPortItemIndex.value < tabsData.length - 1) {
      itemScrollController.jumpTo(index: (minViewPortItemIndex.value + 1));
    }
  }

  previous() {
    // if (minFullViewPortItemIndex.value == 0) {
    //   _innerScrollingIndex.value = 0;
    // } else if (_innerScrollingIndex.value > 0) {
    //   _innerScrollingIndex--;
    //   itemScrollController.jumpTo(index: _innerScrollingIndex.value);
    //   }
    if (minFullViewPortItemIndex.value > 0) {
      itemScrollController.jumpTo(index: (minFullViewPortItemIndex.value - 1));
    }
  }

  removeTab(int index) {
    if (index <= selectedIndex.value) {
      if (selectedIndex.value != 0) selectedIndex--;
    }

    tabsData.removeAt(index);

    if (Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
  }

  addTab(String tabName, Widget widget) {
    tabsData.add(TabData(tabName, widget));
    // _innerScrollingIndex.value = tabsData.length - 1;
    itemScrollController.jumpTo(index: (tabsData.length - 1));

    selectedIndex.value = tabsData.length - 1;

    if (Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
  }
}
