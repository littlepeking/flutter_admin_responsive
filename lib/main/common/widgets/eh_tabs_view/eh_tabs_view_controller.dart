import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/scrollable_positioned_list/lib/item_positions_listener.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scrollable_positioned_list/lib/scrollable_positioned_list.dart';

class EHTabsViewController extends GetxController {
  //选中的TAB索引
  var selectedIndex = 0.obs;

  RxList<EHTab> tabsConfig = <EHTab>[].obs;

  ItemScrollController itemScrollController = ItemScrollController();

  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  var minViewPortItemIndex = 0.obs;

  var maxViewPortItemIndex = 0.obs;

  var maxFullViewPortItemIndex = 0.obs;

  var minFullViewPortItemIndex = 0.obs;

  next() {
    if (maxFullViewPortItemIndex.value < tabsConfig.length - 1) {
      itemScrollController.jumpTo(index: (minViewPortItemIndex.value + 1));
    }
  }

  previous() {
    if (minFullViewPortItemIndex.value > 0) {
      itemScrollController.jumpTo(index: (minFullViewPortItemIndex.value - 1));
    }
  }

  removeTab(int index) {
    // tabsData[index] = new TabData(
    //     tabsData[index].tabName,
    //     SizedBox(
    //       width: 0,
    //     ),
    //     isActive: false);

    tabsConfig.removeAt(index);
    tabsConfig.refresh();

    if (selectedIndex.value != 0 && index <= selectedIndex.value)
      selectedIndex--;

    //add animation after removed last item
    if (!Responsive.isMobile(Get.context!))
      itemScrollController.jumpTo(index: minFullViewPortItemIndex.value);

    if ( //Responsive.isMobile(Get.context!) ||
        Responsive.isTablet(Get.context!)) {
      Get.back();
    }
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

  reset() {
    tabsConfig = <EHTab>[].obs;
    selectedIndex = 0.obs;
  }
}
