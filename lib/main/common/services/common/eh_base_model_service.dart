import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'eh_rest_service.dart';

abstract class EHBaseModelService<T extends EHModel> extends GetxController {
  String get serviceName;

  Future<Map<String, dynamic>> findById({
    String actionName = 'findById',
    required String id,
  }) async {
    Response<Map<String, dynamic>> response = await EHRestService()
        .getByServiceName<Map<String, dynamic>>(
            serviceName: serviceName,
            actionName: actionName,
            pathSuffix: '/' + id);

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
    String actionName = 'createOrUpdate',
    required T model,
  }) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName, actionName: actionName, body: model);

    // if (EHUtilHelper.isEmpty(model.id)) {
    //   model.id = response.data!.id;
    //   model.addWho = response.data!.addWho;
    //   model.addDate = response.data!.addDate;
    // }
    // model.editWho = response.data!.editWho;
    // model.editDate = response.data!.editDate;

    model = model.fromJson(response.data!);
    return model;
  }

  Future<Rx<T>> createOrUpdateRxModel({
    String actionName = 'createOrUpdate',
    required Rx<T> model,
  }) async {
    Response response = await EHRestService().postByServiceName(
        serviceName: serviceName, actionName: actionName, body: model.value);

    // if (EHUtilHelper.isEmpty(model.id)) {
    //   model.id = response.data!.id;
    //   model.addWho = response.data!.addWho;
    //   model.addDate = response.data!.addDate;
    // }
    // model.editWho = response.data!.editWho;
    // model.editDate = response.data!.editDate;

    T newModelValue = model.value.fromJson(response.data!);
    model.value = newModelValue;

    model.refresh();

    return model;
  }

  Future<void> deleteModels({
    String actionName = 'delete',
    required List<String> ids,
  }) async {
    await EHRestService().postByServiceName(
        serviceName: serviceName, actionName: actionName, body: {'ids': ids});
  }
}
