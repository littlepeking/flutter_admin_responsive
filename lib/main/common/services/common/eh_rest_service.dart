import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_navigator.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:shared_preferences/shared_preferences.dart';

class EHRestService extends GetxController {
  var _dio = Dio();
  var useCharles = false;

  ///使用charles需修改对应ip
  String charlesProxy = '169.254.124.128:8887';

  static EHRestService _singleton = new EHRestService._internal();

  factory EHRestService() => _singleton;

  EHRestService._internal() {
    //dio.options.baseUrl = "http://rest.vtpm.starblingbling.com/";
    //dio.options.connectTimeout = 20000;
    //dio.options.receiveTimeout = 10000;

    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions requestOptions,
            RequestInterceptorHandler handler) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwtToken = prefs.get("jwt-token") == null
          ? ''
          : prefs.get("jwt-token").toString();
      requestOptions.headers.addAll({"jwt-token": jwtToken});
      return handler.next(requestOptions);
    }, onResponse:
        (Response response, ResponseInterceptorHandler handler) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwtToken = prefs.get("jwt-token").toString();

      // if the value is the same as the header, continue with the request
      if (response.headers.value("jwt-token") != jwtToken) {
        //Renew token here...
        prefs.setString("jwt-token", jwtToken);
      }

      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      if (error.response?.statusCode == 404) {
        EHToastMessageHelper.showInfoMessage('request url cannot found'.tr);
        //return handler.next(error);
      } else if (error.response?.statusCode == 401) {
        EHNavigator.navigateTo("/login");
        // bus.emit("401");
        EHToastMessageHelper.showInfoMessage(
            'Unauthorized or Session timeout'.tr);
      } else {
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout ||
            error.type == DioErrorType.sendTimeout) {
          EHToastMessageHelper.showInfoMessage('Network connect error.'.tr);
        } else {
          // if (error.response!.statusCode == 500) {
          //   throw Exception("Server Error");
          // }
          var errData = error.response?.data;
          if (errData != null) {
            EHToastMessageHelper.showInfoMessage(errData["message"]);
          }

          return handler.next(error);
        }
      }
      return handler.next(error);
    }));

    ///charles抓包
    if (kDebugMode && useCharles) {
      bool isProxyChecked = true;
      String proxy = charlesProxy;
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return isProxyChecked && Platform.isAndroid;
        };
        client.findProxy = (url) {
          return isProxyChecked ? 'PROXY $proxy' : 'DIRECT';
        };

        return client;
      };
    }
  }

  Future<Response<T>> get<T>(
      {required String path,
      required Map<String, dynamic>? params,
      required Options? options}) {
    return _dio.get<T>(path, queryParameters: params, options: options);
  }

  Future<Response<T>> post<T>({
    required String path,
    body,
    Map<String, dynamic>? params,
    bool isFormData = false,
    Options? options,
  }) {
    if (isFormData) {
      FormData formData = new FormData.fromMap(body);
      body = formData;
    }
    return _dio.post<T>(path,
        data: body, queryParameters: params, options: options);
  }

  Future<Response<T>> postByServiceName<T>({
    required String serviceName,
    required String actionName,
    body,
    Map<String, dynamic>? params,
    bool isFormData = false,
    Options? options,
  }) {
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
  }) {
    return _dio.download(urlPath, savePath,
        queryParameters: queryParams, onReceiveProgress: progressCallback);
  }
}
