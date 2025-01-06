import 'package:chatapp/data/auth_repo.dart';
import 'package:chatapp/data/user_repo.dart';
import 'package:chatapp/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_vm.g.dart';

@riverpod
class SignInVm extends _$SignInVm with NotifierMounted {
  @override
  FutureOr<void> build() async {
    ref.onDispose(setUnmounted);
  }

  Future<void> signInWithGoogleAndUserNotExistAddDb() async {
    state = const AsyncValue.loading();
    final auth = ref.read(authProvider);

    await auth.signInWithGoogle();

    final newState = await AsyncValue.guard(
      () => ref.read(realTimeUsersRepoProvider).createUserIfNotExist(
            auth.currentUsertoUserModelWithOutFriends,
          ),
    );
    if(mounted){
      state = newState;
    }
  }
}
