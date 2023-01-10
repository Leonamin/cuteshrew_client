class PostingCreateDTO {
  final String title;
  final String body;
  final bool isLocked;
  final String? password;

  const PostingCreateDTO({
    required this.title,
    required this.body,
    required this.isLocked,
    required this.password,
  });

  factory PostingCreateDTO.fromJson(Map<String, dynamic> json) {
    return PostingCreateDTO(
      title: json['title'],
      body: json['body'],
      isLocked: json['is_locked'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'is_locked': isLocked,
        'password': password,
      };
}
