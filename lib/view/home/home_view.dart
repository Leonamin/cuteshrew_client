import 'package:cuteshrew/common/constants/color_set.dart';
import 'package:cuteshrew/initialize/init_view_models.dart';
import 'package:cuteshrew/view/home/component/community_card.dart';
import 'package:cuteshrew/view/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(homeViewModel);
        viewModel.onInit();
        return Scaffold(
          appBar: AppBar(
            title: const Text('홈'),
          ),
          backgroundColor: ColorSet.backgroudColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 4,
                      child: _CommunityPanel(
                        viewModel: viewModel,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CommunityPanel extends StatelessWidget {
  const _CommunityPanel({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => CommunityCard(),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: viewModel.communityInfoList.length);
  }
}
