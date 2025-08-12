import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/roles/data/models/role_model.dart';

abstract class RoleRemoteDatasource {
  Future<List<RoleModel>> getAllRoles();
}

class RoleRemoteDatasourceImpl implements RoleRemoteDatasource {
  final ApiProvider apiProvider;

  RoleRemoteDatasourceImpl(this.apiProvider);

  @override
  Future<List<RoleModel>> getAllRoles() async {
    final response = await apiProvider.get(endPoint: ApiEndpoints.roles);

    final responseBody = response.data as List;

    final result = responseBody.map((e) => RoleModel.fromJson(e)).toList();

    return result;
  }
}
