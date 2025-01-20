import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Equatable{
  const MessageModel({
    required this.sender,
    required this.message,
    this.timestamp,
  });

  factory MessageModel.fromJson(Map<Object?, Object?> json) =>
      _$MessageModelFromJson(Map<String, dynamic>.from(json));

  final String sender;
  final String message;
  @JsonKey(
    toJson: _toJsonTimestamp,

  )
  final int? timestamp;

  static dynamic _toJsonTimestamp(int? value) {
    if (value == null) return ServerValue.timestamp;
    return value;
  }


  Map<String, dynamic> toJson() {
    return _$MessageModelToJson(this);
  }

  @override
  List<Object?> get props => [sender, message, timestamp];
}
