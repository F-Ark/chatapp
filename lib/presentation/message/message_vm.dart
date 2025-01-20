import 'package:chatapp/application/peer_id_service.dart';
import 'package:chatapp/data/message_repo.dart';
import 'package:chatapp/data/user_repo.dart';
import 'package:chatapp/domain/message_model.dart';
import 'package:chatapp/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_vm.g.dart';


@riverpod
Future<UserModel?> getOtherUser(Ref ref, String otherUserId) async {
  return ref.read(realTimeUsersRepoProvider).getSpesificUser(otherUserId);
}

@riverpod
Stream<List<MessageModel>> messageStreamSpesificUser(
  Ref ref,
  String otherUserId,
) {
  final peersId = ref.read(creatPeerIdProvider(otherUserId));

  return ref
      .read(realTimeMessageRepoProvider)
      .getUsersChatFriendsStream(peersId);
}
