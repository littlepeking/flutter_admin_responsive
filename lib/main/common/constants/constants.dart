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

class NavigationKeys {
  static int rootNavKey = 0;
  static int dashBoardNavKey = 1;
}

class MapConstant {
  static const Map<SystemModule, String> systemModuleRoute = {
    SystemModule.wms: '/wmsModule',
    SystemModule.tms: '/tmsModule',
    SystemModule.system: '/systemModule',
    SystemModule.workbench: '/workBench',
  };
}

enum SystemModule {
  wms,
  tms,
  system,
  workbench,
}
