// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Inventory {
  List<Item> get primes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InventoryCopyWith<Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCopyWith<$Res> {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) then) =
      _$InventoryCopyWithImpl<$Res, Inventory>;
  @useResult
  $Res call({List<Item> primes});
}

/// @nodoc
class _$InventoryCopyWithImpl<$Res, $Val extends Inventory>
    implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primes = null,
  }) {
    return _then(_value.copyWith(
      primes: null == primes
          ? _value.primes
          : primes // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryImplCopyWith<$Res>
    implements $InventoryCopyWith<$Res> {
  factory _$$InventoryImplCopyWith(
          _$InventoryImpl value, $Res Function(_$InventoryImpl) then) =
      __$$InventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Item> primes});
}

/// @nodoc
class __$$InventoryImplCopyWithImpl<$Res>
    extends _$InventoryCopyWithImpl<$Res, _$InventoryImpl>
    implements _$$InventoryImplCopyWith<$Res> {
  __$$InventoryImplCopyWithImpl(
      _$InventoryImpl _value, $Res Function(_$InventoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primes = null,
  }) {
    return _then(_$InventoryImpl(
      primes: null == primes
          ? _value._primes
          : primes // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc

class _$InventoryImpl extends _Inventory {
  const _$InventoryImpl({final List<Item> primes = const []})
      : _primes = primes,
        super._();

  final List<Item> _primes;
  @override
  @JsonKey()
  List<Item> get primes {
    if (_primes is EqualUnmodifiableListView) return _primes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primes);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryImpl &&
            const DeepCollectionEquality().equals(other._primes, _primes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_primes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      __$$InventoryImplCopyWithImpl<_$InventoryImpl>(this, _$identity);
}

abstract class _Inventory extends Inventory {
  const factory _Inventory({final List<Item> primes}) = _$InventoryImpl;
  const _Inventory._() : super._();

  @override
  List<Item> get primes;
  @override
  @JsonKey(ignore: true)
  _$$InventoryImplCopyWith<_$InventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InventoryStats {
  int get totalPrimes => throw _privateConstructorUsedError;
  int get uniquePrimes => throw _privateConstructorUsedError;
  int get smallPrimes => throw _privateConstructorUsedError;
  int get largePrimes => throw _privateConstructorUsedError;
  Item? get mostUsedPrime => throw _privateConstructorUsedError;
  double get averageUsage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InventoryStatsCopyWith<InventoryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryStatsCopyWith<$Res> {
  factory $InventoryStatsCopyWith(
          InventoryStats value, $Res Function(InventoryStats) then) =
      _$InventoryStatsCopyWithImpl<$Res, InventoryStats>;
  @useResult
  $Res call(
      {int totalPrimes,
      int uniquePrimes,
      int smallPrimes,
      int largePrimes,
      Item? mostUsedPrime,
      double averageUsage});

  $ItemCopyWith<$Res>? get mostUsedPrime;
}

/// @nodoc
class _$InventoryStatsCopyWithImpl<$Res, $Val extends InventoryStats>
    implements $InventoryStatsCopyWith<$Res> {
  _$InventoryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPrimes = null,
    Object? uniquePrimes = null,
    Object? smallPrimes = null,
    Object? largePrimes = null,
    Object? mostUsedPrime = freezed,
    Object? averageUsage = null,
  }) {
    return _then(_value.copyWith(
      totalPrimes: null == totalPrimes
          ? _value.totalPrimes
          : totalPrimes // ignore: cast_nullable_to_non_nullable
              as int,
      uniquePrimes: null == uniquePrimes
          ? _value.uniquePrimes
          : uniquePrimes // ignore: cast_nullable_to_non_nullable
              as int,
      smallPrimes: null == smallPrimes
          ? _value.smallPrimes
          : smallPrimes // ignore: cast_nullable_to_non_nullable
              as int,
      largePrimes: null == largePrimes
          ? _value.largePrimes
          : largePrimes // ignore: cast_nullable_to_non_nullable
              as int,
      mostUsedPrime: freezed == mostUsedPrime
          ? _value.mostUsedPrime
          : mostUsedPrime // ignore: cast_nullable_to_non_nullable
              as Item?,
      averageUsage: null == averageUsage
          ? _value.averageUsage
          : averageUsage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemCopyWith<$Res>? get mostUsedPrime {
    if (_value.mostUsedPrime == null) {
      return null;
    }

    return $ItemCopyWith<$Res>(_value.mostUsedPrime!, (value) {
      return _then(_value.copyWith(mostUsedPrime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InventoryStatsImplCopyWith<$Res>
    implements $InventoryStatsCopyWith<$Res> {
  factory _$$InventoryStatsImplCopyWith(_$InventoryStatsImpl value,
          $Res Function(_$InventoryStatsImpl) then) =
      __$$InventoryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalPrimes,
      int uniquePrimes,
      int smallPrimes,
      int largePrimes,
      Item? mostUsedPrime,
      double averageUsage});

  @override
  $ItemCopyWith<$Res>? get mostUsedPrime;
}

/// @nodoc
class __$$InventoryStatsImplCopyWithImpl<$Res>
    extends _$InventoryStatsCopyWithImpl<$Res, _$InventoryStatsImpl>
    implements _$$InventoryStatsImplCopyWith<$Res> {
  __$$InventoryStatsImplCopyWithImpl(
      _$InventoryStatsImpl _value, $Res Function(_$InventoryStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPrimes = null,
    Object? uniquePrimes = null,
    Object? smallPrimes = null,
    Object? largePrimes = null,
    Object? mostUsedPrime = freezed,
    Object? averageUsage = null,
  }) {
    return _then(_$InventoryStatsImpl(
      totalPrimes: null == totalPrimes
          ? _value.totalPrimes
          : totalPrimes // ignore: cast_nullable_to_non_nullable
              as int,
      uniquePrimes: null == uniquePrimes
          ? _value.uniquePrimes
          : uniquePrimes // ignore: cast_nullable_to_non_nullable
              as int,
      smallPrimes: null == smallPrimes
          ? _value.smallPrimes
          : smallPrimes // ignore: cast_nullable_to_non_nullable
              as int,
      largePrimes: null == largePrimes
          ? _value.largePrimes
          : largePrimes // ignore: cast_nullable_to_non_nullable
              as int,
      mostUsedPrime: freezed == mostUsedPrime
          ? _value.mostUsedPrime
          : mostUsedPrime // ignore: cast_nullable_to_non_nullable
              as Item?,
      averageUsage: null == averageUsage
          ? _value.averageUsage
          : averageUsage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$InventoryStatsImpl implements _InventoryStats {
  const _$InventoryStatsImpl(
      {required this.totalPrimes,
      required this.uniquePrimes,
      required this.smallPrimes,
      required this.largePrimes,
      this.mostUsedPrime,
      required this.averageUsage});

  @override
  final int totalPrimes;
  @override
  final int uniquePrimes;
  @override
  final int smallPrimes;
  @override
  final int largePrimes;
  @override
  final Item? mostUsedPrime;
  @override
  final double averageUsage;

  @override
  String toString() {
    return 'InventoryStats(totalPrimes: $totalPrimes, uniquePrimes: $uniquePrimes, smallPrimes: $smallPrimes, largePrimes: $largePrimes, mostUsedPrime: $mostUsedPrime, averageUsage: $averageUsage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryStatsImpl &&
            (identical(other.totalPrimes, totalPrimes) ||
                other.totalPrimes == totalPrimes) &&
            (identical(other.uniquePrimes, uniquePrimes) ||
                other.uniquePrimes == uniquePrimes) &&
            (identical(other.smallPrimes, smallPrimes) ||
                other.smallPrimes == smallPrimes) &&
            (identical(other.largePrimes, largePrimes) ||
                other.largePrimes == largePrimes) &&
            (identical(other.mostUsedPrime, mostUsedPrime) ||
                other.mostUsedPrime == mostUsedPrime) &&
            (identical(other.averageUsage, averageUsage) ||
                other.averageUsage == averageUsage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalPrimes, uniquePrimes,
      smallPrimes, largePrimes, mostUsedPrime, averageUsage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryStatsImplCopyWith<_$InventoryStatsImpl> get copyWith =>
      __$$InventoryStatsImplCopyWithImpl<_$InventoryStatsImpl>(
          this, _$identity);
}

abstract class _InventoryStats implements InventoryStats {
  const factory _InventoryStats(
      {required final int totalPrimes,
      required final int uniquePrimes,
      required final int smallPrimes,
      required final int largePrimes,
      final Item? mostUsedPrime,
      required final double averageUsage}) = _$InventoryStatsImpl;

  @override
  int get totalPrimes;
  @override
  int get uniquePrimes;
  @override
  int get smallPrimes;
  @override
  int get largePrimes;
  @override
  Item? get mostUsedPrime;
  @override
  double get averageUsage;
  @override
  @JsonKey(ignore: true)
  _$$InventoryStatsImplCopyWith<_$InventoryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
