

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefAsListenable on Ref {
  ValueListenable<T> asValueListenable<T>(
      ProviderBase<T> provider,
      ) {
    final valueNotifier = ValueNotifier(read(provider));

    final providerSubscription = listen<T>(provider, (_, next) {
      // Yalnızca değer gerçekten değiştiyse güncelleyin
      if (valueNotifier.value != next) {
        valueNotifier.value = next;
      }
    });

    onResume(() {
      final latestValue = read(provider);
      // Again, only update if there's a change
      if (valueNotifier.value != latestValue) {
        valueNotifier.value = latestValue;
      }
    });

    onDispose(() {
      providerSubscription.close();
      valueNotifier.dispose();
    });

    return valueNotifier;
  }
}

// ValueListenable myListen = ref.asListenable(provider);













// kullanımı=>   refreshListenable: ref.asListenable(provider),
