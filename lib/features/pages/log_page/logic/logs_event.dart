import 'package:equatable/equatable.dart';

abstract class LogsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllLogs extends LogsEvent {}

class GetLogsResult extends LogsEvent {
  final String query; 
  final String filter;

  GetLogsResult(this.query, this.filter);

  @override
  List<Object> get props => [query, filter];
}