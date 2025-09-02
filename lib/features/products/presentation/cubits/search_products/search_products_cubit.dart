import 'package:crm/core/error/failure.dart';
import 'package:crm/features/products/data/models/product_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  SearchProductsCubit(this.repository) : super(SearchProductsInitial());

  final ProductRepository repository;

  final List<ProductModel> _products = [];

  void initializeSearch() {
    emit(SearchProductsInitial());
  }

  void searchProducts(ProductParams params) async {
    _products.clear();
    emit(SearchProductsLoading());

    final result = await repository.getAllProducts(params);

    result.fold(
      (error) {
        if (error is ConnectionFailure) {
          emit(SearchProductsConnectionError());
        } else {
          emit(SearchProductsError());
        }
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchNotFoundedProducts());
        } else {
          _products.addAll(data);
          emit(SearchFoundedProducts(List.from(_products)));
        }
      },
    );
  }

  void deleteProduct(int id) {
    _products.removeWhere((e) => e.id == id);
    emit(SearchFoundedProducts(List.from(_products)));
  }
}
