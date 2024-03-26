import 'package:cuteshrew/0_foundation/ui/color_palettes.dart';
import 'package:cuteshrew/3_view/0_component/appbar/shrew_appbar.dart';
import 'package:cuteshrew/3_view/0_component/base/init_wrap.dart';
import 'package:cuteshrew/3_view/0_component/logo.dart';
import 'package:cuteshrew/3_view/home/0_component/posting_card_widget.dart';
import 'package:cuteshrew/3_view/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(homeViewModelProvider).init();

    return InitWrap(
      provider: homeViewModelProvider,
      child: SafeArea(
        child: Scaffold(
          appBar: ShrewAppBar.title(
            leading: const LogoWidget(),
            title: '귀여운 땃쥐',
          ),
          body: Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(homeViewModelProvider);
              return ListView.separated(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemBuilder: (context, index) {
                  return Consumer(builder: (context, ref, child) {
                    final viewModel = ref.watch(homeViewModelProvider);
                    return PostingCardWidget.fromPostingSummary(
                      viewModel.popularPostings[index],
                    );
                  });
                },
                separatorBuilder: (context, index) => const Divider(
                  color: ColorPaletts.grayscale2,
                ),
                itemCount: viewModel.popularPostings.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
