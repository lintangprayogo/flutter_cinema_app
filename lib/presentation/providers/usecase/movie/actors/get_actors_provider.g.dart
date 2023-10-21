// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_actors_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getActorsHash() => r'b20c73a4c0eac1e38cea9f09912c5e38cf6bea85';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getActors].
@ProviderFor(getActors)
const getActorsProvider = GetActorsFamily();

/// See also [getActors].
class GetActorsFamily extends Family<AsyncValue<List<Actor>>> {
  /// See also [getActors].
  const GetActorsFamily();

  /// See also [getActors].
  GetActorsProvider call({
    required GetActorsParam param,
  }) {
    return GetActorsProvider(
      param: param,
    );
  }

  @visibleForOverriding
  @override
  GetActorsProvider getProviderOverride(
    covariant GetActorsProvider provider,
  ) {
    return call(
      param: provider.param,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getActorsProvider';
}

/// See also [getActors].
class GetActorsProvider extends AutoDisposeFutureProvider<List<Actor>> {
  /// See also [getActors].
  GetActorsProvider({
    required GetActorsParam param,
  }) : this._internal(
          (ref) => getActors(
            ref as GetActorsRef,
            param: param,
          ),
          from: getActorsProvider,
          name: r'getActorsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getActorsHash,
          dependencies: GetActorsFamily._dependencies,
          allTransitiveDependencies: GetActorsFamily._allTransitiveDependencies,
          param: param,
        );

  GetActorsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final GetActorsParam param;

  @override
  Override overrideWith(
    FutureOr<List<Actor>> Function(GetActorsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetActorsProvider._internal(
        (ref) => create(ref as GetActorsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Actor>> createElement() {
    return _GetActorsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetActorsProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetActorsRef on AutoDisposeFutureProviderRef<List<Actor>> {
  /// The parameter `param` of this provider.
  GetActorsParam get param;
}

class _GetActorsProviderElement
    extends AutoDisposeFutureProviderElement<List<Actor>> with GetActorsRef {
  _GetActorsProviderElement(super.provider);

  @override
  GetActorsParam get param => (origin as GetActorsProvider).param;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter
