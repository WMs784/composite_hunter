import 'package:freezed_annotation/freezed_annotation.dart';

part 'prime_model.freezed.dart';
part 'prime_model.g.dart';

@freezed
class PrimeModel with _$PrimeModel {
  const factory PrimeModel({
    required int value,
    required int count,
    required DateTime firstObtained,
    @Default(0) int usageCount,
  }) = _PrimeModel;

  factory PrimeModel.fromJson(Map<String, dynamic> json) =>
      _$PrimeModelFromJson(json);
}
