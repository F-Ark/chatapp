import 'package:chatapp/domain/message_model.dart';
import 'package:chatapp/utils/context_extensions.dart';
import 'package:chatapp/utils/int_extensions.dart';
import 'package:flutter/material.dart';

class MessageBallon extends StatelessWidget {
  const MessageBallon({
    required this.message,
    required this.isMe,
    super.key,
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
        title: Text(message.message ),
        subtitle: Text(message.timestamp!.toDateTime()),
      ),
    );
  }
}
