import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/providers/user_page_provider.dart';
import 'package:cuteshrew/widgets/main_app_bar.dart';
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
    print("asd");
    if (widget.userId == null && widget.userName == null) {
      // 유저 없음 처리
      return Container();
    } else {
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
            final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
            return ListView.builder(
              itemCount: provider.userPostings.length,
              itemBuilder: (context, index) {
                return Text(provider.userPostings[index].title);
              },
            );
          },
        ),
      );
    }
  }
}
