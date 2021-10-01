import 'package:opentelemetry/api.dart';
import 'package:test/test.dart';

void main() {
  // test('attach and detach sets current context', () {
  //   final testKey = Context.createKey('Attach Key');

  //   final parentContext = Context.current;
  //   final parentScope = Context.attach(parentContext);
  //   expect(Context.current, same(parentContext));

  //   final childContext = parentContext.setValue(testKey, 'foo');
  //   final childScope = Context.attach(childContext);
  //   expect(Context.current, same(childContext));

  //   // assert noop scopes do not change .current
  //   final nullScope = Context.attach(null);
  //   expect(Context.current, same(childContext));
  //   childContext.detach(nullScope);
  //   expect(Context.current, same(childContext));

  //   // assert attaching to same context is a no-op
  //   final sameScope = Context.attach(childContext);
  //   expect(Context.current, same(childContext));
  //   childContext.detach(sameScope);
  //   expect(Context.current, same(childContext));

  //   // assert .current resets to the parentContext
  //   childContext.detach(childScope);
  //   expect(Context.current, same(parentContext));

  //   parentContext.detach(parentScope);
  //   // context.current is null, so .current creates a new one
  //   expect(Context.current, allOf([isNot(parentContext), isNot(childContext)]));
  // });

  test('setValue and getValue', () {
    final testKey = Context.createKey('Set Key');

    final parentContext = Context.current;
    final childContext = parentContext.setValue(testKey, 'bar');
    expect(parentContext.getValue(testKey), isNull);
    expect(childContext.getValue(testKey), equals('bar'));
  });

  test('execute runs sync fn', () {
    expect(Context.current.execute(() => 42), equals(42));
  });

  test('execute runs async fn', () async {
    expect(await Context.current.execute(() async => 42), equals(42));
  });
}
