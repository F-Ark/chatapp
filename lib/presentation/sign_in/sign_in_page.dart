import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/presentation/sign_in/sign_in_vm.dart';
import 'package:chatapp/utils/async_value_extension.dart';
import 'package:chatapp/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   ref.listenShowSnackBar(signInVmProvider);
    final state = ref.watch(signInVmProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 200, height: 200),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll<double>(20),
                      ),
                      onPressed: () {
                        ref
                            .read(signInVmProvider.notifier)
                            .signInWithGoogleAndUserNotExistAddDb();
                      },
                      child: SvgPicture.asset(
                        'assets/google_icon.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Google hesabınızla oturum açabilirsiniz.',
                        speed: Durations.long1,
                        curve: Curves.bounceInOut,
                        textStyle: context.textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
