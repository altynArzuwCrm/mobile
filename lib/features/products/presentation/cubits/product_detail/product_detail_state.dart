part of 'product_detail_cubit.dart';

@immutable
sealed class ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}
final class ProductDetailLoaded extends ProductDetailState {
  final ProductModel data;

  ProductDetailLoaded(this.data);
}
final class ProductDetailError extends ProductDetailState {}
