
import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/clients/domain/usecases/create_client_contact_usecase.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';

abstract class ClientRemoteDataSource {
  Future<List<ClientModel>> getAllClients(UserParams params);

  Future<ClientModel> getClientById(int id);

  Future<ClientModel> createClient(CreateClientParams params);

  Future<ClientModel> editClient(CreateClientParams params);

  Future<List<ClientModel>> deleteClient(int id);

  Future<bool> createClientContact(ClientContactParams params);

  Future<bool> editClientContact(ClientContactParams params);

  Future<bool> deleteClientContact(int id);

  Future<List<String>> getCompanies();
  Future<ClientModel> getCompanyDetails(String title);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final ApiProvider apiProvider;

  ClientRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<ClientModel>> getAllClients(UserParams params) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.clients,
      query: params.toQueryParameters(),
    );

    final responseBody = response.data['data'] as List;

    final result = responseBody.map((e) => ClientModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<ClientModel> getClientById(int id) async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.clients}/$id',
    );
    final result = response.data;
    return ClientModel.fromJson(result);
  }

  @override
  Future<ClientModel> createClient(CreateClientParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.clients,
      data: params.toQueryParameters(),
    );
    // if (response.statusCode == 201) {
    //   final clients = await getAllClients(UserParams());
    //
    //   return clients;
    // } else {
    //   return [];
    // }
    final result = response.data["data"];
    return ClientModel.fromJson(result);
  }

  @override
  Future<ClientModel> editClient(CreateClientParams params) async {
    final response = await apiProvider.put(
      endPoint: '${ApiEndpoints.clients}/${params.id}',

      data: params.toQueryParameters(),
    );
    final result = response.data;
    return ClientModel.fromJson(result);
  }

  @override
  Future<List<ClientModel>> deleteClient(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.clients}/$id',
    );

    if (response.statusCode == 200) {
      final clients = await getAllClients(UserParams());

      return clients;
    } else {
      return [];
    }
  }

  @override
  Future<bool> createClientContact(ClientContactParams params) async {
    final response = await apiProvider.post(
      endPoint: '${ApiEndpoints.clients}/${params.id}/${ApiEndpoints.contacts}',
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> editClientContact(ClientContactParams params) async {
    final response = await apiProvider.put(
      endPoint:
          '${ApiEndpoints.clients}/${params.id}/${ApiEndpoints.contacts}/${params.id}',
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteClientContact(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.clients}/$id/${ApiEndpoints.contacts}/$id',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<String>> getCompanies() async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.clients}/companies',
    );

    final List<dynamic> data = response.data;

    return data.map((e) => e.toString()).toList();
  }

  @override
  Future<ClientModel> getCompanyDetails(String title) async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.clients}/company/$title',
    );
    final result = response.data[0];
    return ClientModel.fromJson(result);
  }

}
