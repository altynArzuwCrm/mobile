class OrderParams {
  final int? page;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final int perPage;
  final bool? isActive;

  const OrderParams({
    this.page,
    this.search,
    this.sortBy,
    this.sortOrder,
    this.perPage = 30,
    this.isActive,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    if (page != null) params['page'] = page;
    if (search != null) params['search'] = search?.trim();
    if (sortBy != null) params['sort_by'] = sortBy;
    if (sortOrder != null) params['sort_order'] = sortOrder;
    if (isActive != null) params['is_active'] = isActive;
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
  final int? productId;
  final int? quantity;

  CreateOrderParams({
    this.title,
    this.description,
    this.stage,
    this.clientId,
    this.productId,
    this.quantity,
    this.id,
  }
  );

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['title'] = title;
    params['description'] = description;
    params['stage'] = stage;
    params['client_id'] = clientId;
    params['product_id'] = productId;
    params['quantity'] = quantity;

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
