import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/products_scanner/data/repository/hive_services.dart';
import 'logs_event.dart';
import 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final HiveServices _hiveServices = HiveServices();

  LogsBloc() : super(LogsLoading()) {
    on<LoadLogs>((event, emit) async {
      final logs = await _hiveServices.getLogs();
      emit(LogsLoaded(logs));
    });

    on<SearchLogs>((event, emit) async {
      final logs = await _hiveServices.searchLogs(event.query);
      emit(LogsLoaded(logs));
    });
  }
}