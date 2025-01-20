import 'package:chatapp/domain/friend_model.dart';
import 'package:chatapp/presentation/user_chats/user_chats_vm.dart';
import 'package:chatapp/router/router.dart';
import 'package:chatapp/utils/app_constants.dart';
import 'package:chatapp/utils/async_value_extension.dart';
import 'package:chatapp/utils/async_value_widget.dart';
import 'package:chatapp/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserChatPage extends ConsumerWidget {
  const UserChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenShowSnackBar(getUsersChatFriendsStreamProvider);

    final usersChatStream = ref.watch(getUsersChatFriendsStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.chatsTitle),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app_outlined),
          onPressed: () => ref.read(userChatsVmProvider.notifier).signOut(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goNamed(AppRouteEnum.allUsersList.name),
        label: const Icon(Icons.add_reaction_outlined),
      ),
      body:AsyncValueWidget<List<FriendModel>>(watchingProvidersValue:
      usersChatStream,
        data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => context.go('./message/${data[index].uid}'),


          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(data[index].name!.getInitials()),
              ),
              title: Text(
                data[index].name ?? 'Kullanici',
              ),
              subtitle: Text(data[index].lastMessage ?? 'Sen mesaj'),
            ),
          ),
        ),
      ), )

    );
  }
}
