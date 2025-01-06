import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    this.username,
    this.eposta,
  });

  factory UserModel.fromJson(Map<Object?, Object?> json) =>
      _$UserModelFromJson(json.cast());
  final String? username;
  final String? eposta;
  final String uid;


  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [username, eposta, uid];
}
