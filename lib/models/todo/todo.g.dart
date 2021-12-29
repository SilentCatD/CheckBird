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
      todoDescription: fields[2] as String,
      type: fields[3] as TodoType,
      backgroundColor: fields[4] as int,
      deadline: fields[6] as DateTime?,
      notification: fields[9] as DateTime?,
      weekdays: (fields[7] as List?)?.cast<bool>(),
      groupId: fields[13] as String?,
      notificationId: fields[10] as int?,
      textColor: fields[5] as int,
    )
      ..id = fields[0] as String?
      ..lastCompleted = fields[8] as DateTime?
      ..createdDate = fields[11] as DateTime?
      ..lastModified = fields[12] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.todoName)
      ..writeByte(2)
      ..write(obj.todoDescription)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.backgroundColor)
      ..writeByte(5)
      ..write(obj.textColor)
      ..writeByte(6)
      ..write(obj.deadline)
      ..writeByte(7)
      ..write(obj.weekdays)
      ..writeByte(8)
      ..write(obj.lastCompleted)
      ..writeByte(9)
      ..write(obj.notification)
      ..writeByte(10)
      ..write(obj.notificationId)
      ..writeByte(11)
      ..write(obj.createdDate)
      ..writeByte(12)
      ..write(obj.lastModified)
      ..writeByte(13)
      ..write(obj.groupId);
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
