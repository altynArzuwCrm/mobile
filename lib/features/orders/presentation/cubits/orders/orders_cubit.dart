import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/orders/data/models/order_model.dart';
import 'package:crm/features/orders/data/models/order_params.dart';
import 'package:crm/features/orders/data/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';


enum OrdersMode { all, current }

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repository, this._networkInfo) : super(OrdersLoading());

  final OrderRepository repository;
  final NetworkInfo _networkInfo;

  List<OrderModel> _orders = [];
  bool canLoad = true;

  final List<OrderModel> _currentOrders = [];
  bool _canLoadCurrent = true;

  int isStageSelected = 0;
  String? selectedStage;

  OrdersMode _mode = OrdersMode.all;

  bool get isCurrentMode => _mode == OrdersMode.current;

  void setStage({required int index, required String? stage}) {
    isStageSelected = index;
    selectedStage = stage;
  }

  void getAllOrders(OrderParams params) async {
    _mode = OrdersMode.all;

    final bool hasInternet = await _networkInfo.isConnected;

    if (!hasInternet && _orders.isNotEmpty) {
      canLoad = false;
      // return;
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
        if (params.page == 1) {
          _orders = data;
        } else {
          final existingIds = _orders.map((c) => c.id).toSet();
          final newItems = data
              .where((c) => !existingIds.contains(c.id))
              .toList();

          _orders.addAll(newItems);
        }

        canLoad = data.isNotEmpty;
        emit(OrdersLoaded(_orders));
      },
    );
  }

  void getCurrentOrders(int page) async {
    _mode = OrdersMode.current;

    final result = await repository.getCurrentOrders(page);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(OrdersConnectionError());
        } else {
          emit(OrdersError());
        }
      },
      (data) {
        if (page == 1) {
          _currentOrders
            ..clear()
            ..addAll(data);
        } else {
          final existingIds = _currentOrders.map((c) => c.id).toSet();
          final newItems = data.where((c) => !existingIds.contains(c.id)).toList();
          _currentOrders.addAll(newItems);
        }

        _canLoadCurrent = data.isNotEmpty;

        // keep your existing canLoad field working in UI
        canLoad = _canLoadCurrent;

        emit(OrdersLoaded(_currentOrders));      },
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
        // emit(OrdersLoaded(_orders));
        if (_mode == OrdersMode.current) {
          emit(OrdersLoaded(_currentOrders));
        } else {
          emit(OrdersLoaded(_orders));
        }
      },
    );
  }

  void updateOrderStageLocally(OrderModel updatedOrder) {
    void replaceIn(List<OrderModel> list) {
      final index = list.indexWhere((o) => o.id == updatedOrder.id);
      if (index != -1) list[index] = updatedOrder;
    }

    replaceIn(_orders);
    replaceIn(_currentOrders);

    // keep current screen consistent
    emit(OrdersLoaded(_mode == OrdersMode.current ? _currentOrders : _orders));
  }
  // void updateOrderStageLocally(OrderModel updatedOrder) {
  //   if (state is OrdersLoaded) {
  //     final currentOrders = List<OrderModel>.from((state as OrdersLoaded).data);
  //
  //     final index = currentOrders.indexWhere((o) => o.id == updatedOrder.id);
  //     if (index != -1) {
  //       currentOrders[index] = updatedOrder;
  //       emit(OrdersLoaded(currentOrders));
  //     }
  //   }
  // }

  void updateOrderStage(String stage, int orderId) async {
    final result = await repository.editOrderStage(stage, orderId);

    result.fold((error) {}, (data) {
      updateOrderStageLocally(data);
    });
  }
}
