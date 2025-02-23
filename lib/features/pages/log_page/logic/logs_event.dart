import 'package:equatable/equatable.dart';

abstract class LogsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLogsResult extends LogsEvent {
  final String query, filter;

  GetLogsResult(this.query, this.filter);

  @override
  List<Object> get props => [query, filter];
}