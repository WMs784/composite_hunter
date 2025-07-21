// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temp_reward.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TempReward {
  List<Item> get tempItems => throw _privateConstructorUsedError;
  DateTime get battleStartTime => throw _privateConstructorUsedError;
  bool get isFinalized => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempRewardCopyWith<TempReward> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempRewardCopyWith<$Res> {
  factory $TempRewardCopyWith(
          TempReward value, $Res Function(TempReward) then) =
      _$TempRewardCopyWithImpl<$Res, TempReward>;
  @useResult
  $Res call({List<Item> tempItems, DateTime battleStartTime, bool isFinalized});
}

/// @nodoc
class _$TempRewardCopyWithImpl<$Res, $Val extends TempReward>
    implements $TempRewardCopyWith<$Res> {
  _$TempRewardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempItems = null,
    Object? battleStartTime = null,
    Object? isFinalized = null,
  }) {
    return _then(_value.copyWith(
      tempItems: null == tempItems
          ? _value.tempItems
          : tempItems // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      battleStartTime: null == battleStartTime
          ? _value.battleStartTime
          : battleStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinalized: null == isFinalized
          ? _value.isFinalized
          : isFinalized // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TempRewardImplCopyWith<$Res>
    implements $TempRewardCopyWith<$Res> {
  factory _$$TempRewardImplCopyWith(
          _$TempRewardImpl value, $Res Function(_$TempRewardImpl) then) =
      __$$TempRewardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Item> tempItems, DateTime battleStartTime, bool isFinalized});
}

/// @nodoc
class __$$TempRewardImplCopyWithImpl<$Res>
    extends _$TempRewardCopyWithImpl<$Res, _$TempRewardImpl>
    implements _$$TempRewardImplCopyWith<$Res> {
  __$$TempRewardImplCopyWithImpl(
      _$TempRewardImpl _value, $Res Function(_$TempRewardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempItems = null,
    Object? battleStartTime = null,
    Object? isFinalized = null,
  }) {
    return _then(_$TempRewardImpl(
      tempItems: null == tempItems
          ? _value._tempItems
          : tempItems // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      battleStartTime: null == battleStartTime
          ? _value.battleStartTime
          : battleStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFinalized: null == isFinalized
          ? _value.isFinalized
          : isFinalized // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TempRewardImpl extends _TempReward {
  const _$TempRewardImpl(
      {required final List<Item> tempItems,
      required this.battleStartTime,
      this.isFinalized = false})
      : _tempItems = tempItems,
        super._();

  final List<Item> _tempItems;
  @override
  List<Item> get tempItems {
    if (_tempItems is EqualUnmodifiableListView) return _tempItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tempItems);
  }

  @override
  final DateTime battleStartTime;
  @override
  @JsonKey()
  final bool isFinalized;

  @override
  String toString() {
    return 'TempReward(tempItems: $tempItems, battleStartTime: $battleStartTime, isFinalized: $isFinalized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TempRewardImpl &&
            const DeepCollectionEquality()
                .equals(other._tempItems, _tempItems) &&
            (identical(other.battleStartTime, battleStartTime) ||
                other.battleStartTime == battleStartTime) &&
            (identical(other.isFinalized, isFinalized) ||
                other.isFinalized == isFinalized));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tempItems),
      battleStartTime,
      isFinalized);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TempRewardImplCopyWith<_$TempRewardImpl> get copyWith =>
      __$$TempRewardImplCopyWithImpl<_$TempRewardImpl>(this, _$identity);
}

abstract class _TempReward extends TempReward {
  const factory _TempReward(
      {required final List<Item> tempItems,
      required final DateTime battleStartTime,
      final bool isFinalized}) = _$TempRewardImpl;
  const _TempReward._() : super._();

  @override
  List<Item> get tempItems;
  @override
  DateTime get battleStartTime;
  @override
  bool get isFinalized;
  @override
  @JsonKey(ignore: true)
  _$$TempRewardImplCopyWith<_$TempRewardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
