import 'dart:convert';

import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/widgets/centered_view/centered_view.dart';
import 'package:cuteshrew/widgets/community_panel/community_panel.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Community>> community;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    community = fetchCommunity();
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
                FutureBuilder<List<Community>>(
                  future: community,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CommunityPanel(
                          community_info: snapshot.data as List<Community>);
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

Future<List<Community>> fetchCommunity() async {
  final response = await http.get(Uri.parse("http://cuteshrew.xyz/community"));

  if (response.statusCode == 200) {
    // Iterable l = json.decode(response.body);
    // List<Community> communities =
    //     List<Community>.from(l.map((model) => Community.fromJson(model)));

    // return communities;
    return [
      for (final e in json.decode(utf8.decode(response.bodyBytes)))
        Community.fromJson(e),
    ];
  } else {
    throw Exception('Failed to load post');
  }
}
