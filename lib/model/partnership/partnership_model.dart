import 'package:cric_spot/model/batting/batting_lineup_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'partnership_model.freezed.dart';
part 'partnership_model.g.dart';

@unfreezed
class PartnerShipModel extends HiveObject with _$PartnerShipModel {
  @HiveType(typeId: 7, adapterName: 'PartnerShipModelAdapter')
  factory PartnerShipModel({
    @HiveField(0) int? run,
    @HiveField(1) int? ball,
    @HiveField(2) int? extra,
    @HiveField(3) BattingLineUpModel? currentStiker,
    @HiveField(4) BattingLineUpModel? currentNotStiker,
  }) = _PartnerShipModel;
  PartnerShipModel._();

  factory PartnerShipModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerShipModelFromJson(json);

  // Map<String, dynamic> toJson() {
  //   return {
  //     'run': run,
  //     'ball': ball,
  //     'extra': extra,
  //     'currentStiker': currentStiker?.toJson(),
  //     'currentNotStiker': currentNotStiker?.toJson(),
  //   };
  // }
}
