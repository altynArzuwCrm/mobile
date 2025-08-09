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
  final String name;
  final String? password;
  final String phone;
  final bool isActive;
  final List<int> roles;

  CreateOrderParams(
      this.name,
      this.password,
      this.phone,
      this.isActive,
      this.roles,
      );

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['name'] = name;
    if (password != null) params['password'] = password?.trim();
    params['phone'] = phone;
    params['is_active'] = isActive;
    params['roles'] = roles;

    return params;
  }
}
