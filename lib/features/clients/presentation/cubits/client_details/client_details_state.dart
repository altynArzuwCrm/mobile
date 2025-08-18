part of 'client_details_cubit.dart';

sealed class ClientDetailsState {}

final class ClientDetailsLoading extends ClientDetailsState {}
final class ClientDetailsLoaded extends ClientDetailsState {
  final ClientEntity data;

  ClientDetailsLoaded(this.data);
}
final class ClientDetailsConnectionError extends ClientDetailsState {}
final class ClientDetailsError extends ClientDetailsState {}
