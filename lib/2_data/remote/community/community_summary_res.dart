import 'package:cuteshrew/1_model/entity/community/community_summary.dart';
import 'package:cuteshrew/2_data/remote/posting/posting_summary_res.dart';

class CommunitySummaryRes {
  final int id;
  final String? communityName;
  final String? communityShowName;
  final int? postingsCount;
  final int? createdAt;
  // 이거 너흐면 순환참조인데 어캐해결해야할지 모르겠다.
  final List<PostingSummaryRes>? postings;

  const CommunitySummaryRes({
    required this.id,
    this.communityShowName,
    this.communityName,
    this.postingsCount,
    this.createdAt,
    this.postings,
  });

  factory CommunitySummaryRes.fromJson(Map<String, dynamic> json) {
    return CommunitySummaryRes(
      id: json['id'],
      communityName: json['name'],
      communityShowName: json['showname'],
      postingsCount: json['posting_count'],
      createdAt: json['created_at'],
      postings: (json['posting_list'] != null)
          ? List.from((json['posting_list'] ?? [])
              .map((e) => PostingSummaryRes.fromJson(e)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': communityName,
        'showname': communityShowName,
        'postings_count': postingsCount,
        'created_at': createdAt,
        'postings': List.from((postings ?? []).map((e) => e.toJson())),
      };
}

extension CommunitySummaryResExt on CommunitySummaryRes {
  CommunitySummary toEntity() => CommunitySummary(
        id: id,
        name: communityName ?? '',
        showingName: communityShowName ?? '',
        postingCount: postingsCount ?? 0,
      );
}
