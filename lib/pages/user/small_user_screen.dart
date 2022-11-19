import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/providers/user_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallUserScreen extends StatefulWidget {
  int? userId;
  String? userName;
  SmallUserScreen({super.key, this.userId, this.userName});

  @override
  State<SmallUserScreen> createState() => _SmallUserScreenState();
}

class _SmallUserScreenState extends State<SmallUserScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.userId == null && widget.userName == null) {
      // 유저 없음 처리
      return NotFoundSmallUserScreen();
    } else {
      return LoadedSmallUserScreen();
    }
  }
}

class NotFoundSmallUserScreen extends StatelessWidget {
  const NotFoundSmallUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("해당 사용자는 존재하지 않습니다."),
        const SizedBox(
          height: 8,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("뒤로가기")),
      ],
    );
  }
}

class LoadedSmallUserScreen extends StatefulWidget {
  int? userId;
  String? userName;
  LoadedSmallUserScreen({super.key, this.userId, this.userName});

  @override
  State<LoadedSmallUserScreen> createState() => _LoadedSmallUserScreenState();
}

class _LoadedSmallUserScreenState extends State<LoadedSmallUserScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider =
            UserPageProvider(api: context.read<CuteshrewApiClient>());
        widget.userId != null
            ? provider.fetchPostings(userId: widget.userId)
            : provider.fetchPostings(userName: widget.userName);
        return provider;
      },
      child: Consumer<UserPageProvider>(
        builder: (context, provider, child) {
          return Container();
        },
      ),
    );
  }
}
