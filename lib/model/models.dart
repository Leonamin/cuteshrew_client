class Post {
  int postId;
  String title;

  Post({required this.postId, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(postId: json['id'], title: json['title']);
  }
}

class PostCreate {
  String title;
  String body;
  bool isLocked;
  String? password;

  PostCreate(
      {required this.title,
      required this.body,
      required this.isLocked,
      required this.password});

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'is_locked': isLocked,
        'password': password
      };
}

class Community {
  final String communityName;
  final String communityShowName;
  List<Post> latestPostingList;
  final int postingsCount;

  Community(
      {required this.communityShowName,
      required this.communityName,
      required this.latestPostingList,
      required this.postingsCount});

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
        communityName: json['name'],
        communityShowName: json['showname'],
        latestPostingList: List<Post>.from(
            [...?json['postings']].map((e) => Post.fromJson(e))),
        postingsCount: json['postings_count']);
    // latestPostingList: Post.fromJson(json['postings']));
  }
}

class CommunityPreview {
  final int id;
  final String communityName;
  final String communityShowName;
  CommunityPreview({
    required this.id,
    required this.communityName,
    required this.communityShowName,
  });

  factory CommunityPreview.fromJson(Map<String, dynamic> json) {
    return CommunityPreview(
        id: json['id'],
        communityName: json['name'],
        communityShowName: json['showname']);
  }
}

class Login {
  final String username;
  final String password;

  Login(this.username, this.password);

  Map toMap() {
    return {'username': username, 'password': password};
  }
}

class UserCreate {
  final String nickname;
  final String email;
  final String password;

  UserCreate(this.nickname, this.email, this.password);

  Map toMap() {
    return {'nickname': nickname, 'email': email, 'password': password};
  }
}
