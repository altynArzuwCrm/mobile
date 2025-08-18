import 'package:crm/core/error/failure.dart';
import 'package:crm/features/products/data/models/product_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repository) : super(ProductsLoading());

  final ProductRepository repository;

  Future<void> getAllProducts(ProductParams params) async {
    emit(ProductsLoading());

    final result = await repository.getAllProducts(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(ProductsConnectionError());
        } else {
          emit(ProductsError());
        }
      },
      (data) {
        emit(ProductsLoaded(data));
      },
    );
  }
}
