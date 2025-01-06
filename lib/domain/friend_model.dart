import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';


@JsonSerializable()
class FriendModel extends Equatable {
  const FriendModel({
    required this.uid,
    required this.timestamp,
    this.name,
    this.lastMessage,
  });


  factory FriendModel.fromJson(Map<Object?, Object?> json) {
    return _$FriendModelFromJson(json.cast());

  }
  Map<String, dynamic> toJson() => _$FriendModelToJson(this);

  final String? name;
  final String? lastMessage;
  final String uid;
  final int timestamp;

  @override
  List<Object?> get props => [name, lastMessage, uid, timestamp];
}
