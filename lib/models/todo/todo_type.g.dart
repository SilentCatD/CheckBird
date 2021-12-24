// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoTypeAdapter extends TypeAdapter<TodoType> {
  @override
  final int typeId = 1;

  @override
  TodoType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TodoType.task;
      case 1:
        return TodoType.habit;
      default:
        return TodoType.task;
    }
  }

  @override
  void write(BinaryWriter writer, TodoType obj) {
    switch (obj) {
      case TodoType.task:
        writer.writeByte(0);
        break;
      case TodoType.habit:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
