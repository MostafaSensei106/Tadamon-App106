import "dart:async";
import "package:shared_preferences/shared_preferences.dart";

class CounterManger {
  static const String counterKey = 'scanCounter';
  static final StreamController<int> _counterController =
      StreamController<int>.broadcast(onListen: initializeCounter);
  static final bool _isClosed = false;

  static Stream<int> get counterStream => _counterController.stream;

  static Future<void> initializeCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt(counterKey) ?? 0;
    if (!_isClosed) {
      _counterController.add(counter);
    }
  }

  static Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt(counterKey) ?? 0;
    return counter;
  }

  static Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCounter = prefs.getInt(counterKey) ?? 0;
    currentCounter++;
    await prefs.setInt(counterKey, currentCounter);
    if (!_isClosed) {
      _counterController.add(currentCounter);
    }
  }

  static Future<void> resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(counterKey, 0);
    if (!_isClosed) {
      _counterController.add(0);
    }
  }
}
