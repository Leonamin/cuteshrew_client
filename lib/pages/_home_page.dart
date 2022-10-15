import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/widgets/community_panel.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoHomePage extends StatefulWidget {
  static const pageName = '/home';

  NoHomePage({Key? key}) : super(key: key);

  @override
  State<NoHomePage> createState() => _NoHomePageState();
}

class _NoHomePageState extends State<NoHomePage> {
  List<Community>? _communities;

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
        const SizedBox(
          height: 30,
        ),
        (_communities == null)
            ? const CircularProgressIndicator()
            : MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                shrinkWrap: true,
                itemCount: _communities!.length,
                itemBuilder: (BuildContext context, int index) {
                  return CommunityPanel(communityInfo: _communities![index]);
                },
              )
      ]),
    );
  }
}
