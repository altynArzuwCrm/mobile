import 'package:crm/core/error/failure.dart';
import 'package:crm/core/network/network.dart';
import 'package:crm/features/products/data/models/product_model.dart';
import 'package:crm/features/products/data/models/product_params.dart';
import 'package:crm/features/products/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repository, this._networkInfo) : super(ProductsLoading());

  final ProductRepository repository;

  final NetworkInfo _networkInfo;

  List<ProductModel> _products = [];
  bool canLoad = true;

  Future<void> getAllProducts(ProductParams params) async {
    final bool hasInternet = await _networkInfo.isConnected;

    if (!hasInternet && _products.isNotEmpty) {
      canLoad = false;
      return;
    } else if (hasInternet) {
      canLoad = true;
    }

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
        canLoad = data.isNotEmpty;
        if (params.page == 1) {
          _products = data;
        } else {
          final existingIds = _products.map((c) => c.id).toSet();
          final newItems = data
              .where((c) => !existingIds.contains(c.id))
              .toList();
          _products.addAll(newItems);
        }
        canLoad = data.isNotEmpty;
        emit(ProductsLoaded(_products));
      },
    );
  }

  void deleteProduct(int id) async {
    final result = await repository.deleteProduct(id);

    result.fold((error) {}, (data) {
      if (data) {
        _products.removeWhere((p) => p.id == id);

        emit(ProductsLoaded(List<ProductModel>.from(_products)));
      }
    });
  }

  void createProduct(CreateProductParams params) async {
    final result = await repository.createProduct(params);

    result.fold((error) {}, (data) {
      _products.insert(0,data);
      emit(ProductsLoaded(List<ProductModel>.from(_products)));
    });
  }
}
