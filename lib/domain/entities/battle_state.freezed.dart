// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BattleState {
  Enemy? get currentEnemy => throw _privateConstructorUsedError;
  List<Item> get usedPrimes => throw _privateConstructorUsedError;
  BattleStatus get status => throw _privateConstructorUsedError;
  int get turnCount => throw _privateConstructorUsedError;
  DateTime? get battleStartTime => throw _privateConstructorUsedError;
  TimerState? get timerState => throw _privateConstructorUsedError;
  VictoryClaim? get victoryClaim => throw _privateConstructorUsedError;
  List<TimePenalty> get battlePenalties => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BattleStateCopyWith<BattleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleStateCopyWith<$Res> {
  factory $BattleStateCopyWith(
    BattleState value,
    $Res Function(BattleState) then,
  ) = _$BattleStateCopyWithImpl<$Res, BattleState>;
  @useResult
  $Res call({
    Enemy? currentEnemy,
    List<Item> usedPrimes,
    BattleStatus status,
    int turnCount,
    DateTime? battleStartTime,
    TimerState? timerState,
    VictoryClaim? victoryClaim,
    List<TimePenalty> battlePenalties,
  });

  $EnemyCopyWith<$Res>? get currentEnemy;
  $TimerStateCopyWith<$Res>? get timerState;
  $VictoryClaimCopyWith<$Res>? get victoryClaim;
}

/// @nodoc
class _$BattleStateCopyWithImpl<$Res, $Val extends BattleState>
    implements $BattleStateCopyWith<$Res> {
  _$BattleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentEnemy = freezed,
    Object? usedPrimes = null,
    Object? status = null,
    Object? turnCount = null,
    Object? battleStartTime = freezed,
    Object? timerState = freezed,
    Object? victoryClaim = freezed,
    Object? battlePenalties = null,
  }) {
    return _then(
      _value.copyWith(
            currentEnemy: freezed == currentEnemy
                ? _value.currentEnemy
                : currentEnemy // ignore: cast_nullable_to_non_nullable
                      as Enemy?,
            usedPrimes: null == usedPrimes
                ? _value.usedPrimes
                : usedPrimes // ignore: cast_nullable_to_non_nullable
                      as List<Item>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BattleStatus,
            turnCount: null == turnCount
                ? _value.turnCount
                : turnCount // ignore: cast_nullable_to_non_nullable
                      as int,
            battleStartTime: freezed == battleStartTime
                ? _value.battleStartTime
                : battleStartTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            timerState: freezed == timerState
                ? _value.timerState
                : timerState // ignore: cast_nullable_to_non_nullable
                      as TimerState?,
            victoryClaim: freezed == victoryClaim
                ? _value.victoryClaim
                : victoryClaim // ignore: cast_nullable_to_non_nullable
                      as VictoryClaim?,
            battlePenalties: null == battlePenalties
                ? _value.battlePenalties
                : battlePenalties // ignore: cast_nullable_to_non_nullable
                      as List<TimePenalty>,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyCopyWith<$Res>? get currentEnemy {
    if (_value.currentEnemy == null) {
      return null;
    }

    return $EnemyCopyWith<$Res>(_value.currentEnemy!, (value) {
      return _then(_value.copyWith(currentEnemy: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TimerStateCopyWith<$Res>? get timerState {
    if (_value.timerState == null) {
      return null;
    }

    return $TimerStateCopyWith<$Res>(_value.timerState!, (value) {
      return _then(_value.copyWith(timerState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VictoryClaimCopyWith<$Res>? get victoryClaim {
    if (_value.victoryClaim == null) {
      return null;
    }

    return $VictoryClaimCopyWith<$Res>(_value.victoryClaim!, (value) {
      return _then(_value.copyWith(victoryClaim: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleStateImplCopyWith<$Res>
    implements $BattleStateCopyWith<$Res> {
  factory _$$BattleStateImplCopyWith(
    _$BattleStateImpl value,
    $Res Function(_$BattleStateImpl) then,
  ) = _$$BattleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Enemy? currentEnemy,
    List<Item> usedPrimes,
    BattleStatus status,
    int turnCount,
    DateTime? battleStartTime,
    TimerState? timerState,
    VictoryClaim? victoryClaim,
    List<TimePenalty> battlePenalties,
  });

  @override
  $EnemyCopyWith<$Res>? get currentEnemy;
  @override
  $TimerStateCopyWith<$Res>? get timerState;
  @override
  $VictoryClaimCopyWith<$Res>? get victoryClaim;
}

/// @nodoc
class _$$BattleStateImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$BattleStateImpl>
    implements _$$BattleStateImplCopyWith<$Res> {
  _$$BattleStateImplCopyWithImpl(
    _$BattleStateImpl _value,
    $Res Function(_$BattleStateImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentEnemy = freezed,
    Object? usedPrimes = null,
    Object? status = null,
    Object? turnCount = null,
    Object? battleStartTime = freezed,
    Object? timerState = freezed,
    Object? victoryClaim = freezed,
    Object? battlePenalties = null,
  }) {
    return _then(
      _$BattleStateImpl(
        currentEnemy: freezed == currentEnemy
            ? _value.currentEnemy
            : currentEnemy // ignore: cast_nullable_to_non_nullable
                  as Enemy?,
        usedPrimes: null == usedPrimes
            ? _value._usedPrimes
            : usedPrimes // ignore: cast_nullable_to_non_nullable
                  as List<Item>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BattleStatus,
        turnCount: null == turnCount
            ? _value.turnCount
            : turnCount // ignore: cast_nullable_to_non_nullable
                  as int,
        battleStartTime: freezed == battleStartTime
            ? _value.battleStartTime
            : battleStartTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        timerState: freezed == timerState
            ? _value.timerState
            : timerState // ignore: cast_nullable_to_non_nullable
                  as TimerState?,
        victoryClaim: freezed == victoryClaim
            ? _value.victoryClaim
            : victoryClaim // ignore: cast_nullable_to_non_nullable
                  as VictoryClaim?,
        battlePenalties: null == battlePenalties
            ? _value._battlePenalties
            : battlePenalties // ignore: cast_nullable_to_non_nullable
                  as List<TimePenalty>,
      ),
    );
  }
}

/// @nodoc

class _$BattleStateImpl extends _BattleState {
  const _$BattleStateImpl({
    this.currentEnemy,
    final List<Item> usedPrimes = const [],
    this.status = BattleStatus.waiting,
    this.turnCount = 0,
    this.battleStartTime,
    this.timerState,
    this.victoryClaim,
    final List<TimePenalty> battlePenalties = const [],
  }) : _usedPrimes = usedPrimes,
       _battlePenalties = battlePenalties,
       super._();

  @override
  final Enemy? currentEnemy;
  final List<Item> _usedPrimes;
  @override
  @JsonKey()
  List<Item> get usedPrimes {
    if (_usedPrimes is EqualUnmodifiableListView) return _usedPrimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usedPrimes);
  }

  @override
  @JsonKey()
  final BattleStatus status;
  @override
  @JsonKey()
  final int turnCount;
  @override
  final DateTime? battleStartTime;
  @override
  final TimerState? timerState;
  @override
  final VictoryClaim? victoryClaim;
  final List<TimePenalty> _battlePenalties;
  @override
  @JsonKey()
  List<TimePenalty> get battlePenalties {
    if (_battlePenalties is EqualUnmodifiableListView) return _battlePenalties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_battlePenalties);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleStateImpl &&
            (identical(other.currentEnemy, currentEnemy) ||
                other.currentEnemy == currentEnemy) &&
            const DeepCollectionEquality().equals(
              other._usedPrimes,
              _usedPrimes,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.turnCount, turnCount) ||
                other.turnCount == turnCount) &&
            (identical(other.battleStartTime, battleStartTime) ||
                other.battleStartTime == battleStartTime) &&
            (identical(other.timerState, timerState) ||
                other.timerState == timerState) &&
            (identical(other.victoryClaim, victoryClaim) ||
                other.victoryClaim == victoryClaim) &&
            const DeepCollectionEquality().equals(
              other._battlePenalties,
              _battlePenalties,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentEnemy,
    const DeepCollectionEquality().hash(_usedPrimes),
    status,
    turnCount,
    battleStartTime,
    timerState,
    victoryClaim,
    const DeepCollectionEquality().hash(_battlePenalties),
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleStateImplCopyWith<_$BattleStateImpl> get copyWith =>
      _$$BattleStateImplCopyWithImpl<_$BattleStateImpl>(this, _$identity);
}

abstract class _BattleState extends BattleState {
  const factory _BattleState({
    final Enemy? currentEnemy,
    final List<Item> usedPrimes,
    final BattleStatus status,
    final int turnCount,
    final DateTime? battleStartTime,
    final TimerState? timerState,
    final VictoryClaim? victoryClaim,
    final List<TimePenalty> battlePenalties,
  }) = _$BattleStateImpl;
  const _BattleState._() : super._();

  @override
  Enemy? get currentEnemy;
  @override
  List<Item> get usedPrimes;
  @override
  BattleStatus get status;
  @override
  int get turnCount;
  @override
  DateTime? get battleStartTime;
  @override
  TimerState? get timerState;
  @override
  VictoryClaim? get victoryClaim;
  @override
  List<TimePenalty> get battlePenalties;
  @override
  @JsonKey(ignore: true)
  _$$BattleStateImplCopyWith<_$BattleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BattleSummary {
  Enemy? get enemy => throw _privateConstructorUsedError;
  int get turnsUsed => throw _privateConstructorUsedError;
  int get primesUsed => throw _privateConstructorUsedError;
  Duration? get duration => throw _privateConstructorUsedError;
  int get penalties => throw _privateConstructorUsedError;
  BattleStatus get result => throw _privateConstructorUsedError;
  VictoryClaim? get victoryClaim => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BattleSummaryCopyWith<BattleSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleSummaryCopyWith<$Res> {
  factory $BattleSummaryCopyWith(
    BattleSummary value,
    $Res Function(BattleSummary) then,
  ) = _$BattleSummaryCopyWithImpl<$Res, BattleSummary>;
  @useResult
  $Res call({
    Enemy? enemy,
    int turnsUsed,
    int primesUsed,
    Duration? duration,
    int penalties,
    BattleStatus result,
    VictoryClaim? victoryClaim,
  });

  $EnemyCopyWith<$Res>? get enemy;
  $VictoryClaimCopyWith<$Res>? get victoryClaim;
}

/// @nodoc
class _$BattleSummaryCopyWithImpl<$Res, $Val extends BattleSummary>
    implements $BattleSummaryCopyWith<$Res> {
  _$BattleSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enemy = freezed,
    Object? turnsUsed = null,
    Object? primesUsed = null,
    Object? duration = freezed,
    Object? penalties = null,
    Object? result = null,
    Object? victoryClaim = freezed,
  }) {
    return _then(
      _value.copyWith(
            enemy: freezed == enemy
                ? _value.enemy
                : enemy // ignore: cast_nullable_to_non_nullable
                      as Enemy?,
            turnsUsed: null == turnsUsed
                ? _value.turnsUsed
                : turnsUsed // ignore: cast_nullable_to_non_nullable
                      as int,
            primesUsed: null == primesUsed
                ? _value.primesUsed
                : primesUsed // ignore: cast_nullable_to_non_nullable
                      as int,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration?,
            penalties: null == penalties
                ? _value.penalties
                : penalties // ignore: cast_nullable_to_non_nullable
                      as int,
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as BattleStatus,
            victoryClaim: freezed == victoryClaim
                ? _value.victoryClaim
                : victoryClaim // ignore: cast_nullable_to_non_nullable
                      as VictoryClaim?,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $EnemyCopyWith<$Res>? get enemy {
    if (_value.enemy == null) {
      return null;
    }

    return $EnemyCopyWith<$Res>(_value.enemy!, (value) {
      return _then(_value.copyWith(enemy: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VictoryClaimCopyWith<$Res>? get victoryClaim {
    if (_value.victoryClaim == null) {
      return null;
    }

    return $VictoryClaimCopyWith<$Res>(_value.victoryClaim!, (value) {
      return _then(_value.copyWith(victoryClaim: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleSummaryImplCopyWith<$Res>
    implements $BattleSummaryCopyWith<$Res> {
  factory _$$BattleSummaryImplCopyWith(
    _$BattleSummaryImpl value,
    $Res Function(_$BattleSummaryImpl) then,
  ) = _$$BattleSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Enemy? enemy,
    int turnsUsed,
    int primesUsed,
    Duration? duration,
    int penalties,
    BattleStatus result,
    VictoryClaim? victoryClaim,
  });

  @override
  $EnemyCopyWith<$Res>? get enemy;
  @override
  $VictoryClaimCopyWith<$Res>? get victoryClaim;
}

/// @nodoc
class _$$BattleSummaryImplCopyWithImpl<$Res>
    extends _$BattleSummaryCopyWithImpl<$Res, _$BattleSummaryImpl>
    implements _$$BattleSummaryImplCopyWith<$Res> {
  _$$BattleSummaryImplCopyWithImpl(
    _$BattleSummaryImpl _value,
    $Res Function(_$BattleSummaryImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enemy = freezed,
    Object? turnsUsed = null,
    Object? primesUsed = null,
    Object? duration = freezed,
    Object? penalties = null,
    Object? result = null,
    Object? victoryClaim = freezed,
  }) {
    return _then(
      _$BattleSummaryImpl(
        enemy: freezed == enemy
            ? _value.enemy
            : enemy // ignore: cast_nullable_to_non_nullable
                  as Enemy?,
        turnsUsed: null == turnsUsed
            ? _value.turnsUsed
            : turnsUsed // ignore: cast_nullable_to_non_nullable
                  as int,
        primesUsed: null == primesUsed
            ? _value.primesUsed
            : primesUsed // ignore: cast_nullable_to_non_nullable
                  as int,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration?,
        penalties: null == penalties
            ? _value.penalties
            : penalties // ignore: cast_nullable_to_non_nullable
                  as int,
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as BattleStatus,
        victoryClaim: freezed == victoryClaim
            ? _value.victoryClaim
            : victoryClaim // ignore: cast_nullable_to_non_nullable
                  as VictoryClaim?,
      ),
    );
  }
}

/// @nodoc

class _$BattleSummaryImpl extends _BattleSummary {
  const _$BattleSummaryImpl({
    this.enemy,
    required this.turnsUsed,
    required this.primesUsed,
    this.duration,
    required this.penalties,
    required this.result,
    this.victoryClaim,
  }) : super._();

  @override
  final Enemy? enemy;
  @override
  final int turnsUsed;
  @override
  final int primesUsed;
  @override
  final Duration? duration;
  @override
  final int penalties;
  @override
  final BattleStatus result;
  @override
  final VictoryClaim? victoryClaim;

  @override
  String toString() {
    return 'BattleSummary(enemy: $enemy, turnsUsed: $turnsUsed, primesUsed: $primesUsed, duration: $duration, penalties: $penalties, result: $result, victoryClaim: $victoryClaim)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleSummaryImpl &&
            (identical(other.enemy, enemy) || other.enemy == enemy) &&
            (identical(other.turnsUsed, turnsUsed) ||
                other.turnsUsed == turnsUsed) &&
            (identical(other.primesUsed, primesUsed) ||
                other.primesUsed == primesUsed) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.penalties, penalties) ||
                other.penalties == penalties) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.victoryClaim, victoryClaim) ||
                other.victoryClaim == victoryClaim));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    enemy,
    turnsUsed,
    primesUsed,
    duration,
    penalties,
    result,
    victoryClaim,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleSummaryImplCopyWith<_$BattleSummaryImpl> get copyWith =>
      _$$BattleSummaryImplCopyWithImpl<_$BattleSummaryImpl>(this, _$identity);
}

abstract class _BattleSummary extends BattleSummary {
  const factory _BattleSummary({
    final Enemy? enemy,
    required final int turnsUsed,
    required final int primesUsed,
    final Duration? duration,
    required final int penalties,
    required final BattleStatus result,
    final VictoryClaim? victoryClaim,
  }) = _$BattleSummaryImpl;
  const _BattleSummary._() : super._();

  @override
  Enemy? get enemy;
  @override
  int get turnsUsed;
  @override
  int get primesUsed;
  @override
  Duration? get duration;
  @override
  int get penalties;
  @override
  BattleStatus get result;
  @override
  VictoryClaim? get victoryClaim;
  @override
  @JsonKey(ignore: true)
  _$$BattleSummaryImplCopyWith<_$BattleSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
