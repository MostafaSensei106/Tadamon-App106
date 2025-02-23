import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_event.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_state.dart';
import 'package:tadamon/features/products_scanner/data/repository/hive_services.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final HiveServices repository;

  LogsBloc(this.repository) : super(LogsInitial()) {
    on<GetLogsResult>(_onFeatchSearchResult);
  }

  void _onFeatchSearchResult(
      GetLogsResult event, Emitter<LogsState> emit) async {
    emit(LogsLoading());
    try {
      final products = await repository.getLogs();
      emit(LogsLoadingSuccess([], products: products));
    } catch (e) {
      emit(LogsError(e.toString()));
    }
  }
}
