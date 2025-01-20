import 'package:chatapp/application/peer_id_service.dart';
import 'package:chatapp/data/auth_repo.dart';
import 'package:chatapp/data/message_repo.dart';
import 'package:chatapp/data/user_repo.dart';
import 'package:chatapp/domain/friend_model.dart';
import 'package:chatapp/domain/message_model.dart';
import 'package:chatapp/presentation/message/message_vm.dart';
import 'package:chatapp/utils/app_constants.dart';
import 'package:chatapp/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'send_message_vm.g.dart';

@riverpod
class MessageVM extends _$MessageVM with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<bool> sendMessage(String messageText, String otherUserId) async {
    final currentUserId =
        ref.read(authProvider).currentUsertoUserModelWithOutFriends!.uid;

    final peersId = ref.read(creatPeerIdProvider(otherUserId));
    ref
        .read(
      messageStreamSpesificUserProvider(otherUserId),
    )
        .whenData((messages) {
      if (messages.isEmpty) {
        addFriend(
          otherUserId: otherUserId,
          otherUserName:
          ref.read(getOtherUserProvider(otherUserId)).value?.username ??
              AppConstants.friend,
          messageText: messageText,
        );
      }
    });
    state = const AsyncValue.loading();
    final message = MessageModel(
      sender: currentUserId,
      message: messageText,
    );
    final newState = await AsyncValue.guard(
          () => ref.read(realTimeMessageRepoProvider).sendMessage(peersId, message),
    );
    await updateOtherUsersLastMessage(
        otherUserId: otherUserId,
        messageText: messageText,
        currentUserId: currentUserId);
    if (mounted) {
      state = newState;
    }
    return state.hasError;
  }

  Future<void> updateOtherUsersLastMessage({
    required String otherUserId,
    required String messageText,
    required String currentUserId,
  }) async {
    await AsyncValue.guard(
          () => ref.read(realTimeUsersRepoProvider).updateOtherUsersLastMessage(
        otherUserId: otherUserId,
        messageText: messageText,
        currentUserId: currentUserId,
      ),
    );
  }

  Future<void> addFriend({
    required String otherUserId,
    required String otherUserName,
    required String messageText,
  }) async {
    final friend = FriendModel(
      uid: otherUserId,
      name: otherUserName,
      lastMessage: messageText,
    );

    await AsyncValue.guard(
          () => ref.read(realTimeUsersRepoProvider).addFriend(
        friend,
        ref.read(authProvider).currentUsertoUserModelWithOutFriends!.uid,
      ),
    );
  }
}
