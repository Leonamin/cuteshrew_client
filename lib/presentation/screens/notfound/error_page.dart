import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/404.png",
            width: 350,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomText(
                text: "Page not found",
                size: 24,
                weight: FontWeight.bold,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedButton(
            onPressed: () {
              locator<NavigationService>().navigateTo(Routes.HomePageRoute);
            },
            // FIXME 하드코딩 언어
            child: const CustomText(
              text: "메인 페이지로 가기",
            ),
          ),
        ],
      ),
    );
  }
}
