import 'package:bloc/bloc.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/repositories/order_repository.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repository) : super(OrdersLoading());

  final OrderRepository repository;

  Future<void> getAllOrders(OrderParams params) async {
    emit(OrdersLoading());
    final result = await repository.getAllOrders(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(OrdersConnectionError());
        } else {
          emit(OrdersError());
        }
      },
      (data) {
        emit(OrdersLoaded(data));
      },
    );
  }
}
