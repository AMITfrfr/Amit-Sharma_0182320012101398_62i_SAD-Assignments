class Idea {
  final String id;
  final String title;
  final String description;
  final String category;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'user_id': userId,
    };
  }
}
