// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRepositoryHash() => r'7ab66dee8488642a07e0951b2b4e8f23c9218c0b';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = Provider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = ProviderRef<ChatRepository>;
String _$messagesListStreamHash() =>
    r'f65d9792c7201faa54cd4e5148fd804fc568afbf';

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

/// See also [messagesListStream].
@ProviderFor(messagesListStream)
const messagesListStreamProvider = MessagesListStreamFamily();

/// See also [messagesListStream].
class MessagesListStreamFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [messagesListStream].
  const MessagesListStreamFamily();

  /// See also [messagesListStream].
  MessagesListStreamProvider call(String roomId) {
    return MessagesListStreamProvider(roomId);
  }

  @override
  MessagesListStreamProvider getProviderOverride(
    covariant MessagesListStreamProvider provider,
  ) {
    return call(provider.roomId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesListStreamProvider';
}

/// See also [messagesListStream].
class MessagesListStreamProvider
    extends AutoDisposeStreamProvider<List<Message>> {
  /// See also [messagesListStream].
  MessagesListStreamProvider(String roomId)
    : this._internal(
        (ref) => messagesListStream(ref as MessagesListStreamRef, roomId),
        from: messagesListStreamProvider,
        name: r'messagesListStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$messagesListStreamHash,
        dependencies: MessagesListStreamFamily._dependencies,
        allTransitiveDependencies:
            MessagesListStreamFamily._allTransitiveDependencies,
        roomId: roomId,
      );

  MessagesListStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  Override overrideWith(
    Stream<List<Message>> Function(MessagesListStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MessagesListStreamProvider._internal(
        (ref) => create(ref as MessagesListStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Message>> createElement() {
    return _MessagesListStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesListStreamProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessagesListStreamRef on AutoDisposeStreamProviderRef<List<Message>> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _MessagesListStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Message>>
    with MessagesListStreamRef {
  _MessagesListStreamProviderElement(super.provider);

  @override
  String get roomId => (origin as MessagesListStreamProvider).roomId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
