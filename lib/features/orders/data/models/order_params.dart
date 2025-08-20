import 'package:crm/features/assignments/data/models/assign_order_params.dart';

class OrderParams {
  final int? page;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final int perPage;
  final bool? isActive;
  final String? stage;
  final String? status;

  const OrderParams({
    this.page,
    this.search,
    this.sortBy,
    this.sortOrder,
    this.perPage = 30,
    this.isActive,
    this.stage,
    this.status,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    if (page != null) params['page'] = page;
    if (search != null) params['search'] = search?.trim();
    if (sortBy != null) params['sort_by'] = sortBy;
    if (sortOrder != null) params['sort_order'] = sortOrder;
    if (isActive != null) params['is_active'] = isActive;
    if (stage != null) params['stage'] = stage;
    if (status != null) params['assignment_status'] = status;
    params['per_page'] = perPage;

    return params;
  }
}

class CreateOrderParams {
  final int? id;
  final String? title;
  final String? description;
  final String? stage;
  final int? clientId;
  final int? projectId;
  final int? productId;
  final int? quantity;
  final int? price;
  final DateTime? deadline;
  final List<AssignOrderParams>? assignments;
  final List<MultipleProductParams>? products;

  CreateOrderParams({
    this.id,

    this.title,
    this.description,
    this.stage,
    this.clientId,
    this.projectId,
    this.productId,
    this.quantity,
    this.price,
    this.deadline,
    this.assignments,
    this.products,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['title'] = title;
    params['description'] = description;
    params['stage'] = stage;
    params['client_id'] = clientId;
    params['project_id'] = projectId;
    params['product_id'] = productId;
    params['quantity'] = quantity;
    params['price'] = price;
    params['deadline'] = deadline?.toIso8601String();
    params['assignments'] =
        assignments?.map((e) => e.toQueryParameters()).toList() ?? [];
    params['products'] =
        products?.map((e) => e.toQueryParameters()).toList() ?? [];

    return params;
  }
}

class MultipleProductParams {
  final String productName;
  final int quantity;
  final int price;
  final DateTime? deadline;

  MultipleProductParams({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.deadline,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['product_name'] = productName;
    params['quantity'] = quantity;
    params['price'] = price;
    params['deadline'] = deadline?.toIso8601String();

    return params;
  }
}

class CommentParams {
  final int orderId;
  final String text;

  CommentParams({required this.orderId, required this.text});

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['order_id'] = orderId;
    params['text'] = text;

    return params;
  }
}
