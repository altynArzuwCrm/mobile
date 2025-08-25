part of 'search_products_cubit.dart';

sealed class SearchProductsState {}

final class SearchProductsInitial extends SearchProductsState {}


final class SearchProductsLoading extends SearchProductsState {}

final class SearchFoundedProducts extends SearchProductsState {
  final List<ProductModel> data;

  SearchFoundedProducts(this.data);
}

final class SearchNotFoundedProducts extends SearchProductsState {}

final class SearchProductsConnectionError extends SearchProductsState {}

final class SearchProductsError extends SearchProductsState {}