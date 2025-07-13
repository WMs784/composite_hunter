import 'package:freezed_annotation/freezed_annotation.dart';

part 'penalty_record_model.freezed.dart';
part 'penalty_record_model.g.dart';

@freezed
class PenaltyRecordModel with _$PenaltyRecordModel {
  const factory PenaltyRecordModel({
    required int seconds,
    required PenaltyType type,
    required DateTime appliedAt,
    String? reason,
  }) = _PenaltyRecordModel;

  factory PenaltyRecordModel.fromJson(Map<String, dynamic> json) =>
      _$PenaltyRecordModelFromJson(json);
}

enum PenaltyType {
  @JsonValue('escape')
  escape,
  @JsonValue('wrong_victory_claim')
  wrongVictoryClaim,
  @JsonValue('time_out')
  timeOut,
}
