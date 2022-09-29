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

import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/org/organization_model.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_context_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_navigator.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tree_popup.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tree_view/eh_tree_helper.dart';
import 'package:enhantec_frontend_project/main/common/constants/constants.dart';
import 'package:enhantec_frontend_project/main/common/utils/context_helper.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/header.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/org/organization_service.dart';
import 'package:enhantec_frontend_project/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../enhantec_ui_framework/base/StatefulWrapper.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SideMenuController controller = SideMenuController.instance;

    Future<OrganizationModel?> loadOrgTreeData(
        List data, EHTreeController orgTreeController,
        {String? overrideSelectedTreeNodeId}) async {
      return EHTreeUtilHelper.loadTreeNodesFromMap<OrganizationModel>(
          data, orgTreeController, OrganizationModel.fromJson,
          overrideSelectedTreeNodeId: overrideSelectedTreeNodeId,
          rootNode: null,
          displayNameField: 'name',
          treeNodePostProcessor: (node) =>
              //if any role of the org is assigned to user, then node.ischecked == true
              node.disableTap = node.isChecked != true);
    }

    getMenuItems() => [
          // if (Responsive.isMobile(context))
          //   Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: getFunctionBtnBar())
          // else
          Responsive.isMobile(Get.context!)
              ? SizedBox(height: 10)
              : SizedBox(height: 20),
          SizedBox(
            height: 10,
          ),
          Text(
            'Enhantec',
            style: TextStyle(fontFamily: 'Righteous', fontSize: 30),
          ),
          // Obx(() => EHDropdown(
          //     controller: EHDropDownController(
          //         isMenu: false,
          //         key: GlobalKey(),
          //         focusNode: FocusNode(),
          //         items: {'0': 'HQ'},
          //         bindingValue: controller.selectedOrgId.value,
          //         onChanged: (value) =>
          //             controller.selectedOrgId.value = value))),
          // Obx(() => EHPopup(
          //     controller: EHPopupController(
          //         key: GlobalKey(),
          //         focusNode: FocusNode(),
          //         codeColumnName: 'id',
          //         bindingValue: controller.selectedOrgId.value,
          //         dataSource: DataGridTest.getDataGridSource(),
          //         popupTitle: '',
          //         onEditingComplete: (code, row) {
          //           if (code != null) controller.selectedOrgId.value = code;
          //         }))),

          Obx(() => EHTreePopup(
              controller: EHTreePopupController(
                  key: GlobalKey(),
                  focusNode: FocusNode(),
                  width: 180,
                  bindingData: EHContextHelper.selectedOrgModel.value ??
                      EHContextHelper.defaultOrgModel,
                  popupTitleMsgKey: 'common.security.selectOrg',
                  onTreeNodeTap: (data) {
                    if (data != null) {
                      EHContextHelper.switchOrg(data);
                      ContextHelper.resetAllModuleTabs();
                      ContextHelper.currentModule.value =
                          SystemModule.workbench;
                      EHNavigator.navigateTo(
                        MapConstant.systemModuleRoute[
                            ContextHelper.currentModule.value]!,
                        navigatorKey: NavigationKeys.dashBoardNavKey,
                      );
                    }
                  },
                  getDisplayValue: (data) {
                    return data != null
                        ? EHUtilHelper.getShortStr(
                            (data as OrganizationModel).name!.tr, 15)
                        : '';
                  },
                  loadTreeData: (EHTreeController treeController) async {
                    List treeMapData =
                        await OrganizationService().buildTreeByUserId();

                    loadOrgTreeData(treeMapData, treeController);
                  }))),

          // Image.asset(
          //   "assets/images/enhantec.png",
          //   height: 70,
          // ),
          if (Responsive.isMobile(context))
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getSystemBtnBar()),
        ];

    getDrawerContent() => [
          Container(
            height: Responsive.isMobile(context) ? 200 : 150,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: Center(
                  child: Column(
                children: getMenuItems(),
              )),
              // child: Image.asset("assets/images/Home.png"),
            ),
          ),
          Obx(() => controller.getSideBarTreeView()),
        ];

    return StatefulWrapper(
        onInit: () async {},
        getChildWidget: () => Drawer(
              child: Responsive.isMobile(Get.context!)
                  ? Scaffold(
                      body: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getDrawerContent()),
                      ),
                      persistentFooterButtons: Responsive.isMobile(Get.context!)
                          ? getFunctionBtnBar()
                          : [],
                    )
                  : ListView(children: getDrawerContent()),
              // bottomNavigationBar: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: getFunctionBtnBar()),
              // ),
            ));
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
