import 'package:cuteshrew/models/user_info.dart';

class Post {
  int postId;
  String title;
  int commentCount;

  Post({required this.postId, required this.title, required this.commentCount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        postId: json['id'],
        title: json['title'],
        commentCount: json['comment_count']);
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
        postingsCount: json['posting_count']);
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

class PostPreview {
  int postId;
  String title;
  bool isLocked;
  int publishedAt;
  int updatedAt;
  UserInfo userInfo;
  CommunityPreview ownCommunity;
  int? commentCount;

  PostPreview(
      {required this.postId,
      required this.title,
      required this.isLocked,
      required this.publishedAt,
      required this.updatedAt,
      required this.userInfo,
      required this.ownCommunity,
      required this.commentCount});

  factory PostPreview.fromJson(Map<String, dynamic> json) {
    return PostPreview(
        postId: json['id'],
        title: json['title'],
        isLocked: json['is_locked'],
        publishedAt: json['published_at'],
        updatedAt: json['updated_at'],
        userInfo: UserInfo.fromJson(json['creator']),
        ownCommunity: CommunityPreview.fromJson(json['own_community']),
        commentCount: json['comment_count']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostPreview &&
          postId == other.postId &&
          title == other.title &&
          isLocked == other.isLocked &&
          publishedAt == other.publishedAt &&
          updatedAt == other.updatedAt &&
          userInfo == other.userInfo);

  @override
  int get hashCode =>
      Object.hash(postId, title, isLocked, publishedAt, updatedAt, userInfo);
}

class CommentPreview {
  int commentId;
  int userId;
  String comment;
  int createdAt;
  int postId;
  int commentClass;
  int order;
  int groupId;
  UserInfo userInfo;
  PostPreview parentPost;

  CommentPreview(
      {required this.commentId,
      required this.userId,
      required this.comment,
      required this.createdAt,
      required this.postId,
      required this.commentClass,
      required this.order,
      required this.groupId,
      required this.userInfo,
      required this.parentPost});

  factory CommentPreview.fromJson(Map<String, dynamic> json) {
    return CommentPreview(
      commentId: json['id'],
      userId: json['user_id'],
      comment: json['comment'],
      createdAt: json['created_at'],
      postId: json['post_id'],
      commentClass: json['comment_class'],
      order: json['order'],
      groupId: json['group_id'],
      userInfo: UserInfo.fromJson(json['creator']),
      parentPost: PostPreview.fromJson(json['posting']),
    );
  }
}

class ResponseSearchPostings {
  int postingCounts;
  List<PostPreview> postings;

  ResponseSearchPostings({required this.postings, required this.postingCounts});

  factory ResponseSearchPostings.fromJson(Map<String, dynamic> json) {
    return ResponseSearchPostings(
        postingCounts: json['posting_count'],
        postings: List<PostPreview>.from(
            [...?json['postings']].map((e) => PostPreview.fromJson(e))));
  }
}

class ResponseSearchComments {
  int commentCounts;
  List<CommentPreview> comments;

  ResponseSearchComments({required this.commentCounts, required this.comments});

  factory ResponseSearchComments.fromJson(Map<String, dynamic> json) {
    return ResponseSearchComments(
        commentCounts: json['comment_count'],
        comments: List<CommentPreview>.from(
            [...?json['comments']].map((e) => CommentPreview.fromJson(e))));
  }
}
