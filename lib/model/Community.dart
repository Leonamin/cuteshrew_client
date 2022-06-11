import 'package:cuteshrew/model/Post.dart';

class Community {
  final int communityId;
  final String communityName;
  final String communityShowName;
  List<Post> latestPostingList;

  Community(this.communityId, this.communityShowName, this.communityName,
      this.latestPostingList);
}
