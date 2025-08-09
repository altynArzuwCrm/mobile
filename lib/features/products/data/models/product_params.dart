class ProductParams {
  final int? page;
  final String? search;
  final String? sortBy;
  final String? sortProduct;
  final int perPage;
  final bool? isActive;

  const ProductParams({
    this.page,
    this.search,
    this.sortBy,
    this.sortProduct,
    this.perPage = 30,
    this.isActive,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    if (page != null) params['page'] = page;
    if (search != null) params['search'] = search?.trim();
    if (sortBy != null) params['sort_by'] = sortBy;
    if (sortProduct != null) params['sort_order'] = sortProduct;
    if (isActive != null) params['is_active'] = isActive;
    params['per_page'] = perPage;

    return params;
  }
}