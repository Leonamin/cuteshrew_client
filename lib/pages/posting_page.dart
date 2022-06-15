import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';

class PostingPage extends StatelessWidget {
  final Community communityInfo;
  final int postId;
  const PostingPage(
      {Key? key, required this.communityInfo, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const MainNavigationBar(),
          FutureBuilder(
              future:
                  httpService.getPosting(communityInfo.communityName, postId),
              builder: ((context, snapshot) {
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
                            communityInfo.communityShowName),
                      ),
                      Text((snapshot.data as PostDetail).body)
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              }))
        ],
      ),
    );
  }
}
