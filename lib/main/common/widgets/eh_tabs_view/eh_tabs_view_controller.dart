import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/scrollable_positioned_list/lib/item_positions_listener.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
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

  removeTab(int index) {
    // tabsData[index] = new TabData(
    //     tabsData[index].tabName,
    //     SizedBox(
    //       width: 0,
    //     ),
    //     isActive: false);

    tabsConfig[index].tabWidget = null;
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

  EHTab get selectedTab {
    return tabsConfig[selectedIndex.value];
  }

  reset() {
    tabsConfig = <EHTab>[].obs;
    selectedIndex = 0.obs;
  }
}
