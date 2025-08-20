import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repository, this._networkInfo) : super(OrdersLoading());

  final OrderRepository repository;
  final NetworkInfo _networkInfo;

  List<OrderModel> _orders = [];
  bool canLoad = true;

  void getAllOrders(OrderParams params) async {
    emit(OrdersLoading());
    final bool hasInternet = await _networkInfo.isConnected;

    if (!hasInternet && _orders.isNotEmpty) {
      canLoad = false;
      return;
    } else if (hasInternet) {
      canLoad = true;
    }
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
        // emit(OrdersLoaded(data));

        canLoad = data.isNotEmpty;
        if (params.page == 1) {
          _orders = data;
        } else {
          final existingIds = _orders.map((c) => c.id).toSet();
          final newItems = data
              .where((c) => !existingIds.contains(c.id))
              .toList();
          _orders.addAll(newItems);
        }
        emit(OrdersLoaded(_orders));
      },
    );
  }

  void createOrder(CreateOrderParams params) async {
    final result = await repository.createOrder(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(OrdersConnectionError());
        } else {
          emit(OrdersError());
        }
      },
      (data) {
        _orders.insert(0, data);
        emit(OrdersLoaded(_orders));
      },
    );
  }

  void updateOrderStageLocally(OrderModel updatedOrder) {
    if (state is OrdersLoaded) {
      final currentOrders = List<OrderModel>.from((state as OrdersLoaded).data);

      final index = currentOrders.indexWhere((o) => o.id == updatedOrder.id);
      if (index != -1) {
        currentOrders[index] = updatedOrder;
        emit(OrdersLoaded(currentOrders));
      }
    }
  }

  void updateOrderStage(String stage, int orderId) async {
    final result = await repository.editOrderStage(stage, orderId);

    result.fold((error) {}, (data) {
      updateOrderStageLocally(data);
    });
  }
}
