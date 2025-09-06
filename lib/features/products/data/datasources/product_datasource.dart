import 'package:crm/core/constants/strings/endpoints.dart';
import 'package:crm/core/network/api_provider.dart';
import 'package:crm/features/products/data/models/product_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts(ProductParams params);

  Future<ProductModel> getProductById(int id);

  Future<ProductModel> createProduct(CreateProductParams params);

  Future<ProductModel> editProduct(ProductParams params);

  Future<bool> deleteProduct(int id);

  Future<List<ProductModel>> getProductStages(ProductParams params);

  Future<bool> editProductStage(ProductParams params);

  Future<List<ProductModel>> getProductAssignments(ProductParams params);

  Future<bool> createProductAssignment(ProductParams params);

  Future<bool> updateProductAssignment(ProductParams params);

  Future<bool> deleteProductAssignment(ProductParams params);

  Future<bool> bulkAssignProduct(ProductParams params);

  Future<List<ProductModel>> getAvailableUsersForProduct(ProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiProvider apiProvider;

  ProductRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<ProductModel>> getAllProducts(ProductParams params) async {
    final response = await apiProvider.get(
      endPoint: ApiEndpoints.products,
      query: params.toQueryParameters(),
    );

    final responseBody = response.data['data'] as List;

    final result = responseBody.map((e) => ProductModel.fromJson(e)).toList();

    return result;
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await apiProvider.get(
      endPoint: '${ApiEndpoints.products}/$id',
    );
    final result = response.data;

    return ProductModel.fromJson(result);
  }

  @override
  Future<ProductModel> createProduct(CreateProductParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.products,
      data: params.toQueryParameters(),
    );

    final productId = response.data['data']['id'];
    final result = await getProductById(productId);

    return result;
  }

  @override
  Future<ProductModel> editProduct(ProductParams params) async {
    final response = await apiProvider.put(
      endPoint: ApiEndpoints.products,
      data: params.toQueryParameters(),
    );
    final result = response.data;
    return ProductModel.fromJson(result);
  }

  @override
  Future<bool> deleteProduct(int id) async {
    final response = await apiProvider.delete(
      endPoint: '${ApiEndpoints.products}/$id',
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> editProductStage(ProductParams params) async {
    final response = await apiProvider.post(
      endPoint: ApiEndpoints.products,
      data: params.toQueryParameters(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> bulkAssignProduct(ProductParams params) async {
    // TODO: implement bulkAssignProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> createProductAssignment(ProductParams params) async {
    // TODO: implement createProductAssignment
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProductAssignment(ProductParams params) async {
    // TODO: implement deleteProductAssignment
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAvailableUsersForProduct(
    ProductParams params,
  ) async {
    // TODO: implement getAvailableUsersForProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProductAssignments(ProductParams params) async {
    // TODO: implement getProductAssignments
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProductStages(ProductParams params) async {
    // TODO: implement getProductStages
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProductAssignment(ProductParams params) async {
    // TODO: implement updateProductAssignment
    throw UnimplementedError();
  }
}
