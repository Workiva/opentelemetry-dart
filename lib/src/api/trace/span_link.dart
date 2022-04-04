import '../../../api.dart' as api;

class SpanLink {
  final api.SpanContext _context;
  final api.Attributes _attributes;

  SpanLink(this._context, {api.Attributes attributes})
      : _attributes = attributes ?? api.Attributes.empty();

  api.Attributes get attributes => _attributes;

  api.SpanContext get context => _context;
}
