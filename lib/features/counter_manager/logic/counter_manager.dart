import "dart:async";
import "package:shared_preferences/shared_preferences.dart";

class CounterManger {
  
  static const String counterKey = 'scanCounter';
  static final StreamController<int> _counterController =
      StreamController<int>.broadcast(onListen: initializeCounter);
  static final bool _isClosed = false;

  static Stream<int> get counterStream => _counterController.stream;

  /// This function is called when a stream is added to the stream controller.
  /// It retrieves the current counter from the shared preferences and adds it
  /// to the stream controller.
  static Future<void> initializeCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt(counterKey) ?? 0;
    if (!_isClosed) {
      _counterController.add(counter);
    }
  }

  /// Retrieves the current counter from the shared preferences and returns it
  /// as a future. If there is no stored counter, it returns 0.
  static Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt(counterKey) ?? 0;
    return counter;
  }

  /// Increment the counter in the shared preferences by one and broadcast the
  /// new value on the stream. If the counter has not been initialized yet, it
  /// will be set to 1. If the counter has been initialized, it is incremented
  /// by one and the new value is broadcasted on the stream.
  ///
  /// This function is idempotent. If the counter has already been incremented
  /// before, it will not be incremented again. If the counter is reset while
  /// this function is pending, the new value will be broadcasted on the stream
  /// and the counter will be reset to 0.
  static Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCounter = prefs.getInt(counterKey) ?? 0;
    currentCounter++;
    await prefs.setInt(counterKey, currentCounter);
    if (!_isClosed) {
      _counterController.add(currentCounter);
    }
  }

  /// Resets the counter in the shared preferences to zero and broadcasts the
  /// new value on the stream. If the stream is closed, the new value is not
  /// added to the stream.

  static Future<void> resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(counterKey, 0);
    if (!_isClosed) {
      _counterController.add(0);
    }
  }
}
