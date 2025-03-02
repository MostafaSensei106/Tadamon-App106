import 'package:flutter_bloc/flutter_bloc.dart';

part 'hive_state.dart';

class HiveCubit extends Cubit<HiveState> {
  HiveCubit() : super(HiveDataIntial());

  Future<void> fetchDataFromFireStore() async {
    emit(HiveDataFetchingFromFireStore());
    try {
      //await HiveServices().syncAllProductsToHive();
      emit(HiveDataFetchingFromFireStoreSuccess());
    } catch (e) {
      emit(HiveDataFetchingFromFireStoreFailure());
    }
  }

  Future<void> updateDataBaseFromFireStore() async {
    emit(HiveDataFetchingFromFireStore());
    try {
      //await HiveServices().isLocalDataBaseUpToDate();
      emit(HiveDataFetchingFromFireStoreSuccess());
    } catch (e) {
      emit(HiveDataFetchingFromFireStoreFailure());
    }
  }

  Future<void> deleteAllLocalProducts() async {
    emit(HiveDataBaseDeleting());
    try {
      // await HiveServices().deleteAllLocalProducts();
      emit(HiveDataDeleteSuccess());
    } catch (e) {
      emit(HiveDataDeleteFailure());
    }
  }

  Future<bool> hiveHasData() async {
    // bool hasData = await HiveServices().hiveDbHasData();
    //if (hasData) {
    emit(HiveDataBaseHasData());
    return true;
    //   } else {
    //   emit(HiveDataBaseEmpty());
    // return false;
    //}
  }
}
