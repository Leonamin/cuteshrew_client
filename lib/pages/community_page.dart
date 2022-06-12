import 'dart:convert';

import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/model/Post.dart';
import 'package:cuteshrew/widgets/centered_view/centered_view.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:cuteshrew/widgets/posting_panel/posting_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommunityPage extends StatefulWidget {
  final String community_name;

  CommunityPage({Key? key, required String this.community_name})
      : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late Future<Community> community;

  @override
  void initState() {
    super.initState();
    community = fetchCommunity(widget.community_name);
  }

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
              FutureBuilder<Community>(
                  future: community,
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

Future<Community> fetchCommunity(community_name) async {
  final response = await http
      .get(Uri.parse("http://cuteshrew.xyz/community/" + community_name));

  if (response.statusCode == 200) {
    return Community.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load post');
  }
}
