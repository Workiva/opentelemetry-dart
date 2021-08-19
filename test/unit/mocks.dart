import 'package:mockito/mockito.dart';
import 'package:opentelemetry/src/api/context/context.dart';
import 'package:opentelemetry/src/api/trace/span.dart';
import 'package:opentelemetry/src/sdk/trace/exporters/span_exporter.dart';
import 'package:opentelemetry/src/sdk/trace/span_processors/span_processor.dart';

class MockContext extends Mock implements Context {}
class MockSpan extends Mock implements Span {}
class MockSpanExporter extends Mock implements SpanExporter {}
class MockSpanProcessor extends Mock implements SpanProcessor {}
