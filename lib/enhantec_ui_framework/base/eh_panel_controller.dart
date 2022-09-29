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

class EHPanelController extends EHController {
  EHPanelController? parentController;
  EHPanelController? rootController;

  Map<String, dynamic> params;

  EHPanelController(EHPanelController? parentController,
      {this.params = const {}}) {
    this.parentController = parentController;
    this.rootController =
        parentController == null ? this : parentController.rootController;
  }

  bool isRootController() {
    return rootController == this;
  }

  // void initChildPanel(EHPanelController childPanelController) {
  //   childPanelController.parent = this;
  //   childPanelController.root = isRootController() ? this : root;
  // }
}
