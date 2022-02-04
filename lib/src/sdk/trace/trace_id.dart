import '../../../api.dart' as api;

class TraceId implements api.TraceId {
  List<int> _id;

  TraceId(this._id);
  TraceId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateTraceId();
  }
  TraceId.fromString(String id) {
    _id = [];
    id = id.padLeft(api.TraceId.sizeBits, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  TraceId.invalid() : this(api.TraceId.invalid);

  @override
  List<int> get() => _id;

  @override
  bool get isValid => _id.join() != api.TraceId.invalid.join();

  @override
  String toString() =>
      _id.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
