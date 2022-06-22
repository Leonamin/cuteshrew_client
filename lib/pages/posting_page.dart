import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class PostingPage extends StatelessWidget {
  static const pageName = '/post';

  final Map<String, dynamic> _arguments;

  const PostingPage(this._arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
    Community communityInfo = _arguments['communityInfo'] as Community;
    int postId = _arguments['postId'] as int;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => LoginProvider(),
        child: ListView(
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
                        Html(
                          data: (snapshot.data as PostDetail).body,
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                }))
          ],
        ),
      ),
    );
  }
}
