
import 'package:chatapp/presentation/message/message_compolents/send_message_vm.dart';
import 'package:chatapp/presentation/message/message_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendMessageSuffixIcon extends ConsumerWidget {
  const SendMessageSuffixIcon({
    required String otherUserId,
    required TextEditingController textController,
    super.key,
  })  : _textController = textController,
        _otherUserId = otherUserId;
  final String _otherUserId;
  final TextEditingController _textController;

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final state = ref.watch(messageVMProvider);
    ref.watch(
      messageStreamSpesificUserProvider(_otherUserId),
    );
    return IconButton(
      disabledColor: Theme.of(context).disabledColor.withAlpha(50),
      color: Theme.of(context).primaryColor,
      icon: state.isLoading
          ? const CircularProgressIndicator()
          : const Icon(
        Icons.send,
      ),
      onPressed: _textController.text.isEmpty || state.isLoading
          ? null
          : () async {
        await ref
            .read(messageVMProvider.notifier)
            .sendMessage(_textController.text, _otherUserId);

        _textController.clear();
      },
    );
  }
}
