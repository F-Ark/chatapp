import 'package:chatapp/data/auth_repo.dart';
import 'package:chatapp/data/user_repo.dart';
import 'package:chatapp/domain/friend_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_chats_vm.g.dart';

@riverpod
class UserChatsVm extends _$UserChatsVm {
  @override
  FutureOr<void> build() async {}

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authProvider).signOut());
  }
}

@riverpod
class GetUsersChatFriendsStream extends _$GetUsersChatFriendsStream {
  @override
  Stream<List<FriendModel>> build() {
    return ref.watch(realTimeUsersRepoProvider).getUsersChatFriendsStream(
          ref.watch(authProvider).currentUsertoUserModelWithOutFriends,
        );
  }
}
