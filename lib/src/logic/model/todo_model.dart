class TodoModel {
  final String title;
  final bool isCompleted;
  final String? content;
  final int color;
  final String category;
  final DateTime? createdAt;

  TodoModel({
    required this.isCompleted,
    required this.title,
    this.content,
    required this.color,
    required this.category,
    this.createdAt,
  });
}
