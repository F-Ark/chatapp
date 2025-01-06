import 'package:chatapp/data/user_repo.dart';
import 'package:chatapp/domain/message_model.dart';
import 'package:chatapp/presentation/message/message_vm.dart';
import 'package:chatapp/utils/async_value_extension.dart';
import 'package:chatapp/utils/async_value_widget.dart';
import 'package:chatapp/utils/context_extensions.dart';
import 'package:chatapp/utils/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagePage extends ConsumerWidget {
  const MessagePage({required this.otherUserId, super.key});

  final String otherUserId;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenShowSnackBar(messageStreamSpesificUserProvider(otherUserId));
    final stateOfMessages =
        ref.watch(messageStreamSpesificUserProvider(otherUserId));
    final stateOfUser = ref.watch(getSpesificUserProvider(otherUserId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          stateOfUser.maybeWhen(
              data: (user) => user?.username ?? '', orElse: () => 'Kullanıcı',),
        ),
      ),
      body: AsyncValueWidget<List<MessageModel>>(
        watchingProvidersValue: stateOfMessages,
        data: (messages) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = otherUserId != message.sender;
                  return MessageBallon(message: message, isMe: isMe);
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      style: context.textTheme.headlineSmall,
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {} // todo ayarlanacak
                            ),
                        hintText: '  Mesajınızı yazın...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBallon extends StatelessWidget {
  const MessageBallon({
    super.key,
    required this.message,
    required this.isMe,
  });

  final MessageModel message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(message.timestamp),
      elevation: 5,
      shadowColor: isMe ? Colors.lightGreen : Colors.lightBlue,
      margin: isMe
          ? const EdgeInsets.only(
              right: 18,
              left: 120,
              top: 8,
              bottom: 8,
            )
          : const EdgeInsets.only(
              right: 100,
              left: 18,
              top: 8,
              bottom: 8,
            ),
      child: ListTile(
        titleTextStyle: context.textTheme.headlineSmall,
        title: Text(message.message ?? ''),
        subtitle: Text(message.timestamp!.toDateTime()),
      ),
    );
  }
}
