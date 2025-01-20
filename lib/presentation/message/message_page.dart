import 'package:chatapp/domain/message_model.dart';
import 'package:chatapp/presentation/message/message_compolents/message_ballon.dart';
import 'package:chatapp/presentation/message/message_compolents/message_send_area.dart';
import 'package:chatapp/presentation/message/message_vm.dart';
import 'package:chatapp/utils/app_constants.dart';
import 'package:chatapp/utils/async_value_extension.dart';
import 'package:chatapp/utils/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagePage extends ConsumerStatefulWidget {
  const MessagePage({required this.pathOfOtherUserId, super.key});

  final String pathOfOtherUserId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  @override
  Widget build(BuildContext context) {
    final otherUserId = widget.pathOfOtherUserId;
    ref.listenShowSnackBar(
      messageStreamSpesificUserProvider(otherUserId),
    );

    final stateOfMessages = ref.watch(
      messageStreamSpesificUserProvider(otherUserId),
    );
    final getOtherUserName = ref.watch(getOtherUserProvider(otherUserId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getOtherUserName.maybeWhen(
            data: (data) => data?.username ?? AppConstants.friend,
            orElse: () => AppConstants.friend,
          ),
        ),
      ),
      body: AsyncValueWidget<List<MessageModel>>(
        watchingProvidersValue: stateOfMessages,
        data: (messages) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = widget.pathOfOtherUserId != message.sender;
                    return MessageBallon(message: message, isMe: isMe);
                  },
                ),
              ),
               MessageSendArea(otherUserId),
            ],
          );
        },
      ),
    );
  }
}
