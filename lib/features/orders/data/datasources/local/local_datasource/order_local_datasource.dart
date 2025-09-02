import 'dart:developer';

import 'package:crm/features/orders/data/datasources/local/dao/orders_dao.dart';
import 'package:crm/features/orders/data/datasources/local/entity/order_local_entity.dart';
import 'package:crm/features/orders/data/models/order_params.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderLocalEntity>?> getAllOrders(OrderParams params);

  Future<OrderLocalEntity?> getOrderById(int id);

  Future<void> insertOrders(List<OrderLocalEntity> orders);

  Future<void> updateOrder(OrderLocalEntity order);

  Future<void> deleteOrder(OrderLocalEntity order);

  Future<void> clearOrders();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final OrderDao _dao;

  OrderLocalDataSourceImpl(this._dao);

  @override
  Future<void> clearOrders() async {
    await _dao.clearOrders();
  }

  @override
  Future<void> deleteOrder(OrderLocalEntity order) async {
    await _dao.deleteOrder(order);
  }

  @override
  Future<List<OrderLocalEntity>?> getAllOrders(OrderParams params) async {
    final localData = await getFilteredOrders(
      keyword: params.search,
      stage: params.stage,
      sortOrder: params.sortOrder,
      sortBy: params.sortBy,
    );

    return localData;
  }


  Future<List<OrderLocalEntity>> getFilteredOrders({
    String? keyword,
    String? stage,
    String? sortOrder,
    String? sortBy,
  }) async {
    final allOrders = await _dao.getAllOrders();

    if (allOrders.isEmpty) return [];

    // --- Filtering ---
    List<OrderLocalEntity> filteredOrders = allOrders.where((o) {
      final matchesKeyword = keyword == null || keyword.isEmpty
          ? true
          : (o.project?.title.toLowerCase().contains(keyword.toLowerCase()) ?? false);

      final matchesStage = stage == null || stage.isEmpty
          ? true
          : (o.stage?.name.toLowerCase().contains(stage.toLowerCase()) ?? false);

      return matchesKeyword && matchesStage;
    }).toList();

    // --- Sorting ---
    if (sortBy != null) {
      log('------sort--------');
      filteredOrders.sort((a, b) {
        int result = 0;

        switch (sortBy) {
          case 'name':
            final titleA = a.project?.title ?? '';
            final titleB = b.project?.title ?? '';
            result = titleA.compareTo(titleB);
            log('------name--------');

            break;

          case 'created_at':
            final createdA = a.createdAt != null
                ? DateTime.tryParse(a.createdAt) ?? DateTime(1970)
                : DateTime(1970);

            final createdB = b.createdAt != null
                ? DateTime.tryParse(b.createdAt) ?? DateTime(1970)
                : DateTime(1970);

            result = createdA.compareTo(createdB);
            log('------created_at--------');

            break;


          case 'deadline':
            final deadlineA = a.deadline.isNotEmpty
                ? DateTime.tryParse(a.deadline) ?? DateTime(2100)
                : DateTime(2100);

            final deadlineB = b.deadline.isNotEmpty
                ? DateTime.tryParse(b.deadline) ?? DateTime(2100)
                : DateTime(2100);

            result = deadlineA.compareTo(deadlineB);
            log('------deadline--------');
            break;


          default:
          // fallback to name
            final titleA = a.project?.title ?? '';
            final titleB = b.project?.title ?? '';
            result = titleA.compareTo(titleB);
        }

        if (sortOrder != null && sortOrder.toLowerCase().contains('desc')) {
          result = -result; // reverse for descending
          log('------desc--------');

        }

        return result;
      });
    } else {
      log('------filteredOrders-- title ascending------');

      // Default sort by project title ascending
      filteredOrders.sort((a, b) {
        final titleA = a.project?.title ?? '';
        final titleB = b.project?.title ?? '';
        return titleA.compareTo(titleB);
      });
    }

    return filteredOrders;
  }



  // Future<List<OrderLocalEntity>> getFilteredOrders({
  //   String? keyword,
  //   String? stage,
  //   String? sortOrder,
  //   String? sortBy,
  // }) async {
  //   final allOrders = await _dao.getAllOrders();
  //
  //   if (allOrders.isEmpty) return [];
  //
  //   // Filter
  //   List<OrderLocalEntity> filteredOrders = allOrders.where((o) {
  //     final matchesKeyword = keyword == null || keyword.isEmpty
  //         ? true
  //         : (o.project?.title.toLowerCase().contains(keyword.toLowerCase()) ??
  //               false);
  //
  //     final matchesStage = stage == null || stage.isEmpty
  //         ? true
  //         : (o.stage?.name.toLowerCase().contains(stage.toLowerCase()) ??
  //               false);
  //
  //     return matchesKeyword && matchesStage;
  //   }).toList();
  //
  //   // Sort
  //   if (sortOrder != null) {
  //     filteredOrders.sort((a, b) {
  //       final titleA = a.project?.title ?? '';
  //       final titleB = b.project?.title ?? '';
  //
  //       int result = titleA.compareTo(titleB);
  //
  //       if (sortOrder.toLowerCase().contains('desc')) {
  //         result = -result; // reverse for descending
  //       }
  //
  //       return result;
  //     });
  //   } else {
  //     // Default sort by project title ascending
  //     filteredOrders.sort((a, b) {
  //       final titleA = a.project?.title ?? '';
  //       final titleB = b.project?.title ?? '';
  //       return titleA.compareTo(titleB);
  //     });
  //   }
  //
  //   return filteredOrders;
  // }

  @override
  Future<OrderLocalEntity?> getOrderById(int id) async {
    return await _dao.getOrderById(id);
  }

  @override
  Future<void> insertOrders(List<OrderLocalEntity> orders) async {
    await _dao.insertOrders(orders);
  }

  @override
  Future<void> updateOrder(OrderLocalEntity order) async {
    await _dao.updateOrder(order);
  }
}
