import 'package:chatapp/data/auth_repo.dart';
import 'package:chatapp/data/user_repo.dart';
import 'package:chatapp/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_users_list_vm.g.dart';

@riverpod
Future<List<UserModel>> fetchUsersExceptMe(Ref ref) {
  final auth = ref.read(authProvider);
  final allUsersExceptMe = ref.read(realTimeUsersRepoProvider).getAllUsers()
    ..then(
      (value) => value.removeWhere(
        (user) => user.uid == auth.currentUsertoUserModelWithOutFriends!.uid,
      ),
    );
  return allUsersExceptMe;
}
