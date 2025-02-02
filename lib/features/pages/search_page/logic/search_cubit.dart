import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';
import 'package:tadamon/features/products_scanner/data/repository/hive_services.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchStateInit());

  Future<void> searchOnFireStore(String query) async {
    emit(SearchStateLoading());
    try {
      final products = await FireStoreServices().search(query);
      emit(SearchStateLoadingSuccess(products: products));
    } catch (e) {
      emit(SearchStateLoadingError(errorMessage: e.toString()));
    }
  }

  Future<void> searchOnHive(String query) async {
    emit(SearchStateLoading());
    try {
      final products = await HiveServices().search(query);
      emit(SearchStateLoadingSuccess(products: products));
    } catch (e) {
      emit(SearchStateLoadingError(errorMessage: e.toString()));
    }
  }
}