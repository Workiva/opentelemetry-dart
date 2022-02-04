import '../../../api.dart' as api;

class SpanId implements api.SpanId {
  List<int> _id;

  SpanId(this._id);
  SpanId.fromIdGenerator(api.IdGenerator generator) {
    _id = generator.generateSpanId();
  }
  SpanId.fromString(String id) {
    _id = [];
    id = id.padLeft(api.SpanId.sizeBits, '0');

    for (var i = 0; i < id.length; i += 2) {
      _id.add(int.parse('${id[i]}${id[i + 1]}', radix: 16));
    }
  }
  SpanId.invalid() : this(api.SpanId.invalid);
  SpanId.root() : this(api.SpanId.root);

  @override
  List<int> get() => _id;

  @override
  bool get isValid => _id.join() != api.SpanId.invalid.join();

  @override
  String toString() =>
      _id.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}
