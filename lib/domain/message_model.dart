import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  MessageModel({
    this.timestamp,
    this.sender,
    this.message,
  });

  factory MessageModel.fromJson(Map<Object?, Object?>json) =>
      _$MessageModelFromJson(json.cast());

  final String? sender;
  final String? message;
  final int? timestamp;

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
