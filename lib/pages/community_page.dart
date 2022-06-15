import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
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
      body: ListView(
        children: [
          const MainNavigationBar(),
          FutureBuilder<Community>(
              future: httpService.getCommunity(communityName),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                height: 0.9),
                            (snapshot.data as Community).communityShowName),
                      ),
                      PostingPanel(
                          posts:
                              (snapshot.data as Community).latestPostingList),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return const CircularProgressIndicator();
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
