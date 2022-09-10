import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_helper.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/header.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_service.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/base/StatefulWrapper.dart';
import '../dashboard/components/system_module/components/security/org/organization_model.dart';

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
          displayNameField: 'name');
    }

    getMenuItems() => [
          // if (Responsive.isMobile(context))
          //   Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: getFunctionBtnBar())
          // else
          SizedBox(height: 20),
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
                  bindingData: controller.selectedOrgModel.value,
                  popupTitle: '',
                  onTreeNodeTap: (data) {
                    if (data != null) controller.selectedOrgModel.value = data;
                  },
                  getDisplayValue: (data) {
                    return data != null
                        ? EHUtilHelper.getShortStr(
                            (data as OrganizationModel).name!.tr, 10)
                        : '';
                  },
                  loadTreeData: (EHTreeController treeController) async {
                    List treeMapData = await OrganizationService().buildTree();

                    loadOrgTreeData(treeMapData, treeController);
                  }))),

          // Image.asset(
          //   "assets/images/enhantec.png",
          //   height: 70,
          // ),
          SizedBox(
            height: 10,
          ),
          if (Responsive.isMobile(context))
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getSystemBtnBar()),
        ];

    getDrawerContent() => [
          Container(
            height: Responsive.isMobile(context) ? 185 : 150,
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
                      body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getDrawerContent()),
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
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
