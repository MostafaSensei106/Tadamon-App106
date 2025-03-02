import 'package:tadamon/objectbox.g.dart';

class ObjectBoxService {
  static ObjectBoxService? _instance;
  late final Store _store;

  ObjectBoxService._create(this._store);

  static  Future<ObjectBoxService> intit() async {
    if (_instance == null) {
      final store = await openStore();
      _instance = ObjectBoxService._create(store);
    }
    return _instance!;
  }

  Store get store => _store;

}