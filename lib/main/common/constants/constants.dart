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

import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/system_module.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/tms_module/tms_module.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/wms_module/wms_module.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/workbench_module/workbench_module.dart';
import 'package:flutter/material.dart';

class NavigationKeys {
  static int rootNavKey = 0;
  static int dashBoardNavKey = 1;
}

enum SystemModule {
  wms,
  tms,
  system,
  workbench,
}

class MapConstant {
  // static const Map<SystemModule, String> systemModuleRoute = {
  //   SystemModule.wms: '/wmsModule',
  //   SystemModule.tms: '/tmsModule',
  //   SystemModule.system: '/systemModule',
  //   SystemModule.workbench: '/workBench',
  // };

  static Map<SystemModule, Widget> systemModuleMap = {
    SystemModule.wms: WmsModuleWidget(),
    SystemModule.tms: TmsModuleWidget(),
    SystemModule.system: SystemModuleWidget(),
    SystemModule.workbench: WorkbenchModuleWidget(),
  };
}
