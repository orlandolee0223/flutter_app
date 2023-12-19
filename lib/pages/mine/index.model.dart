import 'package:json_annotation/json_annotation.dart';
//
part 'index.model.g.dart';

@JsonSerializable(explicitToJson: true)
class MsgItem {
  @JsonKey(defaultValue: '')
  final String id; // id
  @JsonKey(defaultValue: '')
  final String icon; // 游戏id
  @JsonKey(defaultValue: '')
  final String title; // 名称
  @JsonKey(defaultValue: '')
  final String content; // 内容
  @JsonKey(defaultValue: '')
  final String date; // 时间
  @JsonKey(defaultValue: false)
  final bool isImport; // 是否重要
  @JsonKey(name: 'is_read', defaultValue: 2)
  late int isRead; // 是否已读

  MsgItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.content,
    required this.date,
    required this.isImport,
    required this.isRead,
  });

  factory MsgItem.fromJson(Map<String, dynamic> json) =>
      _$MsgItemFromJson(json);

  Map<String, dynamic> toJson() => _$MsgItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MsgReadNumInfo {
  @JsonKey(defaultValue: 0)
  final int post; // 公告
  @JsonKey(defaultValue: 0)
  final int promo; // 活动
  @JsonKey(defaultValue: 0)
  final int notice; // 通知

  const MsgReadNumInfo({
    required this.post,
    required this.promo,
    required this.notice,
  });

  factory MsgReadNumInfo.fromJson(Map<String, dynamic> json) =>
      _$MsgReadNumInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MsgReadNumInfoToJson(this);
}
