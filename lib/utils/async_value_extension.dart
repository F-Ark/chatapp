import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


extension WidgetRefUI on WidgetRef {
  void listenShowSnackBar(ProviderListenable<AsyncValue<void>>   provider) {
    listen(
      provider,
      (_, state) {
        state.whenOrNull(
          error: (error, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
        );
      },
    );
  }
}
