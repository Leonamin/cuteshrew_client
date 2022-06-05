import 'package:cuteshrew/model/Post.dart';

class Community {
  final int communityId;
  final String communityName;
  List<Post>? latestPostingList;

  Community(this.communityId, this.communityName, this.latestPostingList);
}
