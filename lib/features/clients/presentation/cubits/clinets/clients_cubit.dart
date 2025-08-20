
import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/clients/domain/usecases/delete_client_usecase.dart';
import 'package:crm/features/clients/domain/usecases/get_clients_usecase.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this._networkInfo) : super(ClientsLoading());

  final GetClientsUseCase _clientsUseCase = GetClientsUseCase(
    repository: locator(),
  );
  final DeleteClientUseCase _deleteClientUseCase = DeleteClientUseCase(
    repository: locator(),
  );
  final CreateClientUseCase _createClientUseCase = CreateClientUseCase(
    repository: locator(),
  );
  final NetworkInfo _networkInfo;

  List<ClientEntity> _clients = [];
  bool canLoad = true;

  // String?  selectedClientId ;


  Future<void> getAllClients(UserParams params) async {
    final bool hasInternet = await _networkInfo.isConnected;

    if (!hasInternet && _clients.isNotEmpty) {
      canLoad = false;
      return;
    } else if (hasInternet) {
      canLoad = true;
    }

    final result = await _clientsUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(ClientsConnectionError());
        } else {
          emit(ClientsError());
        }
      },
      (data) {
        canLoad = data.isNotEmpty;
        if (params.page == 1) {
          _clients = data;
        } else {
          final existingIds = _clients.map((c) => c.id).toSet();
          final newItems = data.where((c) => !existingIds.contains(c.id)).toList();
          _clients.addAll(newItems);
        }
        emit(ClientsLoaded(_clients));
      },
    );

  }

  void updateClientLocally(ClientEntity client) {
    final index = _clients.indexWhere((u) => u.id == client.id);
    if (index != -1) {
      _clients[index] = client;
      emit(ClientsLoaded(List<ClientEntity>.from(_clients)));
    }
  }

  Future<void> deleteClient(int id) async {
    final result = await _deleteClientUseCase.execute(id);

    result.fold((error) {}, (data) {
      if (data.isNotEmpty) {
        emit(ClientsLoaded(data));
      }
    });
  }

  Future<void> createClient(CreateClientParams params) async {
    final result = await _createClientUseCase.execute(params);

    result.fold((error) {}, (data) {
      // if (data.isNotEmpty) {

      _clients.insert(0, data);
        emit(ClientsLoaded(List.from(_clients)));

      // }
    });
  }

  // void selectClient(String? clientId) {
  //   // if (state is ClientsLoaded) {
  //   //   final current = state as ClientsLoaded;
  //   //   emit(current.copyWith(selectedClient: clientId));
  //   // }
  //   // emit(ClientsLoaded(_clients));
  //   selectedClientId = clientId;
  // }
  // void clearSelection() {
  //   selectedClientId = null;
  // //  emit(ClientsLoaded(_clients));
  // }
}
