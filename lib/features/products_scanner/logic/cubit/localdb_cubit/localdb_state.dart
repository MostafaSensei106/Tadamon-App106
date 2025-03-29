part of 'localdb_cubit.dart';

abstract class LocalDBState {}

class LoclaDBDataIntial extends LocalDBState {}

class LoclaDBDataFetchingFromFireStore extends LocalDBState {}

class LoclaDBDataFetchingFromFireStoreSuccess extends LocalDBState {}

class LoclaDBDataFetchingFromFireStoreFailure extends LocalDBState {}

class LoclaDBDataBaseDeleting extends LocalDBState {}

class LoclaDBDataDeleteSuccess extends LocalDBState {}

class LoclaDBDataDeleteFailure extends LocalDBState {}

class LoclaDBDataBaseHasData extends LocalDBState {}

class LoclaDBDataBaseEmpty extends LocalDBState {}
