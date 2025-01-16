abstract class ReportProductState {}

class ReportProductInitial extends ReportProductState {}

class ReportProductIsValid extends ReportProductState {}

class ReportProductSerialNumberIsNotValid extends ReportProductState {
  final String error;
  ReportProductSerialNumberIsNotValid(this.error);
}

class ReportProductProductNameIsNotValid extends ReportProductState {
  final String error;
  ReportProductProductNameIsNotValid(this.error);
}

class ReportProductIsLoading extends ReportProductState {}

class ReportProductIsNotValid extends ReportProductState {}

class ReportProductIsError extends ReportProductState {
  final String error;
  ReportProductIsError(this.error);
}
