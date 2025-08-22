class OrderStatModel {
  final StatOrdersByStage ordersByStage;
  final List<OrdersByUser> ordersByUser;
  final int closedCount;
  final int delayedAssignments;
  final List<DelayedAssignmentsList> delayedAssignmentsList;
  final int totalOrders;
  final int completedOrders;
  final int cancelledOrders;
  final int percentCompleted;
  final int percentCancelled;
  final bool isEmployeeView;

  OrderStatModel({
    required this.ordersByStage,
    required this.ordersByUser,
    required this.closedCount,
    required this.delayedAssignments,
    required this.delayedAssignmentsList,
    required this.totalOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.percentCompleted,
    required this.percentCancelled,
    required this.isEmployeeView,
  });

  factory OrderStatModel.fromJson(Map<String, dynamic> json) => OrderStatModel(
    ordersByStage: StatOrdersByStage.fromJson(json["orders_by_stage"]),
    ordersByUser: List<OrdersByUser>.from(
      json["orders_by_user"].map((x) => OrdersByUser.fromJson(x)),
    ),
    closedCount: json["closed_count"],
    delayedAssignments: json["delayed_assignments"],
    delayedAssignmentsList: List<DelayedAssignmentsList>.from(
      json["delayed_assignments_list"].map(
        (x) => DelayedAssignmentsList.fromJson(x),
      ),
    ),
    totalOrders: json["total_orders"],
    completedOrders: json["completed_orders"],
    cancelledOrders: json["cancelled_orders"],
    percentCompleted: json["percent_completed"],
    percentCancelled: json["percent_cancelled"],
    isEmployeeView: json["is_employee_view"],
  );


}

class DelayedAssignmentsList {
  final int id;
  final String userName;
  final int orderId;
  final String orderStage;
  final String status;

  DelayedAssignmentsList({
    required this.id,
    required this.userName,
    required this.orderId,
    required this.orderStage,
    required this.status,
  });

  factory DelayedAssignmentsList.fromJson(Map<String, dynamic> json) =>
      DelayedAssignmentsList(
        id: json["id"],
        userName: json["user_name"],
        orderId: json["order_id"],
        orderStage: json["order_stage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "order_id": orderId,
    "order_stage": orderStage,
    "status": status,
  };
}

class StatOrdersByStage {
  final Map<String, int> ordersByStage;

  StatOrdersByStage({required this.ordersByStage});

  factory StatOrdersByStage.fromJson(Map<String, dynamic> json) {
    final orders = Map<String, int>.from(json);
    return StatOrdersByStage(ordersByStage: orders);
  }
}


class OrdersByUser {
  final int userId;
  final String userName;
  final int total;
  final List<StatOrder> orders;

  OrdersByUser({
    required this.userId,
    required this.userName,
    required this.total,
    required this.orders,
  });

  factory OrdersByUser.fromJson(Map<String, dynamic> json) => OrdersByUser(
    userId: json["user_id"],
    userName: json["user_name"],
    total: json["total"],
    orders: List<StatOrder>.from(json["orders"].map((x) => StatOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "total": total,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class StatOrder {
  final int id;
  final String productName;
  final String stage;
  final String status;

  StatOrder({
    required this.id,
    required this.productName,
    required this.stage,
    required this.status,
  });

  factory StatOrder.fromJson(Map<String, dynamic> json) => StatOrder(
    id: json["id"],
    productName: json["product_name"],
    stage: json["stage"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "stage": stage,
    "status": status,
  };
}
