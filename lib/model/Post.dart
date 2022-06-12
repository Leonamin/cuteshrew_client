class Post {
  int postId;
  String title;

  Post({required this.postId, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(postId: json['id'], title: json['title']);
  }
}
