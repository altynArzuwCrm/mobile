import 'package:bloc/bloc.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/repositories/order_repository.dart';
import 'package:meta/meta.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this.repository) : super(OrderDetailLoading());

  final OrderRepository repository;

  Future<void> getOrderDetail(int id) async {
    emit(OrderDetailLoading());
    final result = await repository.getOrderById(id);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(OrderDetailConnectionError());
        } else {
          emit(OrderDetailError());
        }
      },
      (data) {
        emit(OrderDetailLoaded(data));
      },
    );
  }
  Future<void> updateOrder(CreateOrderParams params) async {
    emit(OrderDetailLoading());
    final result = await repository.editOrder(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(OrderDetailConnectionError());
        } else {
          emit(OrderDetailError());
        }
      },
      (data) {
        // emit(OrderDetailLoaded(data));
        getOrderDetail(params.id!);
      },
    );
  }
}
