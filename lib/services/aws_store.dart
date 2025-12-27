import 'dart:async';

class AwsStore {
  AwsStore._();

  static final AwsStore instance = AwsStore._();

  final Map<String, Map<String, Map<String, dynamic>>> _collections = {};
  final Map<String, StreamController<List<Map<String, dynamic>>>> _controllers = {};

  List<Map<String, dynamic>> list(String collection) {
    return _collections[collection]?.values.toList() ?? [];
  }

  Map<String, dynamic>? get(String collection, String id) {
    return _collections[collection]?[id];
  }

  String add(String collection, Map<String, dynamic> data) {
    final id = (data['id'] as String?) ?? DateTime.now().microsecondsSinceEpoch.toString();
    final collectionMap = _collections.putIfAbsent(collection, () => {});
    collectionMap[id] = {...data, 'id': id};
    _notify(collection);
    return id;
  }

  void set(String collection, String id, Map<String, dynamic> data) {
    final collectionMap = _collections.putIfAbsent(collection, () => {});
    collectionMap[id] = {...data, 'id': id};
    _notify(collection);
  }

  void update(String collection, String id, Map<String, dynamic> data) {
    final collectionMap = _collections.putIfAbsent(collection, () => {});
    final existing = collectionMap[id] ?? {};
    collectionMap[id] = {...existing, ...data, 'id': id};
    _notify(collection);
  }

  Stream<List<Map<String, dynamic>>> watch(String collection) {
    return _controller(collection).stream;
  }

  StreamController<List<Map<String, dynamic>>> _controller(String collection) {
    return _controllers.putIfAbsent(
      collection,
      () => StreamController<List<Map<String, dynamic>>>.broadcast(
        onListen: () => _notify(collection),
      ),
    );
  }

  void _notify(String collection) {
    if (!_controllers.containsKey(collection)) {
      return;
    }
    final controller = _controllers[collection];
    if (controller == null || controller.isClosed) {
      return;
    }
    controller.add(list(collection));
  }
}
