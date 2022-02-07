import 'package:eh_flutter_framework/main/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_header.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eh_flutter_framework/main/common/constants.dart';
import 'eh_tabs_header_mobile.dart';

class EHTabsView extends StatelessWidget {
  final EHTabsViewController controller;
  final Widget? preTabHeaderWidget;

  EHTabsView({Key? key, this.preTabHeaderWidget, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Flexible(
          child: Obx(
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
                      child: tab.getTabWidgetFunc(tab.tabController),
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
          ),
        )
      ],
    );
  }
}
