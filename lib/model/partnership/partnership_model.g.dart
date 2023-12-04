// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partnership_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartnerShipModelAdapter extends TypeAdapter<_$PartnerShipModelImpl> {
  @override
  final int typeId = 7;

  @override
  _$PartnerShipModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$PartnerShipModelImpl(
      run: fields[0] as int?,
      ball: fields[1] as int?,
      extra: fields[2] as int?,
      currentStiker: fields[3] as BattingLineUpModel?,
      currentNotStiker: fields[4] as BattingLineUpModel?,
    );
  }

  @override
  void write(BinaryWriter writer, _$PartnerShipModelImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.run)
      ..writeByte(1)
      ..write(obj.ball)
      ..writeByte(2)
      ..write(obj.extra)
      ..writeByte(3)
      ..write(obj.currentStiker)
      ..writeByte(4)
      ..write(obj.currentNotStiker);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartnerShipModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartnerShipModelImpl _$$PartnerShipModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PartnerShipModelImpl(
      run: json['run'] as int?,
      ball: json['ball'] as int?,
      extra: json['extra'] as int?,
      currentStiker: json['currentStiker'] == null
          ? null
          : BattingLineUpModel.fromJson(
              json['currentStiker'] as Map<String, dynamic>),
      currentNotStiker: json['currentNotStiker'] == null
          ? null
          : BattingLineUpModel.fromJson(
              json['currentNotStiker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PartnerShipModelImplToJson(
        _$PartnerShipModelImpl instance) =>
    <String, dynamic>{
      'run': instance.run,
      'ball': instance.ball,
      'extra': instance.extra,
      'currentStiker': instance.currentStiker,
      'currentNotStiker': instance.currentNotStiker,
    };
