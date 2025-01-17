class BlogModel {
  String userName;
  String postPicture;
  String postTitle;
  int votes;
  int comments;
  String community;
  String createdAt;
  String description;

  BlogModel({
    required this.userName,
    required this.postPicture,
    required this.postTitle,
    required this.votes,
    required this.comments,
    required this.community,
    required this.createdAt,
    required this.description,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      userName: json['userName'] ?? '',
      postPicture: json['postPicture'] ?? '',
      postTitle: json['postTitle'] ?? '',
      votes: json['votes'] ?? 0,
      comments: json['comments'] ?? 0,
      community: json['community'] ?? '',
      createdAt: json['createdAt'] ?? '',
      description: json['description'] ?? '',
    );
  }
}