// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favority_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavorityModelAdapter extends TypeAdapter<FavorityModel> {
  @override
  final int typeId = 1;

  @override
  FavorityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavorityModel(
      id: fields[0] as int,
      titleProduct: fields[1] as String,
      priceProduct: fields[2] as double,
      pathImage: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavorityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleProduct)
      ..writeByte(2)
      ..write(obj.priceProduct)
      ..writeByte(3)
      ..write(obj.pathImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavorityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
