// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultslocal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultsLocalAdapter extends TypeAdapter<ResultsLocal> {
  @override
  final int typeId = 2;

  @override
  ResultsLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultsLocal(
      voteAvg: fields[4] as num?,
      backdropPath: fields[1] as String?,
      voteCount: fields[5] as num?,
      id: fields[3] as num?,
      title: fields[0] as String?,
      poster: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultsLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.backdropPath)
      ..writeByte(2)
      ..write(obj.poster)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.voteAvg)
      ..writeByte(5)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultsLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
