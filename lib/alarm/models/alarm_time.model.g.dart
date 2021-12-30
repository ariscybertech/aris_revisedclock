// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_time.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmTimeAdapter extends TypeAdapter<AlarmTime> {
  @override
  final int typeId = 0;

  @override
  AlarmTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmTime()
      ..hour = fields[0] as String
      ..minute = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, AlarmTime obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
