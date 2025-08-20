part of 'clients_cubit.dart';

sealed class ClientsState {}

final class ClientsLoading extends ClientsState {}

final class ClientsLoaded extends ClientsState {
  final List<ClientEntity> data;
  final String? selectedClient;

  ClientsLoaded(this.data, {this.selectedClient});

  ClientsLoaded copyWith({List<ClientEntity>? data, String? selectedClient}) {
    return ClientsLoaded(
      data ?? this.data,
      selectedClient: selectedClient ?? this.selectedClient,
    );
  }
}

final class ClientsConnectionError extends ClientsState {}

final class ClientsError extends ClientsState {}
