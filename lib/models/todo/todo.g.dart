// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      todoName: fields[1] as String,
      todoDescription: fields[2] as String?,
      type: fields[3] as TodoType,
      color: fields[4] as int?,
      deadline: fields[5] as DateTime?,
      notification: fields[8] as DateTime?,
      weekdays: (fields[6] as List?)?.cast<bool>(),
    )
      ..id = fields[0] as String?
      ..lastCompleted = fields[7] as DateTime?
      ..createdDate = fields[9] as DateTime?
      ..lastModified = fields[10] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.todoName)
      ..writeByte(2)
      ..write(obj.todoDescription)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.deadline)
      ..writeByte(6)
      ..write(obj.weekdays)
      ..writeByte(7)
      ..write(obj.lastCompleted)
      ..writeByte(8)
      ..write(obj.notification)
      ..writeByte(9)
      ..write(obj.createdDate)
      ..writeByte(10)
      ..write(obj.lastModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
