// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  AchievementCategory get category => throw _privateConstructorUsedError;
  AchievementType get type => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError;
  int get currentProgress => throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;
  AchievementReward get reward => throw _privateConstructorUsedError;
  DateTime? get unlockedAt => throw _privateConstructorUsedError;
  AchievementRarity get rarity => throw _privateConstructorUsedError;
  bool get isHidden => throw _privateConstructorUsedError;
  bool get isSecret => throw _privateConstructorUsedError;
  String? get iconPath => throw _privateConstructorUsedError;
  String? get hint => throw _privateConstructorUsedError;
  List<String>? get prerequisites => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) then) =
      _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      AchievementCategory category,
      AchievementType type,
      int targetValue,
      int currentProgress,
      bool isUnlocked,
      AchievementReward reward,
      DateTime? unlockedAt,
      AchievementRarity rarity,
      bool isHidden,
      bool isSecret,
      String? iconPath,
      String? hint,
      List<String>? prerequisites});

  $AchievementRewardCopyWith<$Res> get reward;
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentProgress = null,
    Object? isUnlocked = null,
    Object? reward = null,
    Object? unlockedAt = freezed,
    Object? rarity = null,
    Object? isHidden = null,
    Object? isSecret = null,
    Object? iconPath = freezed,
    Object? hint = freezed,
    Object? prerequisites = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AchievementCategory,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AchievementType,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentProgress: null == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      reward: null == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as AchievementReward,
      unlockedAt: freezed == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as AchievementRarity,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      isSecret: null == isSecret
          ? _value.isSecret
          : isSecret // ignore: cast_nullable_to_non_nullable
              as bool,
      iconPath: freezed == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      hint: freezed == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String?,
      prerequisites: freezed == prerequisites
          ? _value.prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AchievementRewardCopyWith<$Res> get reward {
    return $AchievementRewardCopyWith<$Res>(_value.reward, (value) {
      return _then(_value.copyWith(reward: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
          _$AchievementImpl value, $Res Function(_$AchievementImpl) then) =
      __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      AchievementCategory category,
      AchievementType type,
      int targetValue,
      int currentProgress,
      bool isUnlocked,
      AchievementReward reward,
      DateTime? unlockedAt,
      AchievementRarity rarity,
      bool isHidden,
      bool isSecret,
      String? iconPath,
      String? hint,
      List<String>? prerequisites});

  @override
  $AchievementRewardCopyWith<$Res> get reward;
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
      _$AchievementImpl _value, $Res Function(_$AchievementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentProgress = null,
    Object? isUnlocked = null,
    Object? reward = null,
    Object? unlockedAt = freezed,
    Object? rarity = null,
    Object? isHidden = null,
    Object? isSecret = null,
    Object? iconPath = freezed,
    Object? hint = freezed,
    Object? prerequisites = freezed,
  }) {
    return _then(_$AchievementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AchievementCategory,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AchievementType,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentProgress: null == currentProgress
          ? _value.currentProgress
          : currentProgress // ignore: cast_nullable_to_non_nullable
              as int,
      isUnlocked: null == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      reward: null == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as AchievementReward,
      unlockedAt: freezed == unlockedAt
          ? _value.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as AchievementRarity,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      isSecret: null == isSecret
          ? _value.isSecret
          : isSecret // ignore: cast_nullable_to_non_nullable
              as bool,
      iconPath: freezed == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      hint: freezed == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String?,
      prerequisites: freezed == prerequisites
          ? _value._prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.type,
      required this.targetValue,
      required this.currentProgress,
      required this.isUnlocked,
      required this.reward,
      this.unlockedAt,
      this.rarity = AchievementRarity.common,
      this.isHidden = false,
      this.isSecret = false,
      this.iconPath,
      this.hint,
      final List<String>? prerequisites})
      : _prerequisites = prerequisites;

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final AchievementCategory category;
  @override
  final AchievementType type;
  @override
  final int targetValue;
  @override
  final int currentProgress;
  @override
  final bool isUnlocked;
  @override
  final AchievementReward reward;
  @override
  final DateTime? unlockedAt;
  @override
  @JsonKey()
  final AchievementRarity rarity;
  @override
  @JsonKey()
  final bool isHidden;
  @override
  @JsonKey()
  final bool isSecret;
  @override
  final String? iconPath;
  @override
  final String? hint;
  final List<String>? _prerequisites;
  @override
  List<String>? get prerequisites {
    final value = _prerequisites;
    if (value == null) return null;
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, category: $category, type: $type, targetValue: $targetValue, currentProgress: $currentProgress, isUnlocked: $isUnlocked, reward: $reward, unlockedAt: $unlockedAt, rarity: $rarity, isHidden: $isHidden, isSecret: $isSecret, iconPath: $iconPath, hint: $hint, prerequisites: $prerequisites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.reward, reward) || other.reward == reward) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.isSecret, isSecret) ||
                other.isSecret == isSecret) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            const DeepCollectionEquality()
                .equals(other._prerequisites, _prerequisites));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      category,
      type,
      targetValue,
      currentProgress,
      isUnlocked,
      reward,
      unlockedAt,
      rarity,
      isHidden,
      isSecret,
      iconPath,
      hint,
      const DeepCollectionEquality().hash(_prerequisites));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);
}

abstract class _Achievement implements Achievement {
  const factory _Achievement(
      {required final String id,
      required final String title,
      required final String description,
      required final AchievementCategory category,
      required final AchievementType type,
      required final int targetValue,
      required final int currentProgress,
      required final bool isUnlocked,
      required final AchievementReward reward,
      final DateTime? unlockedAt,
      final AchievementRarity rarity,
      final bool isHidden,
      final bool isSecret,
      final String? iconPath,
      final String? hint,
      final List<String>? prerequisites}) = _$AchievementImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  AchievementCategory get category;
  @override
  AchievementType get type;
  @override
  int get targetValue;
  @override
  int get currentProgress;
  @override
  bool get isUnlocked;
  @override
  AchievementReward get reward;
  @override
  DateTime? get unlockedAt;
  @override
  AchievementRarity get rarity;
  @override
  bool get isHidden;
  @override
  bool get isSecret;
  @override
  String? get iconPath;
  @override
  String? get hint;
  @override
  List<String>? get prerequisites;
  @override
  @JsonKey(ignore: true)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AchievementReward {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int amount) experience,
    required TResult Function(int value, int count) prime,
    required TResult Function(List<AchievementReward> rewards) combo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int amount)? experience,
    TResult? Function(int value, int count)? prime,
    TResult? Function(List<AchievementReward> rewards)? combo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int amount)? experience,
    TResult Function(int value, int count)? prime,
    TResult Function(List<AchievementReward> rewards)? combo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperienceReward value) experience,
    required TResult Function(PrimeReward value) prime,
    required TResult Function(ComboReward value) combo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExperienceReward value)? experience,
    TResult? Function(PrimeReward value)? prime,
    TResult? Function(ComboReward value)? combo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperienceReward value)? experience,
    TResult Function(PrimeReward value)? prime,
    TResult Function(ComboReward value)? combo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementRewardCopyWith<$Res> {
  factory $AchievementRewardCopyWith(
          AchievementReward value, $Res Function(AchievementReward) then) =
      _$AchievementRewardCopyWithImpl<$Res, AchievementReward>;
}

/// @nodoc
class _$AchievementRewardCopyWithImpl<$Res, $Val extends AchievementReward>
    implements $AchievementRewardCopyWith<$Res> {
  _$AchievementRewardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ExperienceRewardImplCopyWith<$Res> {
  factory _$$ExperienceRewardImplCopyWith(_$ExperienceRewardImpl value,
          $Res Function(_$ExperienceRewardImpl) then) =
      __$$ExperienceRewardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int amount});
}

/// @nodoc
class __$$ExperienceRewardImplCopyWithImpl<$Res>
    extends _$AchievementRewardCopyWithImpl<$Res, _$ExperienceRewardImpl>
    implements _$$ExperienceRewardImplCopyWith<$Res> {
  __$$ExperienceRewardImplCopyWithImpl(_$ExperienceRewardImpl _value,
      $Res Function(_$ExperienceRewardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_$ExperienceRewardImpl(
      null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ExperienceRewardImpl implements ExperienceReward {
  const _$ExperienceRewardImpl(this.amount);

  @override
  final int amount;

  @override
  String toString() {
    return 'AchievementReward.experience(amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceRewardImpl &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceRewardImplCopyWith<_$ExperienceRewardImpl> get copyWith =>
      __$$ExperienceRewardImplCopyWithImpl<_$ExperienceRewardImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int amount) experience,
    required TResult Function(int value, int count) prime,
    required TResult Function(List<AchievementReward> rewards) combo,
  }) {
    return experience(amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int amount)? experience,
    TResult? Function(int value, int count)? prime,
    TResult? Function(List<AchievementReward> rewards)? combo,
  }) {
    return experience?.call(amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int amount)? experience,
    TResult Function(int value, int count)? prime,
    TResult Function(List<AchievementReward> rewards)? combo,
    required TResult orElse(),
  }) {
    if (experience != null) {
      return experience(amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperienceReward value) experience,
    required TResult Function(PrimeReward value) prime,
    required TResult Function(ComboReward value) combo,
  }) {
    return experience(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExperienceReward value)? experience,
    TResult? Function(PrimeReward value)? prime,
    TResult? Function(ComboReward value)? combo,
  }) {
    return experience?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperienceReward value)? experience,
    TResult Function(PrimeReward value)? prime,
    TResult Function(ComboReward value)? combo,
    required TResult orElse(),
  }) {
    if (experience != null) {
      return experience(this);
    }
    return orElse();
  }
}

abstract class ExperienceReward implements AchievementReward {
  const factory ExperienceReward(final int amount) = _$ExperienceRewardImpl;

  int get amount;
  @JsonKey(ignore: true)
  _$$ExperienceRewardImplCopyWith<_$ExperienceRewardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PrimeRewardImplCopyWith<$Res> {
  factory _$$PrimeRewardImplCopyWith(
          _$PrimeRewardImpl value, $Res Function(_$PrimeRewardImpl) then) =
      __$$PrimeRewardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int value, int count});
}

/// @nodoc
class __$$PrimeRewardImplCopyWithImpl<$Res>
    extends _$AchievementRewardCopyWithImpl<$Res, _$PrimeRewardImpl>
    implements _$$PrimeRewardImplCopyWith<$Res> {
  __$$PrimeRewardImplCopyWithImpl(
      _$PrimeRewardImpl _value, $Res Function(_$PrimeRewardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? count = null,
  }) {
    return _then(_$PrimeRewardImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PrimeRewardImpl implements PrimeReward {
  const _$PrimeRewardImpl(this.value, this.count);

  @override
  final int value;
  @override
  final int count;

  @override
  String toString() {
    return 'AchievementReward.prime(value: $value, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrimeRewardImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrimeRewardImplCopyWith<_$PrimeRewardImpl> get copyWith =>
      __$$PrimeRewardImplCopyWithImpl<_$PrimeRewardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int amount) experience,
    required TResult Function(int value, int count) prime,
    required TResult Function(List<AchievementReward> rewards) combo,
  }) {
    return prime(value, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int amount)? experience,
    TResult? Function(int value, int count)? prime,
    TResult? Function(List<AchievementReward> rewards)? combo,
  }) {
    return prime?.call(value, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int amount)? experience,
    TResult Function(int value, int count)? prime,
    TResult Function(List<AchievementReward> rewards)? combo,
    required TResult orElse(),
  }) {
    if (prime != null) {
      return prime(value, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperienceReward value) experience,
    required TResult Function(PrimeReward value) prime,
    required TResult Function(ComboReward value) combo,
  }) {
    return prime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExperienceReward value)? experience,
    TResult? Function(PrimeReward value)? prime,
    TResult? Function(ComboReward value)? combo,
  }) {
    return prime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperienceReward value)? experience,
    TResult Function(PrimeReward value)? prime,
    TResult Function(ComboReward value)? combo,
    required TResult orElse(),
  }) {
    if (prime != null) {
      return prime(this);
    }
    return orElse();
  }
}

abstract class PrimeReward implements AchievementReward {
  const factory PrimeReward(final int value, final int count) =
      _$PrimeRewardImpl;

  int get value;
  int get count;
  @JsonKey(ignore: true)
  _$$PrimeRewardImplCopyWith<_$PrimeRewardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ComboRewardImplCopyWith<$Res> {
  factory _$$ComboRewardImplCopyWith(
          _$ComboRewardImpl value, $Res Function(_$ComboRewardImpl) then) =
      __$$ComboRewardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AchievementReward> rewards});
}

/// @nodoc
class __$$ComboRewardImplCopyWithImpl<$Res>
    extends _$AchievementRewardCopyWithImpl<$Res, _$ComboRewardImpl>
    implements _$$ComboRewardImplCopyWith<$Res> {
  __$$ComboRewardImplCopyWithImpl(
      _$ComboRewardImpl _value, $Res Function(_$ComboRewardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewards = null,
  }) {
    return _then(_$ComboRewardImpl(
      null == rewards
          ? _value._rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<AchievementReward>,
    ));
  }
}

/// @nodoc

class _$ComboRewardImpl implements ComboReward {
  const _$ComboRewardImpl(final List<AchievementReward> rewards)
      : _rewards = rewards;

  final List<AchievementReward> _rewards;
  @override
  List<AchievementReward> get rewards {
    if (_rewards is EqualUnmodifiableListView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rewards);
  }

  @override
  String toString() {
    return 'AchievementReward.combo(rewards: $rewards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComboRewardImpl &&
            const DeepCollectionEquality().equals(other._rewards, _rewards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rewards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComboRewardImplCopyWith<_$ComboRewardImpl> get copyWith =>
      __$$ComboRewardImplCopyWithImpl<_$ComboRewardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int amount) experience,
    required TResult Function(int value, int count) prime,
    required TResult Function(List<AchievementReward> rewards) combo,
  }) {
    return combo(rewards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int amount)? experience,
    TResult? Function(int value, int count)? prime,
    TResult? Function(List<AchievementReward> rewards)? combo,
  }) {
    return combo?.call(rewards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int amount)? experience,
    TResult Function(int value, int count)? prime,
    TResult Function(List<AchievementReward> rewards)? combo,
    required TResult orElse(),
  }) {
    if (combo != null) {
      return combo(rewards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExperienceReward value) experience,
    required TResult Function(PrimeReward value) prime,
    required TResult Function(ComboReward value) combo,
  }) {
    return combo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExperienceReward value)? experience,
    TResult? Function(PrimeReward value)? prime,
    TResult? Function(ComboReward value)? combo,
  }) {
    return combo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExperienceReward value)? experience,
    TResult Function(PrimeReward value)? prime,
    TResult Function(ComboReward value)? combo,
    required TResult orElse(),
  }) {
    if (combo != null) {
      return combo(this);
    }
    return orElse();
  }
}

abstract class ComboReward implements AchievementReward {
  const factory ComboReward(final List<AchievementReward> rewards) =
      _$ComboRewardImpl;

  List<AchievementReward> get rewards;
  @JsonKey(ignore: true)
  _$$ComboRewardImplCopyWith<_$ComboRewardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AchievementProgress {
  String get achievementId => throw _privateConstructorUsedError;
  int get currentValue => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  List<AchievementProgressSnapshot> get snapshots =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AchievementProgressCopyWith<AchievementProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementProgressCopyWith<$Res> {
  factory $AchievementProgressCopyWith(
          AchievementProgress value, $Res Function(AchievementProgress) then) =
      _$AchievementProgressCopyWithImpl<$Res, AchievementProgress>;
  @useResult
  $Res call(
      {String achievementId,
      int currentValue,
      int targetValue,
      DateTime lastUpdated,
      List<AchievementProgressSnapshot> snapshots});
}

/// @nodoc
class _$AchievementProgressCopyWithImpl<$Res, $Val extends AchievementProgress>
    implements $AchievementProgressCopyWith<$Res> {
  _$AchievementProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? currentValue = null,
    Object? targetValue = null,
    Object? lastUpdated = null,
    Object? snapshots = null,
  }) {
    return _then(_value.copyWith(
      achievementId: null == achievementId
          ? _value.achievementId
          : achievementId // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      snapshots: null == snapshots
          ? _value.snapshots
          : snapshots // ignore: cast_nullable_to_non_nullable
              as List<AchievementProgressSnapshot>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementProgressImplCopyWith<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  factory _$$AchievementProgressImplCopyWith(_$AchievementProgressImpl value,
          $Res Function(_$AchievementProgressImpl) then) =
      __$$AchievementProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String achievementId,
      int currentValue,
      int targetValue,
      DateTime lastUpdated,
      List<AchievementProgressSnapshot> snapshots});
}

/// @nodoc
class __$$AchievementProgressImplCopyWithImpl<$Res>
    extends _$AchievementProgressCopyWithImpl<$Res, _$AchievementProgressImpl>
    implements _$$AchievementProgressImplCopyWith<$Res> {
  __$$AchievementProgressImplCopyWithImpl(_$AchievementProgressImpl _value,
      $Res Function(_$AchievementProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievementId = null,
    Object? currentValue = null,
    Object? targetValue = null,
    Object? lastUpdated = null,
    Object? snapshots = null,
  }) {
    return _then(_$AchievementProgressImpl(
      achievementId: null == achievementId
          ? _value.achievementId
          : achievementId // ignore: cast_nullable_to_non_nullable
              as String,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      snapshots: null == snapshots
          ? _value._snapshots
          : snapshots // ignore: cast_nullable_to_non_nullable
              as List<AchievementProgressSnapshot>,
    ));
  }
}

/// @nodoc

class _$AchievementProgressImpl implements _AchievementProgress {
  const _$AchievementProgressImpl(
      {required this.achievementId,
      required this.currentValue,
      required this.targetValue,
      required this.lastUpdated,
      final List<AchievementProgressSnapshot> snapshots = const []})
      : _snapshots = snapshots;

  @override
  final String achievementId;
  @override
  final int currentValue;
  @override
  final int targetValue;
  @override
  final DateTime lastUpdated;
  final List<AchievementProgressSnapshot> _snapshots;
  @override
  @JsonKey()
  List<AchievementProgressSnapshot> get snapshots {
    if (_snapshots is EqualUnmodifiableListView) return _snapshots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_snapshots);
  }

  @override
  String toString() {
    return 'AchievementProgress(achievementId: $achievementId, currentValue: $currentValue, targetValue: $targetValue, lastUpdated: $lastUpdated, snapshots: $snapshots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementProgressImpl &&
            (identical(other.achievementId, achievementId) ||
                other.achievementId == achievementId) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other._snapshots, _snapshots));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      achievementId,
      currentValue,
      targetValue,
      lastUpdated,
      const DeepCollectionEquality().hash(_snapshots));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementProgressImplCopyWith<_$AchievementProgressImpl> get copyWith =>
      __$$AchievementProgressImplCopyWithImpl<_$AchievementProgressImpl>(
          this, _$identity);
}

abstract class _AchievementProgress implements AchievementProgress {
  const factory _AchievementProgress(
          {required final String achievementId,
          required final int currentValue,
          required final int targetValue,
          required final DateTime lastUpdated,
          final List<AchievementProgressSnapshot> snapshots}) =
      _$AchievementProgressImpl;

  @override
  String get achievementId;
  @override
  int get currentValue;
  @override
  int get targetValue;
  @override
  DateTime get lastUpdated;
  @override
  List<AchievementProgressSnapshot> get snapshots;
  @override
  @JsonKey(ignore: true)
  _$$AchievementProgressImplCopyWith<_$AchievementProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AchievementProgressSnapshot {
  int get value => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get trigger => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AchievementProgressSnapshotCopyWith<AchievementProgressSnapshot>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementProgressSnapshotCopyWith<$Res> {
  factory $AchievementProgressSnapshotCopyWith(
          AchievementProgressSnapshot value,
          $Res Function(AchievementProgressSnapshot) then) =
      _$AchievementProgressSnapshotCopyWithImpl<$Res,
          AchievementProgressSnapshot>;
  @useResult
  $Res call(
      {int value,
      DateTime timestamp,
      String? trigger,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AchievementProgressSnapshotCopyWithImpl<$Res,
        $Val extends AchievementProgressSnapshot>
    implements $AchievementProgressSnapshotCopyWith<$Res> {
  _$AchievementProgressSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? timestamp = null,
    Object? trigger = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trigger: freezed == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementProgressSnapshotImplCopyWith<$Res>
    implements $AchievementProgressSnapshotCopyWith<$Res> {
  factory _$$AchievementProgressSnapshotImplCopyWith(
          _$AchievementProgressSnapshotImpl value,
          $Res Function(_$AchievementProgressSnapshotImpl) then) =
      __$$AchievementProgressSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int value,
      DateTime timestamp,
      String? trigger,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$AchievementProgressSnapshotImplCopyWithImpl<$Res>
    extends _$AchievementProgressSnapshotCopyWithImpl<$Res,
        _$AchievementProgressSnapshotImpl>
    implements _$$AchievementProgressSnapshotImplCopyWith<$Res> {
  __$$AchievementProgressSnapshotImplCopyWithImpl(
      _$AchievementProgressSnapshotImpl _value,
      $Res Function(_$AchievementProgressSnapshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? timestamp = null,
    Object? trigger = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$AchievementProgressSnapshotImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      trigger: freezed == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$AchievementProgressSnapshotImpl
    implements _AchievementProgressSnapshot {
  const _$AchievementProgressSnapshotImpl(
      {required this.value,
      required this.timestamp,
      this.trigger,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  @override
  final int value;
  @override
  final DateTime timestamp;
  @override
  final String? trigger;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AchievementProgressSnapshot(value: $value, timestamp: $timestamp, trigger: $trigger, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementProgressSnapshotImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, timestamp, trigger,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementProgressSnapshotImplCopyWith<_$AchievementProgressSnapshotImpl>
      get copyWith => __$$AchievementProgressSnapshotImplCopyWithImpl<
          _$AchievementProgressSnapshotImpl>(this, _$identity);
}

abstract class _AchievementProgressSnapshot
    implements AchievementProgressSnapshot {
  const factory _AchievementProgressSnapshot(
          {required final int value,
          required final DateTime timestamp,
          final String? trigger,
          final Map<String, dynamic>? metadata}) =
      _$AchievementProgressSnapshotImpl;

  @override
  int get value;
  @override
  DateTime get timestamp;
  @override
  String? get trigger;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$AchievementProgressSnapshotImplCopyWith<_$AchievementProgressSnapshotImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AchievementNotification {
  Achievement get achievement => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  String? get customMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AchievementNotificationCopyWith<AchievementNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementNotificationCopyWith<$Res> {
  factory $AchievementNotificationCopyWith(AchievementNotification value,
          $Res Function(AchievementNotification) then) =
      _$AchievementNotificationCopyWithImpl<$Res, AchievementNotification>;
  @useResult
  $Res call(
      {Achievement achievement,
      DateTime timestamp,
      bool isRead,
      String? customMessage});

  $AchievementCopyWith<$Res> get achievement;
}

/// @nodoc
class _$AchievementNotificationCopyWithImpl<$Res,
        $Val extends AchievementNotification>
    implements $AchievementNotificationCopyWith<$Res> {
  _$AchievementNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievement = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? customMessage = freezed,
  }) {
    return _then(_value.copyWith(
      achievement: null == achievement
          ? _value.achievement
          : achievement // ignore: cast_nullable_to_non_nullable
              as Achievement,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      customMessage: freezed == customMessage
          ? _value.customMessage
          : customMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AchievementCopyWith<$Res> get achievement {
    return $AchievementCopyWith<$Res>(_value.achievement, (value) {
      return _then(_value.copyWith(achievement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AchievementNotificationImplCopyWith<$Res>
    implements $AchievementNotificationCopyWith<$Res> {
  factory _$$AchievementNotificationImplCopyWith(
          _$AchievementNotificationImpl value,
          $Res Function(_$AchievementNotificationImpl) then) =
      __$$AchievementNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Achievement achievement,
      DateTime timestamp,
      bool isRead,
      String? customMessage});

  @override
  $AchievementCopyWith<$Res> get achievement;
}

/// @nodoc
class __$$AchievementNotificationImplCopyWithImpl<$Res>
    extends _$AchievementNotificationCopyWithImpl<$Res,
        _$AchievementNotificationImpl>
    implements _$$AchievementNotificationImplCopyWith<$Res> {
  __$$AchievementNotificationImplCopyWithImpl(
      _$AchievementNotificationImpl _value,
      $Res Function(_$AchievementNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? achievement = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? customMessage = freezed,
  }) {
    return _then(_$AchievementNotificationImpl(
      achievement: null == achievement
          ? _value.achievement
          : achievement // ignore: cast_nullable_to_non_nullable
              as Achievement,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      customMessage: freezed == customMessage
          ? _value.customMessage
          : customMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AchievementNotificationImpl implements _AchievementNotification {
  const _$AchievementNotificationImpl(
      {required this.achievement,
      required this.timestamp,
      this.isRead = false,
      this.customMessage});

  @override
  final Achievement achievement;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isRead;
  @override
  final String? customMessage;

  @override
  String toString() {
    return 'AchievementNotification(achievement: $achievement, timestamp: $timestamp, isRead: $isRead, customMessage: $customMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementNotificationImpl &&
            (identical(other.achievement, achievement) ||
                other.achievement == achievement) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.customMessage, customMessage) ||
                other.customMessage == customMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, achievement, timestamp, isRead, customMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementNotificationImplCopyWith<_$AchievementNotificationImpl>
      get copyWith => __$$AchievementNotificationImplCopyWithImpl<
          _$AchievementNotificationImpl>(this, _$identity);
}

abstract class _AchievementNotification implements AchievementNotification {
  const factory _AchievementNotification(
      {required final Achievement achievement,
      required final DateTime timestamp,
      final bool isRead,
      final String? customMessage}) = _$AchievementNotificationImpl;

  @override
  Achievement get achievement;
  @override
  DateTime get timestamp;
  @override
  bool get isRead;
  @override
  String? get customMessage;
  @override
  @JsonKey(ignore: true)
  _$$AchievementNotificationImplCopyWith<_$AchievementNotificationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
