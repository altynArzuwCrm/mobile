import 'package:crm/core/error/failure.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_order_state.dart';

class SearchOrderCubit extends Cubit<SearchOrderState> {
  SearchOrderCubit(this.repository) : super(SearchOrderInitial());
  final OrderRepository repository;

  void initializeSearch() {
    emit(SearchOrderInitial());
  }

  void searchOrders(OrderParams params) async {
    emit(SearchOrderLoading());

    final result = await repository.getAllOrders(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(SearchOrdersConnectionError());
        } else {
          emit(SearchOrdersError());
        }
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchNotFoundedOrders());
        } else {
          emit(SearchFoundedOrders(data));
        }
      },
    );
  }
}
