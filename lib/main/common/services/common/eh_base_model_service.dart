import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'eh_rest_service.dart';

abstract class EHBaseModelService<T extends EHModel> extends GetxController {
  String get serviceName;

  Future<T> queryModel({
    String actionName = 'queryModel',
    required String id,
  }) async {
    Response<T> response = await EHRestService().postByServiceName<T>(
        serviceName: serviceName, actionName: actionName, body: {'id': id});

    return response.data!;
  }

  Future<List<T>> queryModels({
    String actionName = 'query',
    required List<String> ids,
  }) async {
    Response<List<T>> response = await EHRestService()
        .postByServiceName<List<T>>(
            serviceName: serviceName,
            actionName: actionName,
            body: {'ids': ids});

    return response.data!;
  }

  Future<List<T>> queryByConditions({
    String actionName = 'queryByConditions',
    required Map<String, dynamic> conditions,
  }) async {
    Response<List<T>> response = await EHRestService()
        .postByServiceName<List<T>>(
            serviceName: serviceName, actionName: actionName, body: conditions);

    return response.data!;
  }

  Future<T> createOrUpdateModel({
    String actionName = 'save',
    required T model,
  }) async {
    Response<T> response = await EHRestService().postByServiceName<T>(
        serviceName: serviceName, actionName: actionName, body: model);

    if (EHUtilHelper.isEmpty(model.id)) {
      model.id = response.data!.id;
      model.addWho = response.data!.addWho;
      model.addDate = response.data!.addDate;
    }
    model.editWho = response.data!.editWho;
    model.editDate = response.data!.editDate;

    return response.data!;
  }

  Future<void> deleteModels({
    String actionName = 'delete',
    required List<String> ids,
  }) async {
    await EHRestService().postByServiceName(
        serviceName: serviceName, actionName: actionName, body: {'ids': ids});
  }
}
