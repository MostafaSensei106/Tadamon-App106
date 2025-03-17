import 'package:equatable/equatable.dart';

abstract class PdfExportState extends Equatable {
  const PdfExportState();

  @override
  List<Object> get props => [];
}

class PdfExportInitial extends PdfExportState {}

class PdfExportLoading extends PdfExportState {}

class PdfExportSuccess extends PdfExportState {}

class PdfExportError extends PdfExportState {}
