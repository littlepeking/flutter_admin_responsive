import 'package:eh_flutter_framework/main/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_header.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  EHTabsView(
      {Key? key,
      this.preTabHeaderWidget,
      this.expandMode = ExpandMode.Flexible,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getTabWidget() {
      return Obx(
        () => Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(
                    color: ThemeController.instance.isDarkMode.isTrue
                        ? Colors.white30
                        : Colors.black45)),
            child: IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.tabsConfig.map((tab) {
                return Container(
                  alignment: Alignment.topLeft,
                  //color: Colors.grey,
                  child: tab.tabWidget = tab.tabWidget ??
                      (() {
                        print(
                            'called tab.getTabWidgetFunc ${tab.tabController}');
                        return tab.getTabWidgetFunc(tab.tabController);
                      })(),
                );
              }).toList(),
              //[
              // SingleChildScrollView(
              //   child: SizedBox(
              //     height: 1000,
              //     // width: 500,
              //     child: Container(
              //       color: Colors.red,
              //       child: Test2(),
              //     ),
              //   ),
              // ),
              //]
            )),
      );
    }

    getExpandModeTabWidget() {
      switch (expandMode) {
        case ExpandMode.Scrollable:
          return Flexible(
            child: SingleChildScrollView(
              child: getTabWidget(),
            ),
          );
        case ExpandMode.Growable:
          return getTabWidget();
        case ExpandMode.Flexible:
          return Flexible(
            child: getTabWidget(),
          );
      }
    }

    return Column(
      children: [
        Row(children: [
          preTabHeaderWidget ?? SizedBox(),
          Responsive.isMobile(context)
              ? Expanded(child: EHTabsHeaderMobile(controller: controller))
              : Expanded(
                  child: EHTabHeader(
                      key: PageStorageKey(UniqueKey), controller: controller)),
        ]),
        getExpandModeTabWidget()
      ],
    );
  }
}
