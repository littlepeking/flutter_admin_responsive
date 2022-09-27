import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:flutter/material.dart';

import 'eh_tabs_view.dart';

// typedef EHStatelessWidget<T> GetTabWidgetFunc<T extends GetxController>(
//     T controller);

class EHTab<T extends EHController> {
  String tabId;
  String tabHeaderMsgKey;
  Map<String, String>? tabTranslateParams;
  T tabController;
  Widget Function(T controller) getTabWidgetFunc;

  bool isDeleted = false;

  bool isHide;

  final EHTabsViewExpandMode? expandMode;

  Widget? tabWidget;
  //bool isActive;
  bool closable;
  bool showInBottomList; //Used only in mobile mode

  EHTab(this.tabId, this.tabHeaderMsgKey, this.tabController,
      this.getTabWidgetFunc,
      {this.tabTranslateParams,
      this.closable = false,
      this.isHide = false,
      this.showInBottomList = true,
      this.expandMode});
}
