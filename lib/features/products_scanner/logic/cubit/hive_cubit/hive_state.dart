part of 'hive_cubit.dart';

abstract class LocalDBState {}

class HiveDataIntial extends LocalDBState {
  
}

class HiveDataFetchingFromFireStore extends LocalDBState {}

class HiveDataFetchingFromFireStoreSuccess extends LocalDBState {}

class HiveDataFetchingFromFireStoreFailure extends LocalDBState {}

class HiveDataBaseDeleting extends LocalDBState {}

class HiveDataDeleteSuccess extends LocalDBState {}

class HiveDataDeleteFailure extends LocalDBState {}

class HiveDataBaseHasData extends LocalDBState {}

class HiveDataBaseEmpty extends LocalDBState {}
