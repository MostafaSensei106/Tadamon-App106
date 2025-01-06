import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PageChanged extends MainPageEvent {
  final int index;

  PageChanged(this.index);

  @override
  List<Object> get props => [index];
}
