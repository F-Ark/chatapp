import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class FriendModel extends Equatable {
  const FriendModel({
    required this.uid,
    this.name,
    this.lastMessage,
    this.timestamp,
  });

  factory FriendModel.fromJson(Map<Object?, Object?> json) {
    return _$FriendModelFromJson(Map<String, dynamic>.from(json));
  }

  Map<String, dynamic> toJson() => _$FriendModelToJson(this);

  final String? name;
  final String? lastMessage;
  final String uid;
  @JsonKey(
    toJson: _toJsonTimestamp,
  )
  final int? timestamp;

  static dynamic _toJsonTimestamp(int? value) {
    if (value == null) return ServerValue.timestamp;
    return value;
  }
  @override
  List<Object?> get props => [uid, timestamp];
}
