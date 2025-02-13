part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchStateInit extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> products;

  SearchSuccess({required this.products});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}