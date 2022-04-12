import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:login_flutter_app/constant/api_constant.dart';

class ApiService extends getx.GetxService {
  final Dio _dio = Dio();
  final baseUrl = ApiConstant.baseUrl;
  static ApiService get to => getx.Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
    log('Initialized Api Service');
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          log('${options.method} REQUESTING ${options.uri}');
          if (options.method != 'GET') {
            log(' - With -');
            // log('${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, ResponseInterceptorHandler handler) async {
          log('${response.statusCode} RESPONSE \n ${response.data}');
          handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          log('API ERROR');
          log('${e.response?.data}');
          handler.next(e);
        },
      ),
    );
  }

  Future<String> signInUser(Map<String, String> data) async {
    String userMsg = '';
    try {
      Response response = await _dio.post(ApiConstant.signInApi, data: data);
      if (response.statusCode == 200) {
        userMsg = response.data;
        if (response.data == '"Login Matched"') {
          userMsg = 'success';
        }
      }
    } on DioError catch (e) {
      try {
        if (e.response!.statusCode == 401) {
          userMsg = 'Something want wrong';
        } else if (e.response!.statusCode == 501) {
          userMsg = 'Internal Server Error';
        } else {
          userMsg = 'Something want wrong';
        }
      } catch (e) {
        userMsg = 'Something want wrong';
        log(e.toString());
      }
    } catch (e) {
      userMsg = '';
    }

    return userMsg == '' ? ' Something want wrong' : userMsg;
  }

  Future<String> signUpUser(Map<String, String> data) async {
    String userMsg = '';
    try {
      Response response = await _dio.post(ApiConstant.signUpApi, data: data);
      if (response.statusCode == 200) {
        userMsg = response.data;
        if (response.data == '"User Registered Successfully"') {
          userMsg = 'success';
        }
      }
    } on DioError catch (e) {
      try {
        if (e.response!.statusCode == 401) {
          userMsg = 'Something want wrong';
        } else if (e.response!.statusCode == 501) {
          userMsg = 'Internal Server Error';
        } else {
          userMsg = 'Something want wrong';
        }
      } catch (e) {
        userMsg = 'Something want wrong';
        log(e.toString());
      }
    } catch (e) {
      userMsg = '';
    }

    return userMsg == '' ? 'Something want wrong' : userMsg;
  }
}
