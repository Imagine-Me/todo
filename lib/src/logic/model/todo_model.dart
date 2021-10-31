class TodoModel {
  final String title;
  final bool isCompleted;
  final String? content;
  final String? color;

  TodoModel(
      {required this.isCompleted,
      required this.title,
      this.content,
      this.color});
}
