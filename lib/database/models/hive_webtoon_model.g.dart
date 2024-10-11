// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_webtoon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveWebtoonModelAdapter extends TypeAdapter<HiveWebtoonModel> {
  @override
  final int typeId = 0;

  @override
  HiveWebtoonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWebtoonModel(
      id: fields[1] as int,
      title: fields[2] as String,
      creator: fields[3] as String,
      genre: fields[4] as String,
      image: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWebtoonModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.creator)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveWebtoonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
