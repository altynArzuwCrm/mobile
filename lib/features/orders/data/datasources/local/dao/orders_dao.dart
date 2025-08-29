import 'package:crm/features/orders/data/datasources/local/entity/order_local_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class OrderDao {
  @Query('SELECT * FROM orders ORDER BY updatedAt DESC')
  Future<List<OrderLocalEntity>> getAllOrders();

  @Query('SELECT * FROM orders WHERE id = :id')
  Future<OrderLocalEntity?> getOrderById(int id);

  @insert
  Future<void> insertOrder(OrderLocalEntity order);

  @insert
  Future<void> insertOrders(List<OrderLocalEntity> orders);

  @update
  Future<void> updateOrder(OrderLocalEntity order);

  @delete
  Future<void> deleteOrder(OrderLocalEntity order);

  @Query('DELETE FROM orders')
  Future<void> clearOrders();
}
