// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_loadout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BattleLoadout {
  List<Item> get battleItems => throw _privateConstructorUsedError;
  List<Item> get originalItems => throw _privateConstructorUsedError;
  int get maxSlots => throw _privateConstructorUsedError;
  Stage get targetStage => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BattleLoadoutCopyWith<BattleLoadout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleLoadoutCopyWith<$Res> {
  factory $BattleLoadoutCopyWith(
    BattleLoadout value,
    $Res Function(BattleLoadout) then,
  ) = _$BattleLoadoutCopyWithImpl<$Res, BattleLoadout>;
  @useResult
  $Res call({
    List<Item> battleItems,
    List<Item> originalItems,
    int maxSlots,
    Stage targetStage,
    DateTime createdAt,
  });

  $StageCopyWith<$Res> get targetStage;
}

/// @nodoc
class _$BattleLoadoutCopyWithImpl<$Res, $Val extends BattleLoadout>
    implements $BattleLoadoutCopyWith<$Res> {
  _$BattleLoadoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleItems = null,
    Object? originalItems = null,
    Object? maxSlots = null,
    Object? targetStage = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            battleItems: null == battleItems
                ? _value.battleItems
                : battleItems // ignore: cast_nullable_to_non_nullable
                      as List<Item>,
            originalItems: null == originalItems
                ? _value.originalItems
                : originalItems // ignore: cast_nullable_to_non_nullable
                      as List<Item>,
            maxSlots: null == maxSlots
                ? _value.maxSlots
                : maxSlots // ignore: cast_nullable_to_non_nullable
                      as int,
            targetStage: null == targetStage
                ? _value.targetStage
                : targetStage // ignore: cast_nullable_to_non_nullable
                      as Stage,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $StageCopyWith<$Res> get targetStage {
    return $StageCopyWith<$Res>(_value.targetStage, (value) {
      return _then(_value.copyWith(targetStage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleLoadoutImplCopyWith<$Res>
    implements $BattleLoadoutCopyWith<$Res> {
  factory _$$BattleLoadoutImplCopyWith(
    _$BattleLoadoutImpl value,
    $Res Function(_$BattleLoadoutImpl) then,
  ) = _$$BattleLoadoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Item> battleItems,
    List<Item> originalItems,
    int maxSlots,
    Stage targetStage,
    DateTime createdAt,
  });

  @override
  $StageCopyWith<$Res> get targetStage;
}

/// @nodoc
class _$$BattleLoadoutImplCopyWithImpl<$Res>
    extends _$BattleLoadoutCopyWithImpl<$Res, _$BattleLoadoutImpl>
    implements _$$BattleLoadoutImplCopyWith<$Res> {
  _$$BattleLoadoutImplCopyWithImpl(
    _$BattleLoadoutImpl _value,
    $Res Function(_$BattleLoadoutImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleItems = null,
    Object? originalItems = null,
    Object? maxSlots = null,
    Object? targetStage = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$BattleLoadoutImpl(
        battleItems: null == battleItems
            ? _value._battleItems
            : battleItems // ignore: cast_nullable_to_non_nullable
                  as List<Item>,
        originalItems: null == originalItems
            ? _value._originalItems
            : originalItems // ignore: cast_nullable_to_non_nullable
                  as List<Item>,
        maxSlots: null == maxSlots
            ? _value.maxSlots
            : maxSlots // ignore: cast_nullable_to_non_nullable
                  as int,
        targetStage: null == targetStage
            ? _value.targetStage
            : targetStage // ignore: cast_nullable_to_non_nullable
                  as Stage,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$BattleLoadoutImpl extends _BattleLoadout {
  const _$BattleLoadoutImpl({
    required final List<Item> battleItems,
    required final List<Item> originalItems,
    required this.maxSlots,
    required this.targetStage,
    required this.createdAt,
  }) : _battleItems = battleItems,
       _originalItems = originalItems,
       super._();

  final List<Item> _battleItems;
  @override
  List<Item> get battleItems {
    if (_battleItems is EqualUnmodifiableListView) return _battleItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_battleItems);
  }

  final List<Item> _originalItems;
  @override
  List<Item> get originalItems {
    if (_originalItems is EqualUnmodifiableListView) return _originalItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_originalItems);
  }

  @override
  final int maxSlots;
  @override
  final Stage targetStage;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'BattleLoadout(battleItems: $battleItems, originalItems: $originalItems, maxSlots: $maxSlots, targetStage: $targetStage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleLoadoutImpl &&
            const DeepCollectionEquality().equals(
              other._battleItems,
              _battleItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._originalItems,
              _originalItems,
            ) &&
            (identical(other.maxSlots, maxSlots) ||
                other.maxSlots == maxSlots) &&
            (identical(other.targetStage, targetStage) ||
                other.targetStage == targetStage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_battleItems),
    const DeepCollectionEquality().hash(_originalItems),
    maxSlots,
    targetStage,
    createdAt,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleLoadoutImplCopyWith<_$BattleLoadoutImpl> get copyWith =>
      _$$BattleLoadoutImplCopyWithImpl<_$BattleLoadoutImpl>(this, _$identity);
}

abstract class _BattleLoadout extends BattleLoadout {
  const factory _BattleLoadout({
    required final List<Item> battleItems,
    required final List<Item> originalItems,
    required final int maxSlots,
    required final Stage targetStage,
    required final DateTime createdAt,
  }) = _$BattleLoadoutImpl;
  const _BattleLoadout._() : super._();

  @override
  List<Item> get battleItems;
  @override
  List<Item> get originalItems;
  @override
  int get maxSlots;
  @override
  Stage get targetStage;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$BattleLoadoutImplCopyWith<_$BattleLoadoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
