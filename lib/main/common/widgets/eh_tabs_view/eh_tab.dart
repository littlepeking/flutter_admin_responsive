import 'package:eh_flutter_framework/main/common/base/EHController.dart';

// typedef EHStatelessWidget<T> GetTabWidgetFunc<T extends GetxController>(
//     T controller);

class EHTab<T extends EHController> {
  String tabName;
  T tabController;
  Function getTabWidgetFunc;
  bool isActive;
  bool closable;

  EHTab(this.tabName, this.tabController, this.getTabWidgetFunc,
      {this.isActive = true, this.closable = false});
}
