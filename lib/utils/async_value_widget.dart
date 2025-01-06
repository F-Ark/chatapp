import 'package:chatapp/utils/error_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.watchingProvidersValue,
    required this.data,
    super.key,
  });

  final AsyncValue<T> watchingProvidersValue;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return watchingProvidersValue.when(
      data: data,
      error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

/// Sliver eşdeğeri [AsyncValueWidget]
class AsyncValueSliverWidget<T> extends StatelessWidget {
  const AsyncValueSliverWidget({
    required this.watchingProvidersValue,
    required this.data,
    super.key,
  });

  final AsyncValue<T> watchingProvidersValue;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return watchingProvidersValue.when(
      data: data,
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => SliverToBoxAdapter(
        child: Center(child: ErrorMessageWidget(e.toString())),
      ),
    );
  }
}
