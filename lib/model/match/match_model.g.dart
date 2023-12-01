// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchModelAdapter extends TypeAdapter<_$MatchModelImpl> {
  @override
  final int typeId = 2;

  @override
  _$MatchModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$MatchModelImpl(
      id: fields[0] as String?,
      over: fields[1] as String?,
      isWideBall: fields[2] as bool?,
      isWideReball: fields[3] as bool?,
      wideRun: fields[4] as int?,
      isNoball: fields[5] as bool?,
      isNoballReball: fields[6] as bool?,
      noballRun: fields[7] as int?,
      hostTeamId: fields[8] as String?,
      visitorTeamId: fields[9] as String?,
      tossId: fields[10] as String?,
      tossName: fields[11] as String?,
      tossElect: fields[12] as String?,
      wonId: fields[13] as String?,
      wonName: fields[14] as String?,
      wonBy: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$MatchModelImpl obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.over)
      ..writeByte(2)
      ..write(obj.isWideBall)
      ..writeByte(3)
      ..write(obj.isWideReball)
      ..writeByte(4)
      ..write(obj.wideRun)
      ..writeByte(5)
      ..write(obj.isNoball)
      ..writeByte(6)
      ..write(obj.isNoballReball)
      ..writeByte(7)
      ..write(obj.noballRun)
      ..writeByte(8)
      ..write(obj.hostTeamId)
      ..writeByte(9)
      ..write(obj.visitorTeamId)
      ..writeByte(10)
      ..write(obj.tossId)
      ..writeByte(11)
      ..write(obj.tossName)
      ..writeByte(12)
      ..write(obj.tossElect)
      ..writeByte(13)
      ..write(obj.wonId)
      ..writeByte(14)
      ..write(obj.wonName)
      ..writeByte(15)
      ..write(obj.wonBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchModelImpl(
      id: json['id'] as String?,
      over: json['over'] as String?,
      isWideBall: json['isWideBall'] as bool?,
      isWideReball: json['isWideReball'] as bool?,
      wideRun: json['wideRun'] as int?,
      isNoball: json['isNoball'] as bool?,
      isNoballReball: json['isNoballReball'] as bool?,
      noballRun: json['noballRun'] as int?,
      hostTeamId: json['hostTeamId'] as String?,
      visitorTeamId: json['visitorTeamId'] as String?,
      tossId: json['tossId'] as String?,
      tossName: json['tossName'] as String?,
      tossElect: json['tossElect'] as String?,
      wonId: json['wonId'] as String?,
      wonName: json['wonName'] as String?,
      wonBy: json['wonBy'] as String?,
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'over': instance.over,
      'isWideBall': instance.isWideBall,
      'isWideReball': instance.isWideReball,
      'wideRun': instance.wideRun,
      'isNoball': instance.isNoball,
      'isNoballReball': instance.isNoballReball,
      'noballRun': instance.noballRun,
      'hostTeamId': instance.hostTeamId,
      'visitorTeamId': instance.visitorTeamId,
      'tossId': instance.tossId,
      'tossName': instance.tossName,
      'tossElect': instance.tossElect,
      'wonId': instance.wonId,
      'wonName': instance.wonName,
      'wonBy': instance.wonBy,
    };
