import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/model/Post.dart';
import 'package:cuteshrew/widgets/centered_view/centered_view.dart';
import 'package:cuteshrew/widgets/community_panel/community_panel.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: [
            MainNavigationBar(),
            SizedBox(
              height: 70,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommunityPanel(
                    community_info: Community(1, "general", "자유 게시판",
                        [Post(1, "하하"), Post(2, "호호"), Post(3, "히히")]))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
