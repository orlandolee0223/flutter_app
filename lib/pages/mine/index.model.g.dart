// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MsgItem _$MsgItemFromJson(Map<String, dynamic> json) => MsgItem(
      id: json['id'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      date: json['date'] as String? ?? '',
      isImport: json['isImport'] as bool? ?? false,
      isRead: json['is_read'] as int? ?? 2,
    );

Map<String, dynamic> _$MsgItemToJson(MsgItem instance) => <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'isImport': instance.isImport,
      'is_read': instance.isRead,
    };

MsgReadNumInfo _$MsgReadNumInfoFromJson(Map<String, dynamic> json) =>
    MsgReadNumInfo(
      post: json['post'] as int? ?? 0,
      promo: json['promo'] as int? ?? 0,
      notice: json['notice'] as int? ?? 0,
    );

Map<String, dynamic> _$MsgReadNumInfoToJson(MsgReadNumInfo instance) =>
    <String, dynamic>{
      'post': instance.post,
      'promo': instance.promo,
      'notice': instance.notice,
    };
