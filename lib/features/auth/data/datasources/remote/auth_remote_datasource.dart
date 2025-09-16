import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/local/token_store.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/auth/domain/usecases/login_usecase.dart';
import 'package:crm/locator.dart' show locator;

abstract class AuthenticationRemoteDataSource {
  Future<void> login(LoginParams params);

  Future<bool> logout();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final ApiProvider apiProvider;

  AuthenticationRemoteDataSourceImpl({required this.apiProvider});

  @override
  Future<void> login(LoginParams params) async {
    Map<String, dynamic> data = {
      "username": params.username,
      "password": params.password,
      "fcm_token": params.fcmToken
    };

    final response = await apiProvider.post(
      endPoint: ApiEndpoints.login,
      data: data,
    );

    if (response.statusCode == 200) {
      final accessToken = response.data["token"];

      await locator<Store>().setToken(accessToken);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<bool> logout() async {
    final String? token = await locator<Store>().getToken();

    final response = await apiProvider.post(
      endPoint: ApiEndpoints.logout,
      token: token,
    );
    if (response.statusCode == 200) {
      await locator<Store>().clear();
      return true;
    } else {
      return false;
    }
  }
}
