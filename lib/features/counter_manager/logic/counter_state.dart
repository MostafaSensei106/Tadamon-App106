class CounterState {
  final int objectBoxCount;
  final int firebaseCount;

  CounterState({required this.objectBoxCount, required this.firebaseCount});

  CounterState copyWith({int? objectBoxCount, int? firebaseCount}) {
    return CounterState(
      objectBoxCount: objectBoxCount ?? this.objectBoxCount,
      firebaseCount: firebaseCount ?? this.firebaseCount,
    );
  }
}
