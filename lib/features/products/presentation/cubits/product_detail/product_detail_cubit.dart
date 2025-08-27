import 'package:crm/features/products/data/models/product_model.dart';
import 'package:crm/features/products/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this.repository) : super(ProductDetailLoading());

  final ProductRepository repository;

  void getProductDetail(int id) async {
    emit(ProductDetailLoading());
    final result = await repository.getProductById(id);

    result.fold(
      (error) {
        emit(ProductDetailError());
      },
      (data) {
        emit(ProductDetailLoaded(data));
      },
    );
  }
}
