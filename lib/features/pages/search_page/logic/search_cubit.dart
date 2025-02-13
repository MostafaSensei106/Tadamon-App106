import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FireStoreServices _repository;

  SearchCubit(this._repository) : super(SearchStateInit());

  void searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchStateInit());
      return;
    }

    emit(SearchLoading());

    try {
      final results = await _repository.searchForProduct(query);
      if (results.isEmpty) {
        emit(SearchError(message: 'لم يتم العثور على نتائج'));
      } else {
        emit(SearchSuccess(products: results));
      }
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}