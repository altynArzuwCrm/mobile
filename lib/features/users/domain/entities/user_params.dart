class UserParams {
  final int? page;
  final String? search;
  final String? sortBy;
  final String? sortOrder;
  final int perPage;
  final bool? isActive;

  const UserParams({
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

class CreateUserParams {
  final int? id;
  final String? name;
  final String? username;
  final String? password;
  final String? phone;
  final bool? isActive;
  final List<int>? roles;

  CreateUserParams({
    this.id,
    this.name,
    this.username,
    this.password,
    this.phone,
    this.isActive = true,
    this.roles = const [1, 2],
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    params['name'] = name;
    params['username'] = username?.trim();
    if (password != null) params['password'] = password?.trim();
    params['phone'] = phone;
    params['is_active'] = isActive;
    params['roles'] = roles;

    return params;
  }
}
