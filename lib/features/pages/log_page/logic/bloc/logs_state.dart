import 'package:equatable/equatable.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';

abstract class LogsState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogsInitial extends LogsState {}

class LogsLoading extends LogsState {}

class LogsLoadingSuccess extends LogsState {
  final List<ScannedLogsProductModel> products;

  LogsLoadingSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class LogsError extends LogsState {
  final String message;
  LogsError(this.message);

  @override
  List<Object> get props => [message];
}
