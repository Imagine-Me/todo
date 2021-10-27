class CategoryModel {
  final String category;
  final int totalTasks;
  final int completedTasks;
  final int color;

  CategoryModel(
      {required this.category,
      required this.totalTasks,
      required this.completedTasks,
      required this.color});

  double get progress {
    double progress = completedTasks / totalTasks;
    if (progress.isNaN) {
      progress = 0;
    }
    return progress;
  }
}

