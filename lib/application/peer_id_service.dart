import 'package:chatapp/data/auth_repo.dart';
import 'package:chatapp/utils/string_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'peer_id_service.g.dart';

class PeerIdService {
  PeerIdService(this._ref);

  final Ref _ref;

  String creatPeerId(String otherUserId) {
    final currentUser =
        _ref.read(authProvider).currentUsertoUserModelWithOutFriends;

    currentUser!.uid.combineUid(otherUid: otherUserId);
    return currentUser.uid.combineUid(otherUid: otherUserId);
  }
}


@riverpod
String creatPeerId(Ref ref,String otherUserId) {
  return PeerIdService(ref).creatPeerId(otherUserId);
}
