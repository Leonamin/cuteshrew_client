import 'package:cuteshrew/model/Post.dart';
import 'dart:convert';

class Community {
  final int communityId;
  final String communityName;
  final String communityShowName;
  List<Post> latestPostingList;

  Community(
      {required this.communityId,
      required this.communityShowName,
      required this.communityName,
      required this.latestPostingList});

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
        communityId: json['id'],
        communityName: json['name'],
        communityShowName: json['showname'],
        latestPostingList: List<Post>.from(
            [...?json['postings']].map((e) => Post.fromJson(e))));
    // latestPostingList: Post.fromJson(json['postings']));
  }
}
