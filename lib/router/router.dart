import 'package:chatapp/data/auth_repo.dart';
import 'package:chatapp/presentation/all_users_list/all_users_list_page.dart';
import 'package:chatapp/presentation/message/message_page.dart';
import 'package:chatapp/presentation/sign_in/sign_in_page.dart';
import 'package:chatapp/presentation/user_chats/user_chats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(Ref ref) {
  final auth = ref.read(authProvider);
  var isUserSignIn = false;

  final isUserSignInNotifier = ValueNotifier<bool>(isUserSignIn);
  final subscription = auth.isCurrentUserSingInStream.listen((event) {
    if (isUserSignIn != event) isUserSignIn = event;
    isUserSignInNotifier.value = event;
  });
  ref.onDispose(
    subscription.cancel,
  );
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteEnum.signIn.path,
    refreshListenable: isUserSignInNotifier,

    // Null Döndürmeyi Unutmayın: Eğer yönlendirme yapmanıza gerek yoksa
    redirect: (_, state) {
      if (!isUserSignIn && state.matchedLocation != AppRouteEnum.signIn.path) {
        return AppRouteEnum.signIn.path;
      }

      if (isUserSignIn && state.matchedLocation == AppRouteEnum.signIn.path) {
        return AppRouteEnum.userChats.path;
      }
      return null;
    },

    routes: [
      GoRoute(
        name: AppRouteEnum.signIn.name,
        path: AppRouteEnum.signIn.path,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: AppRouteEnum.userChats.name,
        path: AppRouteEnum.userChats.path,
        builder: (context, state) => const UserChatPage(),
        routes: [
          GoRoute(
            name: AppRouteEnum.allUsersList.name,
            path: AppRouteEnum.allUsersList.path,
            builder: (context, state) => const AllUsersListPage(),
          ),
          GoRoute(
            name: AppRouteEnum.message.name, //'message/:id'
            path: AppRouteEnum.message.path,
            builder: (context, state) {
              final pathOfOtherUserId = state.pathParameters['id']!;
              return
                  MessagePage(pathOfOtherUserId: pathOfOtherUserId);

            },
          ),
        ],
      ),
    ],
  );
}

enum AppRouteEnum {
  signIn(path: '/sign_in'),
  userChats(path: '/user_chats'),
  allUsersList(path: 'all_users_list'),
  message(path: 'message/:id'),
  ;

  const AppRouteEnum({required this.path});

  final String path;
}
