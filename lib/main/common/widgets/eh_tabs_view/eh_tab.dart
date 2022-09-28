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
