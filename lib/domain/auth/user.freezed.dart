// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OwnUserTearOff {
  const _$OwnUserTearOff();

  _OwnUser call({required UniqueId id}) {
    return _OwnUser(
      id: id,
    );
  }
}

/// @nodoc
const $OwnUser = _$OwnUserTearOff();

/// @nodoc
mixin _$OwnUser {
  UniqueId get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OwnUserCopyWith<OwnUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnUserCopyWith<$Res> {
  factory $OwnUserCopyWith(OwnUser value, $Res Function(OwnUser) then) =
      _$OwnUserCopyWithImpl<$Res>;
  $Res call({UniqueId id});
}

/// @nodoc
class _$OwnUserCopyWithImpl<$Res> implements $OwnUserCopyWith<$Res> {
  _$OwnUserCopyWithImpl(this._value, this._then);

  final OwnUser _value;
  // ignore: unused_field
  final $Res Function(OwnUser) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
    ));
  }
}

/// @nodoc
abstract class _$OwnUserCopyWith<$Res> implements $OwnUserCopyWith<$Res> {
  factory _$OwnUserCopyWith(_OwnUser value, $Res Function(_OwnUser) then) =
      __$OwnUserCopyWithImpl<$Res>;
  @override
  $Res call({UniqueId id});
}

/// @nodoc
class __$OwnUserCopyWithImpl<$Res> extends _$OwnUserCopyWithImpl<$Res>
    implements _$OwnUserCopyWith<$Res> {
  __$OwnUserCopyWithImpl(_OwnUser _value, $Res Function(_OwnUser) _then)
      : super(_value, (v) => _then(v as _OwnUser));

  @override
  _OwnUser get _value => super._value as _OwnUser;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_OwnUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
    ));
  }
}

/// @nodoc

class _$_OwnUser implements _OwnUser {
  const _$_OwnUser({required this.id});

  @override
  final UniqueId id;

  @override
  String toString() {
    return 'OwnUser(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OwnUser &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$OwnUserCopyWith<_OwnUser> get copyWith =>
      __$OwnUserCopyWithImpl<_OwnUser>(this, _$identity);
}

abstract class _OwnUser implements OwnUser {
  const factory _OwnUser({required UniqueId id}) = _$_OwnUser;

  @override
  UniqueId get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OwnUserCopyWith<_OwnUser> get copyWith =>
      throw _privateConstructorUsedError;
}
