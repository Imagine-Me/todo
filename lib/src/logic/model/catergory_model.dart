class CategoryModel {
  final int? id;
  final String category;
  final int totalTasks;
  final int completedTasks;
  final int color;
  final bool isSelected;

  CategoryModel({
    required this.category,
    required this.totalTasks,
    required this.completedTasks,
    required this.color,
    this.id,
    required this.isSelected,
  });

  double get progress {
    double progress = completedTasks / totalTasks;
    if (progress.isNaN) {
      progress = 0;
    }
    return progress;
  }
}
