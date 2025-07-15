// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enemy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Enemy {
  int get currentValue => throw _privateConstructorUsedError;
  int get originalValue => throw _privateConstructorUsedError;
  EnemyType get type => throw _privateConstructorUsedError;
  List<int> get primeFactors => throw _privateConstructorUsedError;
  bool get isPowerEnemy => throw _privateConstructorUsedError;
  int? get powerBase => throw _privateConstructorUsedError;
  int? get powerExponent => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EnemyCopyWith<Enemy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnemyCopyWith<$Res> {
  factory $EnemyCopyWith(Enemy value, $Res Function(Enemy) then) =
      _$EnemyCopyWithImpl<$Res, Enemy>;
  @useResult
  $Res call(
      {int currentValue,
      int originalValue,
      EnemyType type,
      List<int> primeFactors,
      bool isPowerEnemy,
      int? powerBase,
      int? powerExponent});
}

/// @nodoc
class _$EnemyCopyWithImpl<$Res, $Val extends Enemy>
    implements $EnemyCopyWith<$Res> {
  _$EnemyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentValue = null,
    Object? originalValue = null,
    Object? type = null,
    Object? primeFactors = null,
    Object? isPowerEnemy = null,
    Object? powerBase = freezed,
    Object? powerExponent = freezed,
  }) {
    return _then(_value.copyWith(
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      originalValue: null == originalValue
          ? _value.originalValue
          : originalValue // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EnemyType,
      primeFactors: null == primeFactors
          ? _value.primeFactors
          : primeFactors // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isPowerEnemy: null == isPowerEnemy
          ? _value.isPowerEnemy
          : isPowerEnemy // ignore: cast_nullable_to_non_nullable
              as bool,
      powerBase: freezed == powerBase
          ? _value.powerBase
          : powerBase // ignore: cast_nullable_to_non_nullable
              as int?,
      powerExponent: freezed == powerExponent
          ? _value.powerExponent
          : powerExponent // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnemyImplCopyWith<$Res> implements $EnemyCopyWith<$Res> {
  factory _$$EnemyImplCopyWith(
          _$EnemyImpl value, $Res Function(_$EnemyImpl) then) =
      __$$EnemyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentValue,
      int originalValue,
      EnemyType type,
      List<int> primeFactors,
      bool isPowerEnemy,
      int? powerBase,
      int? powerExponent});
}

/// @nodoc
class __$$EnemyImplCopyWithImpl<$Res>
    extends _$EnemyCopyWithImpl<$Res, _$EnemyImpl>
    implements _$$EnemyImplCopyWith<$Res> {
  __$$EnemyImplCopyWithImpl(
      _$EnemyImpl _value, $Res Function(_$EnemyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentValue = null,
    Object? originalValue = null,
    Object? type = null,
    Object? primeFactors = null,
    Object? isPowerEnemy = null,
    Object? powerBase = freezed,
    Object? powerExponent = freezed,
  }) {
    return _then(_$EnemyImpl(
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      originalValue: null == originalValue
          ? _value.originalValue
          : originalValue // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as EnemyType,
      primeFactors: null == primeFactors
          ? _value._primeFactors
          : primeFactors // ignore: cast_nullable_to_non_nullable
              as List<int>,
      isPowerEnemy: null == isPowerEnemy
          ? _value.isPowerEnemy
          : isPowerEnemy // ignore: cast_nullable_to_non_nullable
              as bool,
      powerBase: freezed == powerBase
          ? _value.powerBase
          : powerBase // ignore: cast_nullable_to_non_nullable
              as int?,
      powerExponent: freezed == powerExponent
          ? _value.powerExponent
          : powerExponent // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$EnemyImpl extends _Enemy {
  const _$EnemyImpl(
      {required this.currentValue,
      required this.originalValue,
      required this.type,
      required final List<int> primeFactors,
      this.isPowerEnemy = false,
      this.powerBase,
      this.powerExponent})
      : _primeFactors = primeFactors,
        super._();

  @override
  final int currentValue;
  @override
  final int originalValue;
  @override
  final EnemyType type;
  final List<int> _primeFactors;
  @override
  List<int> get primeFactors {
    if (_primeFactors is EqualUnmodifiableListView) return _primeFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primeFactors);
  }

  @override
  @JsonKey()
  final bool isPowerEnemy;
  @override
  final int? powerBase;
  @override
  final int? powerExponent;

  @override
  String toString() {
    return 'Enemy(currentValue: $currentValue, originalValue: $originalValue, type: $type, primeFactors: $primeFactors, isPowerEnemy: $isPowerEnemy, powerBase: $powerBase, powerExponent: $powerExponent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnemyImpl &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.originalValue, originalValue) ||
                other.originalValue == originalValue) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._primeFactors, _primeFactors) &&
            (identical(other.isPowerEnemy, isPowerEnemy) ||
                other.isPowerEnemy == isPowerEnemy) &&
            (identical(other.powerBase, powerBase) ||
                other.powerBase == powerBase) &&
            (identical(other.powerExponent, powerExponent) ||
                other.powerExponent == powerExponent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentValue,
      originalValue,
      type,
      const DeepCollectionEquality().hash(_primeFactors),
      isPowerEnemy,
      powerBase,
      powerExponent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnemyImplCopyWith<_$EnemyImpl> get copyWith =>
      __$$EnemyImplCopyWithImpl<_$EnemyImpl>(this, _$identity);
}

abstract class _Enemy extends Enemy {
  const factory _Enemy(
      {required final int currentValue,
      required final int originalValue,
      required final EnemyType type,
      required final List<int> primeFactors,
      final bool isPowerEnemy,
      final int? powerBase,
      final int? powerExponent}) = _$EnemyImpl;
  const _Enemy._() : super._();

  @override
  int get currentValue;
  @override
  int get originalValue;
  @override
  EnemyType get type;
  @override
  List<int> get primeFactors;
  @override
  bool get isPowerEnemy;
  @override
  int? get powerBase;
  @override
  int? get powerExponent;
  @override
  @JsonKey(ignore: true)
  _$$EnemyImplCopyWith<_$EnemyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
