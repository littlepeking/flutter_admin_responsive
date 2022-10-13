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

import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/organization_model.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/organization_service.dart';

class CommonDataSources {
  static Future<Map<String, String>> getOrgDDLDataSource() async {
    List<OrganizationModel> list = await OrganizationService().getOrgList();
    return Map<String, String>.fromIterable(list,
        key: (e) => (e as OrganizationModel).id!,
        value: (e) => (e as OrganizationModel).name!);
  }
}
