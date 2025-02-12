import 'package:tadamon/features/products_scanner/data/models/product_model.dart';


abstract class SearchState {}

class SearchStateInit extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> products;
  SearchSuccess(List<Map<String, dynamic>> items, {required this.products});
}

class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}