import 'package:chatapp/domain/user_model.dart';
import 'package:chatapp/presentation/all_users_list/all_users_list_vm.dart';
import 'package:chatapp/utils/app_constants.dart';
import 'package:chatapp/utils/async_value_extension.dart';
import 'package:chatapp/utils/async_value_widget.dart';
import 'package:chatapp/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class AllUsersListPage extends ConsumerWidget {
  const AllUsersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenShowSnackBar(fetchUsersExceptMeProvider);
    final state = ref.watch(fetchUsersExceptMeProvider);
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppConstants.allUsersListTitle),
      ),
      body: AsyncValueWidget<List<UserModel>>(
          watchingProvidersValue: state, data: (data) =>
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) =>
                Card(
                  child: InkWell(
                    onTap: () =>
                        context.go('/user_chats/message/${data[index].uid}'),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(data[index].username!.getInitials()),
                      ),
                      title: Text(
                        data[index].username ?? 'Kullanici',
                      ),
                      subtitle: Text(data[index].eposta ?? 'email'),
                    ),
                  ),
                ),
          ),),

    );
  }
}
