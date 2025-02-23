import 'package:equatable/equatable.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';

abstract class LogsState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogsLoading extends LogsState {}

class LogsLoaded extends LogsState {
  final List<HiveProductModel> logs;
  LogsLoaded(this.logs);
  @override
  List<Object> get props => [logs];
}