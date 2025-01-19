part of 'hive_cubit.dart';

abstract class HiveState {}

class HiveDataIntial extends HiveState {
  
}

class HiveDataFetchingFromFireStore extends HiveState {}

class HiveDataFetchingFromFireStoreSuccess extends HiveState {}

class HiveDataFetchingFromFireStoreFailure extends HiveState {}

class HiveDataBaseDeleting extends HiveState {}

class HiveDataDeleteSuccess extends HiveState {}

class HiveDataDeleteFailure extends HiveState {}

class HiveDataBaseHasData extends HiveState {}

class HiveDataBaseEmpty extends HiveState {}
