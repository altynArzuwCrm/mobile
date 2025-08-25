part of 'search_client_cubit.dart';

sealed class SearchClientState {}

final class SearchClientInitial extends SearchClientState {}
final class SearchClientLoading extends SearchClientState {}

final class SearchFoundedClients extends SearchClientState {
  final List<ClientEntity> data;

  SearchFoundedClients(this.data, );

}

final class SearchNotFoundedClients extends SearchClientState {}

final class SearchClientsConnectionError extends SearchClientState {}

final class SearchClientsError extends SearchClientState {}
