// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prime_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PrimeModel _$PrimeModelFromJson(Map<String, dynamic> json) {
  return _PrimeModel.fromJson(json);
}

/// @nodoc
mixin _$PrimeModel {
  int get value => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  DateTime get firstObtained => throw _privateConstructorUsedError;
  int get usageCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrimeModelCopyWith<PrimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrimeModelCopyWith<$Res> {
  factory $PrimeModelCopyWith(
          PrimeModel value, $Res Function(PrimeModel) then) =
      _$PrimeModelCopyWithImpl<$Res, PrimeModel>;
  @useResult
  $Res call({int value, int count, DateTime firstObtained, int usageCount});
}

/// @nodoc
class _$PrimeModelCopyWithImpl<$Res, $Val extends PrimeModel>
    implements $PrimeModelCopyWith<$Res> {
  _$PrimeModelCopyWithImpl(this._value, this._then);

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
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrimeModelImplCopyWith<$Res>
    implements $PrimeModelCopyWith<$Res> {
  factory _$$PrimeModelImplCopyWith(
          _$PrimeModelImpl value, $Res Function(_$PrimeModelImpl) then) =
      __$$PrimeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, int count, DateTime firstObtained, int usageCount});
}

/// @nodoc
class __$$PrimeModelImplCopyWithImpl<$Res>
    extends _$PrimeModelCopyWithImpl<$Res, _$PrimeModelImpl>
    implements _$$PrimeModelImplCopyWith<$Res> {
  __$$PrimeModelImplCopyWithImpl(
      _$PrimeModelImpl _value, $Res Function(_$PrimeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? count = null,
    Object? firstObtained = null,
    Object? usageCount = null,
  }) {
    return _then(_$PrimeModelImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrimeModelImpl implements _PrimeModel {
  const _$PrimeModelImpl(
      {required this.value,
      required this.count,
      required this.firstObtained,
      this.usageCount = 0});

  factory _$PrimeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrimeModelImplFromJson(json);

  @override
  final int value;
  @override
  final int count;
  @override
  final DateTime firstObtained;
  @override
  @JsonKey()
  final int usageCount;

  @override
  String toString() {
    return 'PrimeModel(value: $value, count: $count, firstObtained: $firstObtained, usageCount: $usageCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrimeModelImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.firstObtained, firstObtained) ||
                other.firstObtained == firstObtained) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, value, count, firstObtained, usageCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrimeModelImplCopyWith<_$PrimeModelImpl> get copyWith =>
      __$$PrimeModelImplCopyWithImpl<_$PrimeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrimeModelImplToJson(
      this,
    );
  }
}

abstract class _PrimeModel implements PrimeModel {
  const factory _PrimeModel(
      {required final int value,
      required final int count,
      required final DateTime firstObtained,
      final int usageCount}) = _$PrimeModelImpl;

  factory _PrimeModel.fromJson(Map<String, dynamic> json) =
      _$PrimeModelImpl.fromJson;

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
  _$$PrimeModelImplCopyWith<_$PrimeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
