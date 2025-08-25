import 'package:bloc/bloc.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/clients/domain/entities/client_entity.dart';
import 'package:crm/features/clients/domain/usecases/get_clients_usecase.dart';
import 'package:crm/features/users/domain/entities/user_params.dart';
import 'package:crm/locator.dart';
import 'package:meta/meta.dart';

part 'search_client_state.dart';

class SearchClientCubit extends Cubit<SearchClientState> {
  SearchClientCubit() : super(SearchClientInitial());

  final GetClientsUseCase _clientsUseCase = GetClientsUseCase(
    repository: locator(),
  );

  void initializeSearch(){
    emit(SearchClientInitial());
  }

  List<ClientEntity> _clients = [];

  void searchClients(UserParams params) async {

    emit(SearchClientLoading());

    final result = await _clientsUseCase.execute(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(SearchClientsConnectionError());
        } else {
          emit(SearchClientsError());
        }
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchNotFoundedClients());
        } else {
          _clients.addAll(data);
          emit(SearchFoundedClients(List.from(_clients)));
        }
      },
    );
  }


  void deleteClient(int id){
    _clients.removeWhere((e)=> e.id == id);
    emit(SearchFoundedClients(List.from(_clients)));
  }

}
