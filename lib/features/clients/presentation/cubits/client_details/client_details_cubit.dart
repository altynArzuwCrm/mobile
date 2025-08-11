import 'package:bloc/bloc.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/create_client_usecase.dart';
import 'package:crm/features/clients/domain/usecases/edit_client_usecase.dart';
import 'package:crm/features/clients/domain/usecases/get_client_by_id_usecase.dart';
import 'package:crm/features/clients/domain/usecases/get_clients_usecase.dart';
import 'package:crm/locator.dart';
import 'package:meta/meta.dart';

part 'client_details_state.dart';

class ClientDetailsCubit extends Cubit<ClientDetailsState> {
  ClientDetailsCubit() : super(ClientDetailsLoading());

  final GetClientByIdUseCase _clientDetailsUseCase = GetClientByIdUseCase(
    repository: locator(),
  );

  final EditClientUseCase _editClientUseCase = EditClientUseCase(
    repository: locator(),
  );

  Future<void> getClientDetails(int id) async {
    emit(ClientDetailsLoading());

    final result = await _clientDetailsUseCase.execute(id);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(ClientDetailsConnectionError());
        } else {
          emit(ClientDetailsError());
        }
      },
      (right) {
        emit(ClientDetailsLoaded(right));
      },
    );
  }

  Future<void> editClient(CreateClientParams params) async {
    emit(ClientDetailsLoading());
    final result = await _editClientUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(ClientDetailsConnectionError());
        } else {
          emit(ClientDetailsError());
        }
      },
      (right) {
        emit(ClientDetailsLoaded(right));
      },
    );
  }
}
