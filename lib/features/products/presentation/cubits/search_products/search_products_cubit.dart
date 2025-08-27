import 'package:bloc/bloc.dart';
import 'package:crm/core/error/failure.dart';
import 'package:crm/features/products/data/models/product_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/data/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  SearchProductsCubit(this.repository) : super(SearchProductsInitial());

  final ProductRepository repository;

  List<ProductModel> _products = [];

  void initializeSearch() {
    emit(SearchProductsInitial());
  }

  void searchProducts(ProductParams params) async {
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
          emit(SearchFoundedProducts(data));
        }
      },
    );
  }


  void deleteProduct(int id){
    _products.removeWhere((e)=> e.id == id);
    emit(SearchFoundedProducts(List.from(_products)));
  }

}
