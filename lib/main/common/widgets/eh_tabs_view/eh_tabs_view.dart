import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_header.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_tab.dart';
import 'eh_tabs_header_mobile.dart';

enum ExpandMode {
  Growable, // Tab高度取决于子tab的内容高度。如mobile中子tab的每个功能希望高度跟随控件自身的高度自动增长。该种情况最外层的tab应使用ExpandMode.Scrollable。
  Flexible, //Tab高度取决于屏幕剩余的高度，如果子tab过高会显示溢出。用于web端希望tab自动伸缩，但子tab没有设置高度，想跟随tab高度自动变化的情况，如EHGrid。
  Scrollable //Tab高度取决于屏幕剩余的高度，如果子tab过高会自动显示滚动条。如mobile中希望整个页面都可以滚动，但要求子tab的高度可以计算得出，如果有子tab需要使用ExpandMode.Growable，否则flutter会报错，因为算不出高度。例如：如果该模式下子Tab有使用EHGrid需要设置具体的高度。
}

class EHTabsView extends StatelessWidget {
  final EHTabsViewController controller;
  final Widget? preTabHeaderWidget;
  final ExpandMode expandMode;
  final bool? useBottomList;

  EHTabsView(
      {Key? key,
      this.preTabHeaderWidget,
      this.expandMode = ExpandMode.Flexible,
      this.useBottomList,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getTabWidget(EHTab tab) {
      return Container(
        alignment: Alignment.topLeft,
        //color: Colors.grey,
        child:
            controller.tabsConfig.indexOf(tab) != controller.selectedIndex.value
                ? SizedBox()
                : tab.tabWidget = tab.tabWidget ??
                    (() {
                      print('called tab.getTabWidgetFunc ${tab.tabController}');
                      return tab.getTabWidgetFunc(tab.tabController);
                    })(),
      );
    }

    getExpandModeTabWidget(EHTab<EHController> tab) {
      switch (expandMode) {
        case ExpandMode.Scrollable:
          return SingleChildScrollView(
            primary:
                false, //Related issue found here: https://github.com/flutter/flutter/issues/93862
            child: getTabWidget(tab),
          );

        case ExpandMode.Growable:
          return getTabWidget(tab);
        case ExpandMode.Flexible:
          //ADD COLUMN element because indexedStack cannot have flexible child directly.
          //see https://stackoverflow.com/questions/54905388/incorrect-use-of-parent-data-widget-expanded-widgets-must-be-placed-inside-flex
          return Column(
            children: [
              Flexible(
                child: getTabWidget(tab),
              ),
            ],
          );
      }
    }

    renderTabBody() {
      return Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              border: Border.all(
                  color: ThemeController.instance.isDarkMode.isTrue
                      ? Colors.white30
                      : Colors.black45)),
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.tabsConfig.map((tab) {
              return Obx(() => ExcludeFocus(
                    child: getExpandModeTabWidget(tab),
                    excluding: (() {
                      print(tab.tabName +
                          " " +
                          (controller.tabsConfig.indexOf(tab) !=
                                  controller.selectedIndex.value)
                              .toString());
                      return controller.tabsConfig.indexOf(tab) !=
                          controller.selectedIndex.value;
                    })(),
                  ));
            }).toList(),
          ));
    }

    getHeader(bool useBottomSheet) {
      return useBottomSheet
          ? Expanded(child: EHTabsHeaderMobile(controller: controller))
          : Expanded(
              child: EHTabHeader(
                  key: PageStorageKey(UniqueKey), controller: controller));
    }

    return Column(
      children: [
        Row(children: [
          preTabHeaderWidget != null
              ? Container(height: 30, child: preTabHeaderWidget!)
              : SizedBox(),
          getHeader(useBottomList ?? false),
        ]),
        Obx(
          () => expandMode != ExpandMode.Growable
              ? Expanded(
                  child: renderTabBody(),
                )
              : renderTabBody(),
        )
      ],
    );
  }
}
