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

import 'package:enhantec_frontend_project/enhantec_ui_framework/services/eh_base_model_service.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/services/eh_rest_service.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/services/service_names.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/modules/security/user/user_model.dart';

class UserService extends EHBaseModelService<UserModel> {
  UserService._internal();

  static UserService _singleton = new UserService._internal();

  factory UserService() => _singleton;

  @override
  String get serviceName => SecurityServiceNames.UserService;

  Future<void> deleteByIds(List<String> userIds) async {
    await EHRestService().deleteByServiceName(
        serviceName: serviceName, actionName: '', params: {'userIds': userIds});
  }
}
