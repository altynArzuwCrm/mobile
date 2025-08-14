part of 'clients_cubit.dart';

sealed class ClientsState {}

final class ClientsLoading extends ClientsState {}

final class ClientsLoaded extends ClientsState {
  final List<ClientEntity> data;

  ClientsLoaded(this.data);
}

final class ClientsConnectionError extends ClientsState {}

final class ClientsError extends ClientsState {}
