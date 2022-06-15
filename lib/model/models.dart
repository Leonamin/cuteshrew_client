class Post {
  int postId;
  String title;

  Post({required this.postId, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(postId: json['id'], title: json['title']);
  }
}

class PostDetail {
  int postId;
  String title;
  String body;

  PostDetail({required this.postId, required this.title, required this.body});

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
        postId: json['id'], title: json['title'], body: json['body']);
  }
}

class Community {
  final String communityName;
  final String communityShowName;
  List<Post> latestPostingList;

  Community(
      {required this.communityShowName,
      required this.communityName,
      required this.latestPostingList});

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
        communityName: json['name'],
        communityShowName: json['showname'],
        latestPostingList: List<Post>.from(
            [...?json['postings']].map((e) => Post.fromJson(e))));
    // latestPostingList: Post.fromJson(json['postings']));
  }
}
