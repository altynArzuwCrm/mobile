import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/clients/data/models/client_model.dart';
import 'package:crm/features/clients/domain/usecases/create_client_contact_usecase.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/projects/domain/usecases/get_all_projects_usecase.dart';

abstract class ClientRemoteDataSource {
  Future<List<ClientModel>> getAllClients(ProjectParams params);

  Future<ClientModel> getClientById(int id);

  Future<ClientModel> createClient(CreateClientParams params);

  Future<ClientModel> editClient(CreateClientParams params);

  Future<bool> deleteClient(int id);

  Future<bool> createClientContact(ClientContactParams params);

  Future<bool> editClientContact(ClientContactParams params);

  Future<bool> deleteClientContact(int id);
}

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final ApiProvider apiProvider;

  ClientRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<ClientModel>> getAllClients(ProjectParams params) async {
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
    final result = response.data['data'];

    return ClientModel.fromJson(result);
  }

  @override
  Future<ClientModel> editClient(CreateClientParams params) async {
    final response = await apiProvider.put(
      endPoint: ApiEndpoints.clients,
      data: params.toQueryParameters(),
    );
    final result = response.data;
    return ClientModel.fromJson(result);
  }

  @override
  Future<bool> deleteClient(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.clients}/$id',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
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
}
