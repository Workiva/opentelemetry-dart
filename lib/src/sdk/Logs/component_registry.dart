import 'dart:collection';

/// Holds information about the instrumentation library specified when creating an instance of
/// TracerSdk using TracerProviderSdk.
class InstrumentationScopeInfo  {
  final String name;
  final String? version;
  final String? schemaUrl;

  ///  Creates a new empty instance of InstrumentationScopeInfo.

  ///  Creates a new instance of InstrumentationScopeInfo.
  ///  - Parameters:
  ///    - name: name of the instrumentation library
  ///    - version: version of the instrumentation library (e.g., "semver:1.0.0"), might be null
  InstrumentationScopeInfo({
    required this.name,
    this.version,
    this.schemaUrl,
  });

  @override
  List<Object?> get props => [name, version, schemaUrl];
}

class ComponentRegistry<T> {
  final Map<String, T> _componentByName = {};
  final Map<String, Map<String, T>> _componentByNameVersion = {};
  final Map<String, Map<String, T>> _componentByNameSchema = {};
  final Map<String, Map<String, Map<String, T>>> _componentByNameVersionSchema = {};
  final List<T> _allComponents = [];

  final T Function(InstrumentationScopeInfo) _builder;

  ComponentRegistry(this._builder);

  T get(String name, [String? version, String? schemaUrl]) {
    if (version != null && schemaUrl != null) {
      if (!_componentByNameVersionSchema.containsKey(name)) {
        _componentByNameVersionSchema[name] = {};
      }
      if (!_componentByNameVersionSchema[name]!.containsKey(version)) {
        _componentByNameVersionSchema[name]![version] = {};
      }
      if (!_componentByNameVersionSchema[name]![version]!.containsKey(schemaUrl)) {
        _componentByNameVersionSchema[name]![version]![schemaUrl] = _buildComponent(InstrumentationScopeInfo(
          name: name,
          version: version,
          schemaUrl: schemaUrl,
        ));
      }
      return _componentByNameVersionSchema[name]![version]![schemaUrl]!;
    } else if (version != null) {
      if (!_componentByNameVersion.containsKey(name)) {
        _componentByNameVersion[name] = {};
      }
      if (!_componentByNameVersion[name]!.containsKey(version)) {
        _componentByNameVersion[name]![version] = _buildComponent(InstrumentationScopeInfo(
          name: name,
          version: version,
        ));
      }
      return _componentByNameVersion[name]![version]!;
    } else if (schemaUrl != null) {
      if (!_componentByNameSchema.containsKey(name)) {
        _componentByNameSchema[name] = {};
      }
      if (!_componentByNameSchema[name]!.containsKey(schemaUrl)) {
        _componentByNameSchema[name]![schemaUrl] = _buildComponent(InstrumentationScopeInfo(
          name: name,
          schemaUrl: schemaUrl,
        ));
      }
      return _componentByNameSchema[name]![schemaUrl]!;
    } else {
      if (!_componentByName.containsKey(name)) {
        _componentByName[name] = _buildComponent(InstrumentationScopeInfo(name: name));
      }
      return _componentByName[name]!;
    }
  }

  T _buildComponent(InstrumentationScopeInfo scope) {
    final component = _builder(scope);
    _allComponents.add(component);
    return component;
  }

  List<T> getComponents() {
    return List.from(_allComponents);
  }
}

