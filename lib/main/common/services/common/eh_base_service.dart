import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'eh_rest_service.dart';

abstract class EHBaseService<T extends EHModel> extends GetxController {
  String get serviceName;

  Future<List<T>> query({
    required Map<String, dynamic> conditions,
  }) async {
    String serviceName = this.serviceName;
    String actionName = 'query';
    Response<List<T>?> res = await EHRestService().postByServiceName<List<T>?>(
        serviceName: serviceName,
        actionName: actionName,
        body: {
          'conditions': conditions,
        });

    return res.data ?? [];
  }

  Future<T?> find({
    required Map<String, dynamic> keys,
  }) async {
    String serviceName = this.serviceName;
    String actionName = 'find';
    Response<T> res = await EHRestService().postByServiceName<T>(
        serviceName: serviceName,
        actionName: actionName,
        body: {
          'keys': keys,
        });

    return res.data;
  }

  // static findModelByDatGridRow({
  //   required Map<String, dynamic> dataGridRow,
  // }) async {
  //   String serviceName = 'getFromModelAnnotation';
  //   String actionName = 'findByDataRow';
  //   await restService.postByServiceName<EHModel>(
  //       serviceName: serviceName,
  //       actionName: actionName,
  //       body: {
  //         'dataGridRow': dataGridRow,
  //       });
  // }

  save({
    required T model,
  }) async {
    String serviceName = this.serviceName;
    String actionName = 'save';
    await EHRestService().postByServiceName<List<Map<String, dynamic>>>(
        serviceName: serviceName, actionName: actionName, body: model);
  }

  delete({
    required Map<String, dynamic> keys,
  }) async {
    String serviceName = this.serviceName;
    String actionName = 'delete';

    await EHRestService().postByServiceName<List<Map<String, dynamic>>>(
        serviceName: serviceName,
        actionName: actionName,
        body: {
          'keys': keys,
        });
  }
}
