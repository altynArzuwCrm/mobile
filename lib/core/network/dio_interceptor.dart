
import 'package:crm/core/config/routes/routes_path.dart';
import 'package:crm/core/config/routes/widget_keys_str.dart';
import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/local/token_store.dart';
import 'package:crm/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TokenInterceptor extends Interceptor {
  Dio dio;

  TokenInterceptor(this.dio);

  bool _requiresToken(RequestOptions options) {
    final apiPathsRequiringToken = [
      ApiEndpoints.projects,
    ];
    return apiPathsRequiringToken.contains(options.path);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await locator<Store>().getToken();

    if (token != null) {
      if (_requiresToken(options)) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        RequestOptions options = err.response!.requestOptions;
        String? token = await locator<Store>().getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
          final response = await dio.fetch(options);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        debugPrint("Failed to refresh token: $e");
        await locator<Store>().clear();

        rootNavKey.currentContext!.go(AppRoutes.signIn);
      }
    }
    super.onError(err, handler);
  }
}
