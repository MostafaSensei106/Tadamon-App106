import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(super.initialState);

  Future<void> search(String query) async {
    emit(SearchStateLoading());

    try {
      emit(SearchStateLoadingSuccess(
        products: await FireStoreServices().search(query),
      ));
    } catch (e) {
      emit(SearchStateLoadingError());
    }

  }

}
