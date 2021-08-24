import '../../../api.dart' as api;

class SpanId implements api.SpanId {
  List<int> _id;

  SpanId(this._id);
  SpanId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateSpanId();
  }
  SpanId.fromString(String id) {
    _id = [];
    id = id.padLeft(api.SpanId.SIZE_BITS, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  factory SpanId.invalid() => SpanId(api.SpanId.INVALID);
  factory SpanId.root() => SpanId(api.SpanId.ROOT);

  @override
  List<int> get() => _id;

  @override
  bool get isValid => _id.join() != api.SpanId.INVALID.join();

  @override
  String toString() =>
      _id.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
