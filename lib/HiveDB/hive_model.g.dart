// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddTextAdapter extends TypeAdapter<AddTextModel> {
  @override
  final int typeId = 0;

  @override
  AddTextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddTextModel(
      textToSave: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddTextModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.textToSave);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
