class BlogModel {
  final String? id;
  final String userId;
  final String title;
  final String content;
  final List<String>? topics;
  final String? imageUrl;
  final DateTime? date;
  String? userName;
  final String? linkedInUrl;
  final String? mediumUrl; 
  BlogModel(
      {this.id,
      required this.userId,
      required this.title,
      required this.content,
      this.date,
      this.imageUrl,
      this.topics,
      this.userName,
      this.linkedInUrl, 
      this.mediumUrl,});
  BlogModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        title = json['title'],
        content = json['content'],
        topics = List<String>.from(json['topics'] as List),
        imageUrl = json['image_url'],
        date = json['date'],
        mediumUrl = json['medium_link'],
        linkedInUrl = json['linkedIn_link'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'topics': topics,
        'date': date,
        'image_url': imageUrl,
        'user_id': userId,
        'medium_link': mediumUrl,
        'linkedIn_link': linkedInUrl,
      };

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? topics,
    String? image_url,
    DateTime? date,
    String? userName,
    String? mediumUrl,
    String? linkedInUrl,
  }) {
    return BlogModel(
      id: id ?? this.id,
      userId: userId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imageUrl: image_url ?? imageUrl,
      date: date ?? this.date,
      userName: userName ?? this.userName,
      linkedInUrl: linkedInUrl ?? this.linkedInUrl,
      mediumUrl: mediumUrl ?? this.mediumUrl,
    );
  }
}
