import 'package:equatable/equatable.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';

abstract class LogsState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogsInitial extends LogsState {}

class LogsLoading extends LogsState {}

class LogsLoadingSuccess extends LogsState {
  final List<HiveProductModel> products;

  LogsLoadingSuccess(result, {required this.products});

  @override
  List<Object> get props => [products];
}

class LogsError extends LogsState {
  final String message;
  LogsError(this.message);

  @override
  List<Object> get props => [message];
}
