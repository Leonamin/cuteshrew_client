class CommunityDTO {
  final int id;
  final String? communityName;
  final String? communityShowName;
  final int? postingsCount;
  final int? createdAt;
  // 이거 너흐면 순환참조인데 어캐해결해야할지 모르겠다.
  // final List<PostingDTO> postings

  const CommunityDTO({
    required this.id,
    this.communityShowName,
    this.communityName,
    this.postingsCount,
    this.createdAt,
  });

  factory CommunityDTO.fromJson(Map<String, dynamic> json) {
    return CommunityDTO(
        id: json['id'],
        communityName: json['name'],
        communityShowName: json['showname'],
        postingsCount: json['posting_count'],
        createdAt: json['created_at']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': communityName,
        'showname': communityShowName,
        'postings_count': postingsCount,
        'created_at': createdAt,
      };
}
