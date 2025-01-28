
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

abstract class SearchState {}

class SearchStateInit extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateLoadingSuccess extends SearchState {
  final List<ProductModel> products;
  SearchStateLoadingSuccess(this.products, {required List<ProductModel> products});
}

class SearchStateLoadingError extends SearchState {}