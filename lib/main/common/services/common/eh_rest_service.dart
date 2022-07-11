import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/eh_navigator.dart';
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwtToken = prefs.get("Authorization") == null ||
              prefs.get("Authorization") == "null"
          ? ''
          // ? 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqZXNzaWNhIiwiYXV0aG9yaXRpZXMiOiJSRUNFSVBUVVNFUiIsImlhdCI6MTY1MDkzNjEwMn0.KK1Cl9R9n340beRkuOpT4fhsOR2GKxG0mw4UxQvn-MRVYnVF5vBto-A3w9bNYzyLl8Q15z4HdU2qhQATVUfUFg' //TEST JWT TOKEN
          : prefs.get("Authorization").toString();
      requestOptions.headers.addAll({"Authorization": jwtToken});
      return handler.next(requestOptions);
    }, onResponse:
        (Response response, ResponseInterceptorHandler handler) async {
      //await Future.delayed(Duration(seconds: 2));
      //if (loadingIndicator.isOpen) loadingIndicator.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwtToken = prefs.get("Authorization").toString();
      // if the value is the same as the header, continue with the request
      if (response.headers.value("Authorization") != jwtToken) {
        //Renew token here...
        prefs.setString("Authorization", jwtToken);
      }

      return handler.next(response);
    }, onError: (DioError error, ErrorInterceptorHandler handler) async {
      // await Future.delayed(Duration(seconds: 2));
      //if (loadingIndicator.isOpen) loadingIndicator.hide();
      if (error.response?.statusCode == 404) {
        EHToastMessageHelper.showInfoMessage('request url cannot found'.tr);
        //return handler.next(error);
      } else if (error.response?.statusCode == 401) {
        // bus.emit("401");
        if (error.response?.data!['details'] == 'Bad credentials') {
          EHToastMessageHelper.showLoginErrorMessage('Bad credentials'.tr);
        } else if (error.response?.data!['details'] ==
            'user login is expired.') {
          EHToastMessageHelper.showLoginErrorMessage(
              error.response!.data!['details'].toString().tr);
          EHNavigator.navigateTo("/login");
        } else if (error.response?.data!['details']) {
          EHToastMessageHelper.showLoginErrorMessage(
              error.response!.data!['details'].toString().tr);
          EHNavigator.navigateTo("/login");
        } else {
          EHToastMessageHelper.showInfoMessage('Unauthorized'.tr);
        }
      } else {
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout ||
            error.type == DioErrorType.sendTimeout) {
          EHToastMessageHelper.showInfoMessage('Network connect error.'.tr);
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

  Future<Response<T>> getByServiceName<T>({
    required String serviceName,
    required String actionName,
    Map<String, dynamic>? params,
    Options? options,
  }) {
    return _dio.get<T>(serviceName + '/' + actionName,
        queryParameters: params, options: options);
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
