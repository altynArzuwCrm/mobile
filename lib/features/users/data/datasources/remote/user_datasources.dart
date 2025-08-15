import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/users/data/models/user_model.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();

  Future<List<UserModel>> getAllUsers(UserParams params);

  Future<UserModel> getUserById(int id);

  Future<List<UserModel>> createUser(CreateUserParams params);

  Future<UserModel> editUser(CreateUserParams params);

  Future<List<UserModel>> deleteUser(int id);

  Future<bool> getUsersByRole();

  Future<bool> toggleUserActive();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiProvider apiProvider;

  UserRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<UserModel>> createUser(CreateUserParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.users,
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 200) {
      final users = await getAllUsers(UserParams());

      return users;
    } else {
      return [];
    }
  }

  @override
  Future<bool> getUsersByRole() async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.users}/role/admin',
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<UserModel>> deleteUser(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.users}/$id',
    );

    if (response.statusCode == 200) {
      final users = await getAllUsers(UserParams());

      return users;
    } else {
      return [];
    }
  }

  @override
  Future<UserModel> editUser(CreateUserParams params) async {
    final response = await apiProvider.put(
      endPoint: '${ApiEndpoints.users}/${params.id}',
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 200) {
      final user = await getUserById(params.id!);

      return user;
    } else {
      throw 'Exception ${response.statusCode}';
    }
  }

  @override
  Future<List<UserModel>> getAllUsers(UserParams params) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.users,
      query: params.toQueryParameters(),
    );

    final responseBody = response.data['data'] as List;

    final result = responseBody.map((e) => UserModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await apiProvider.get(endPoint: ApiEndpoints.currentUsers);
    final result = response.data['data'];

    return UserModel.fromJson(result);
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.users}/$id',
    );

    final result = response.data['data'];
    return UserModel.fromJson(result);
  }

  @override
  Future<bool> toggleUserActive() async {
    final response = await apiProvider.patch(endPoint: ApiEndpoints.users);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
