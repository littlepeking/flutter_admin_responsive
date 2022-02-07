import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:flutter/material.dart';

// typedef EHStatelessWidget<T> GetTabWidgetFunc<T extends GetxController>(
//     T controller);

class EHTab<T extends EHController> {
  String tabName;
  Map<String, String>? tabTranslateParams;
  T tabController;
  Widget Function(T controller) getTabWidgetFunc;
  //bool isActive;
  bool closable;
  bool showInBottomList; //Used only in mobile mode

  EHTab(this.tabName, this.tabController, this.getTabWidgetFunc,
      {this.tabTranslateParams,
      this.closable = false,
      this.showInBottomList = true});
}
