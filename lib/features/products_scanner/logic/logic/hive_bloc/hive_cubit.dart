import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';

part 'hive_state.dart';

class LocalDBCubit extends Cubit<LocalDBState> {
  LocalDBCubit() : super(HiveDataIntial());

  Future<void> fetchDataFromFireStore() async {
    emit(HiveDataFetchingFromFireStore());
    try {
      await ObjectboxRepositories().syncAllProductsToLocalDB();
      emit(HiveDataFetchingFromFireStoreSuccess());
    } catch (e) {
      emit(HiveDataFetchingFromFireStoreFailure());
    }
  }

  Future<void> updateDataBaseFromFireStore() async {
    emit(HiveDataFetchingFromFireStore());
    try {
      await ObjectboxRepositories().syncAllProductsToLocalDB();
      emit(HiveDataFetchingFromFireStoreSuccess());
    } catch (e) {
      emit(HiveDataFetchingFromFireStoreFailure());
    }
  }

  Future<void> deleteAllLocalProducts() async {
    emit(HiveDataBaseDeleting());
    try {
      await ObjectboxRepositories().deleteAllTadamonProductsFromLocalDB();
            emit(HiveDataDeleteSuccess());
    } catch (e) {
      emit(HiveDataDeleteFailure());
    }
  }

  Future<bool> hiveHasData() async {
     bool hasData = await ObjectboxRepositories().tadamonProductsBoxHasData();
    if (hasData) {
    emit(HiveDataBaseHasData());
    return true;
       } else {
       emit(HiveDataBaseEmpty());
    return false;
    }
  }
}
