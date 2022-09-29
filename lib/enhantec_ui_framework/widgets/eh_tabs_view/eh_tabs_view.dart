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

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_header.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_tab.dart';
import 'eh_tabs_header_mobile.dart';

enum EHTabsViewExpandMode {
  None, // Tab高度取决于子tab的内容高度。如mobile中子tab的每个功能希望高度跟随控件自身的高度自动增长。该种情况最外层的tab应使用ExpandMode.Scrollable。
  Expand, //Tab高度取决于屏幕剩余的高度，如果子tab过高会显示溢出。用于web端希望tab自动伸缩，但子tab没有设置高度，想跟随tab高度自动变化的情况，如EHGrid。
  Scroll //Tab高度取决于屏幕剩余的高度，如果子tab过高会自动显示滚动条。如mobile中希望整个页面都可以滚动，但要求子tab的高度可以计算得出，如果有子Tab,则子Tab需要使用ExpandMode.None，否则flutter会报错，因为算不出高度。例如：如果该模式下子Tab有使用EHGrid需要设置具体的高度。
}

class EHTabsView extends StatelessWidget {
  final EHTabsViewController controller;
  final Widget? preTabHeaderWidget;
  final EHTabsViewExpandMode expandMode;
  final bool? useBottomList;
  final bool showSideBorder;

  EHTabsView(
      {Key? key,
      this.preTabHeaderWidget,
      this.expandMode = EHTabsViewExpandMode.Scroll,
      this.useBottomList,
      this.showSideBorder = true,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getTabWidget(EHTab tab) {
      bool exclude =
          controller.tabsConfig.indexOf(tab) != controller.selectedIndex.value;
      return ExcludeFocus(
        child: Container(
          alignment: Alignment.topLeft,
          //color: Colors.grey,
          child: tab.tabWidget = tab.tabWidget ??
              (() {
                //print('called tab.getTabWidgetFunc ${tab.tabController}');
                return tab.getTabWidgetFunc(tab.tabController);
              })(),
        ),
        excluding: exclude,
      );
    }

    getExpandModeTabWidget(EHTab<EHController> tab) {
      EHTabsViewExpandMode tabExpandMode = tab.expandMode ?? expandMode;

      switch (tabExpandMode) {
        case EHTabsViewExpandMode.Scroll:
          return SingleChildScrollView(
            primary:
                false, //Related issue found here: https://github.com/flutter/flutter/issues/93862
            child: getTabWidget(tab),
          );

        case EHTabsViewExpandMode.None:
          return getTabWidget(tab);
        case EHTabsViewExpandMode.Expand:
          //ADD COLUMN element because indexedStack cannot have flexible child directly.
          //see https://stackoverflow.com/questions/54905388/incorrect-use-of-parent-data-widget-expanded-widgets-must-be-placed-inside-flex
          return Column(
            children: [
              Expanded(
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
              border: Border.symmetric(
                  horizontal: BorderSide(
                      width: showSideBorder ? 1.0 : 2.0,
                      color: EHThemeHelper.isDarkMode.isTrue
                          ? Colors.white30
                          : Colors.black45),
                  vertical: showSideBorder
                      ? BorderSide(
                          width: 1.0,
                          color: EHThemeHelper.isDarkMode.isTrue
                              ? Colors.white30
                              : Colors.black45)
                      : BorderSide.none)),
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.tabsConfig.map((tab) {
              return getExpandModeTabWidget(tab);
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
          () => expandMode != EHTabsViewExpandMode.None
              ? Expanded(
                  child: renderTabBody(),
                )
              : renderTabBody(),
        )
      ],
    );
  }
}
