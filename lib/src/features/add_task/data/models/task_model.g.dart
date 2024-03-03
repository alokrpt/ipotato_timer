// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      duration: Duration(microseconds: json['duration'] as int),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration.inMicroseconds,
      'isCompleted': instance.isCompleted,
    };
