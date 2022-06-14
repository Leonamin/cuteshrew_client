import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/widgets/centered_view/centered_view.dart';
import 'package:cuteshrew/widgets/community_panel/community_panel.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/network/http_service.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
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
                FutureBuilder<List<Community>>(
                  future: httpService.getMainPage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Community> _community_info =
                          snapshot.data as List<Community>;
                      return CommunityPanel(community_info: _community_info[0]);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
