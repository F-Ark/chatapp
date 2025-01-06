/// Notifier alt sınıflarına eklenecek mixin
/// Notifier'ın daha önce monte edilip edilmediğini kontrol etmeniz gerekiyorsa
/// bu karışımı kullanın.
/// durumu ayarlama (genellikle eşzamansız bir işlemin ardından).
///
/// Örnek kullanım:
///
/// @riverpod
/// class SomeNotifier extends _$SomeNotifier with NotifierMounted {
///   @override
///   FutureOr<void> build() {
///     ref.onDispose(setUnmounted);
///   }
///   Future<void> doAsyncWork() {
///     state = const AsyncLoading();
///     final newState = await AsyncValue.guard(someFuture);
///     if (mounted) {
///       state = newState;
///     }
///   }
/// }
///
mixin NotifierMounted {
  bool _mounted = true;

  // Bildiriciyi bağlantısı kesilmiş olarak ayarla
  void setUnmounted() => _mounted = false;

  //Bildiricinin şu anda takılı olup olmadığı
  bool get mounted => _mounted;
}
