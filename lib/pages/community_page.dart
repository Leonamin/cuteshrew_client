import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/widgets/centered_view/centered_view.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:cuteshrew/widgets/posting_panel/posting_panel.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  final String communityName;
  const CommunityPage({Key? key, required this.communityName})
      : super(key: key);

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
              FutureBuilder<Community>(
                  future: httpService.getCommunity(communityName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //FIXME 제발 높이가 넘는거 좀 어캐해결하냐 사이트 전체 스크롤 없나
                      return Column(
                        children: [
                          Text(
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  height: 0.9),
                              (snapshot.data as Community).communityShowName),
                          PostingPanel(
                              posts: (snapshot.data as Community)
                                  .latestPostingList),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  })
            ],
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.note_add),
      ),
    );
  }
}
