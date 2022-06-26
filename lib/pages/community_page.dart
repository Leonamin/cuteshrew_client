import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:cuteshrew/widgets/posting_panel/posting_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  static const pageName = '/community';
  final Map<String, Community> _arguments;

  const CommunityPage(this._arguments, {Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentPageNum = 1;
  int _pagePerCount = 15;
  int _maxPageButtons = 1;
  late Community _currentCommunity;

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
    LoginToken? token =
        context.select((LoginProvider login) => login.loginToken);
    Community communityInfo = widget._arguments['communityInfo'] as Community;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const MainNavigationBar(),
          FutureBuilder<Community>(
              future: httpService.getCommunity(
                  communityInfo.communityName, _currentPageNum, _pagePerCount),
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
                          community: communityInfo,
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
      floatingActionButton: (token != null)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PostEditorPage({'communityInfo': communityInfo})),
                );
              },
              child: const Icon(Icons.note_add),
            )
          : null,
    );
  }
}
