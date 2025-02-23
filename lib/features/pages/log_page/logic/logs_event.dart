import 'package:equatable/equatable.dart';

abstract class LogsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLogs extends LogsEvent {}

class SearchLogs extends LogsEvent {
  final String query;
  SearchLogs(this.query);
  @override
  List<Object> get props => [query];
}