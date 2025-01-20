import 'package:chatapp/presentation/message/message_compolents/send_message_widget.dart';
import 'package:chatapp/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class MessageSendArea extends StatefulWidget {
  const MessageSendArea(
    this.otherUserId, {
    super.key,
  });

  final String otherUserId;

  @override
  State<MessageSendArea> createState() => _MessageSendAreaState();
}

class _MessageSendAreaState extends State<MessageSendArea> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otherUserId = widget.otherUserId;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (_) => setState(() {}),
              controller: _textController,
              textInputAction: TextInputAction.done,
              style: context.textTheme.headlineSmall,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                suffixIcon: SendMessageSuffixIcon(
                  otherUserId: otherUserId,
                  textController: _textController,
                ),
                hintText: '  Mesajınızı yazın...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
