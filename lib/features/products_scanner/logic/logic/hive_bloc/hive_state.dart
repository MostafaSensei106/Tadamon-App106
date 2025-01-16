part of 'hive_cubit.dart';

abstract class HiveState {}

class HiveDataIntial extends HiveState {}

class HiveDataFetchingFromFireStore extends HiveState {}

class HiveDataFetchingFromFireStoreSuccess extends HiveState {}

class HiveDataNotFound extends HiveState {}
