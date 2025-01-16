import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/products_scanner/data/repository/hive_services.dart';
part 'hive_state.dart';


class HiveCubit extends Cubit<HiveState> {
  HiveCubit() : super(HiveDataIntial());

  Future<void> fetchDataFromFireStore() async {
    emit(HiveDataFetchingFromFireStore());
      try {
        await HiveServices().syncAllProductsToHive();
        emit(HiveDataFetchingFromFireStoreSuccess());
      } catch (e) {
        emit(HiveDataNotFound());
      }
  }
  
}