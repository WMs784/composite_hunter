import 'package:freezed_annotation/freezed_annotation.dart';
import 'penalty_record_model.dart';

part 'timer_state_model.freezed.dart';
part 'timer_state_model.g.dart';

@freezed
class TimerStateModel with _$TimerStateModel {
  const factory TimerStateModel({
    required int remainingSeconds,
    required int originalSeconds,
    @Default(false) bool isActive,
    @Default(false) bool isWarning,
    @Default([]) List<PenaltyRecordModel> penalties,
  }) = _TimerStateModel;

  factory TimerStateModel.fromJson(Map<String, dynamic> json) =>
      _$TimerStateModelFromJson(json);
}