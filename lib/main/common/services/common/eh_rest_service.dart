import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_context_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import '../../widgets/eh_loading_indicator.dart';

class EHRestService extends GetxController {
  var _dio = Dio();
  var useCharles = false;

  ///使用charles需修改对应ip
  String charlesProxy = '169.254.124.128:8887';

  static EHRestService _singleton = new EHRestService._internal();

  factory EHRestService() => _singleton;

  EHLoadingIndicator loadingIndicator =
      EHLoadingIndicator(context: Get.context, barrierDimisable: false);

  EHRestService._internal() {
    _dio.options.baseUrl = "http://192.168.4.39:8061/api/";
    //dio.options.connectTimeout = 20000;
    //dio.options.receiveTimeout = 10000;

    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions requestOptions,
            RequestInterceptorHandler handler) async {
      //DISABLE SPINNER since it will prevent cursor move to selected widget after unfocused from popup which triggering a rest service call.
      //if (!loadingIndicator.isOpen) loadingIndicator.showIndicator();
      String? authorization = await EHContextHelper.getString("Authorization");
      String jwtToken = authorization == null || authorization == "null"
          ? ''
          // ? 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqZXNzaWNhIiwiYXV0aG9yaXRpZXMiOiJSRUNFSVBUVVNFUiIsImlhdCI6MTY1MDkzNjEwMn0.KK1Cl9R9n340beRkuOpT4fhsOR2GKxG0mw4UxQvn-MRVYnVF5vBto-A3w9bNYzyLl8Q15z4HdU2qhQATVUfUFg' //TEST JWT TOKEN
          : authorization;
      requestOptions.headers.addAll({
        "Authorization": jwtToken,
        "Accept-Language":
            Get.locale!.languageCode + '-' + Get.locale!.countryCode!,
        'orgId': EHContextHelper.selectedOrgModel.value?.id,
        //Should not and No need pass userId to backend as backend will get it from jwtToken.
        // 'userId': (await EHContextHelper.getUserDetail()).id
      });
      return handler.next(requestOptions);
    }, onResponse:
        (Response response, ResponseInterceptorHandler handler) async {
      //await Future.delayed(Duration(seconds: 2));
      //if (loadingIndicator.isOpen) loadingIndicator.hide();
      String? authorization = await EHContextHelper.getString("Authorization");
      // if the value is the same as the header, continue with the request
      if (authorization != null &&
          response.headers.value("Authorization") != authorization) {
        //Renew token here...
        EHContextHelper.setString("Authorization", authorization);
      }

      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      // await Future.delayed(Duration(seconds: 2));
      //if (loadingIndicator.isOpen) loadingIndicator.hide();
      if (error.response?.statusCode == 404) {
        EHToastMessageHelper.showInfoMessage('common.error.urlNotFound'.tr,
            type: EHToastMsgType.Error);
        //return handler.next(error);
      } else if (error.response?.statusCode == 401) {
        // bus.emit("401");
        if (error.response?.data!['details'] == 'Bad credentials') {
          EHToastMessageHelper.showLoginErrorMessage(
              'common.security.badCredentials'.tr);
        } else if (error.response?.data!['details'] ==
            'user login is expired.') {
          EHToastMessageHelper.showLoginErrorMessage(
              'common.security.loginExpired'.tr);
          await EHContextHelper.logout();
        } else if (error.response?.data!['details'] != null) {
          EHToastMessageHelper.showLoginErrorMessage(
              error.response!.data!['details'].toString());
          await EHContextHelper.logout();
        } else {
          EHToastMessageHelper.showInfoMessage(
              'common.security.unauthorized'.tr);
        }
      } else {
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout ||
            error.type == DioErrorType.sendTimeout) {
          EHToastMessageHelper.showInfoMessage('Network connect error.'.tr,
              type: EHToastMsgType.Error);
        } else {
          //comment this part as all other exception should be handled by developer and if it doesn't, dioError will be finally catched by main.dart
          // var errData = error.response?.data;
          // if (errData != null) {
          //   RestError error = RestError.fromJsonStr(errData);
          //   EHToastMessageHelper.showInfoMessage(
          //       '\n' +
          //           'Error Type:'.tr +
          //           "  " +
          //           error.title.tr +
          //           '\n\n' +
          //           'Error Detail:'.tr +
          //           "\n" +
          //           error.detail,
          //       title: 'System Error');
          // }

          return handler.next(error);
        }
      }
      //return handler.next(error);
    }));

    ///charles抓包
    if (kDebugMode && useCharles) {
      bool isProxyChecked = false;
      String proxy = charlesProxy;
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          // ignore: dead_code
          return isProxyChecked && Platform.isAndroid;
        };
        client.findProxy = (url) {
          // ignore: dead_code
          return isProxyChecked ? 'PROXY $proxy' : 'DIRECT';
        };

        return client;
      };
    }
  }

  Future<Response<T>> get<T>(
      {required String path,
      required Map<String, dynamic>? params,
      required Options? options}) async {
    return _dio.get<T>(path, queryParameters: params, options: options);
  }

  Future<Response<T>> delete<T>(
      {required String path,
      required Map<String, dynamic>? params,
      required Options? options}) async {
    return _dio.delete<T>(path, queryParameters: params, options: options);
  }

  Future<Response<T>> post<T>({
    required String path,
    body,
    Map<String, dynamic>? params,
    bool isFormData = false,
    Options? options,
  }) async {
    if (isFormData) {
      FormData formData = new FormData.fromMap(body);
      body = formData;
    }
    return _dio.post<T>(path,
        data: body, queryParameters: params, options: options);
  }

  Future<Response<T>> getByServiceName<T>({
    required String serviceName,
    required String actionName,
    Map<String, dynamic>? params,
    String pathSuffix = '',
    Options? options,
  }) async {
    return _dio.get<T>(serviceName + '/' + actionName + pathSuffix,
        queryParameters: params, options: options);
  }

  Future<Response<T>> deleteByServiceName<T>({
    required String serviceName,
    String? actionName,
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return _dio.delete<T>(
        actionName == null ? serviceName : serviceName + '/' + actionName,
        data: data,
        queryParameters: params,
        options: options);
  }

  Future<Response<T>> postByServiceName<T>({
    required String serviceName,
    required String actionName,
    body,
    Map<String, dynamic>? params,
    bool isFormData = false,
    Options? options,
  }) async {
    if (isFormData) {
      FormData formData = new FormData.fromMap(body);
      body = formData;
    }
    return _dio.post<T>(serviceName + '/' + actionName,
        data: body, queryParameters: params, options: options);
  }

  Future<Response> download({
    required String urlPath,
    savePath,
    Map<String, dynamic>? queryParams,
    ProgressCallback? progressCallback,
  }) async {
    return _dio.download(urlPath, savePath,
        queryParameters: queryParams, onReceiveProgress: progressCallback);
  }
}
