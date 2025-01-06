import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          errorMessage,
          speed: Durations.short4,
          curve: Curves.bounceInOut,
          textStyle: context.textTheme.titleLarge!.copyWith(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ],
    );


  }
}
