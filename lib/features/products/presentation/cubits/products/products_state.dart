part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductModel> data;

  ProductsLoaded(this.data);
}

final class ProductsConnectionError extends ProductsState {}

final class ProductsError extends ProductsState {}
