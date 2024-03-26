import 'package:cuteshrew/3_view/0_component/base/base_view_model.dart';
import 'package:cuteshrew/3_view/0_component/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitWrap extends ConsumerWidget {
  final ProviderBase<BaseViewModel> provider;
  final Widget? loadingWidget;
  final Widget child;

  const InitWrap({
    super.key,
    required this.provider,
    this.loadingWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch<BaseViewModel>(provider);
    if (viewModel.isInitCompleted) {
      return child;
    }
    return loadingWidget ?? const LoadingWidget();
  }
}
