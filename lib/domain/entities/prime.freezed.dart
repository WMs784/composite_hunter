// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Item {
  int get value => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  DateTime get firstObtained => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call({int value, int count, DateTime firstObtained, int usageCount});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? count = null,
    Object? firstObtained = null,
    Object? usageCount = null,
  }) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as int,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            firstObtained: null == firstObtained
                ? _value.firstObtained
                : firstObtained // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            usageCount: null == usageCount
                ? _value.usageCount
                : usageCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
    _$ItemImpl value,
    $Res Function(_$ItemImpl) then,
  ) = _$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, int count, DateTime firstObtained, int usageCount});
}

/// @nodoc
class _$$ItemImplCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  _$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
    : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? count = null,
    Object? firstObtained = null,
    Object? usageCount = null,
  }) {
    return _then(
      _$ItemImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as int,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        firstObtained: null == firstObtained
            ? _value.firstObtained
            : firstObtained // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        usageCount: null == usageCount
            ? _value.usageCount
            : usageCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ItemImpl extends _Item {
  const _$ItemImpl({
    required this.value,
    required this.count,
    required this.firstObtained,
    this.usageCount = 0,
  }) : super._();

  @override
  final int value;
  @override
  final int count;
  @override
  final DateTime firstObtained;
  @override
  @JsonKey()
  final int usageCount;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      _$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);
}

abstract class _Item extends Item {
  const factory _Item({
    required final int value,
    required final int count,
    required final DateTime firstObtained,
    final int usageCount,
  }) = _$ItemImpl;
  const _Item._() : super._();

  @override
  int get value;
  @override
  int get count;
  @override
  DateTime get firstObtained;
  @override
  int get usageCount;
  @override
  @JsonKey(ignore: true)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
