import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/widgets/community_panel/community_panel.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/network/http_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Community>? _communities = null;

  HttpService httpService = HttpService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService.getMainPage().then((value) {
      setState(() {
        _communities = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        const MainNavigationBar(),
        // const SizedBox(
        //   height: 70,
        // ),
        (_communities == null)
            ? const CircularProgressIndicator()
            : GridView.builder(
                shrinkWrap: true,
                itemCount: _communities!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CommunityPanel(communityInfo: _communities![index]);
                }),
      ]),
    );
  }
}
