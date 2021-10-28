part of 'todo_bloc.dart';

class TodoState {
  List<Todo> todos;
  CategoryState categoryState;
  String keyword;
  int? category;
  TodoState({
    this.todos = const [],
    required this.categoryState,
    this.keyword = '',
    this.category,
  });

  String? get categoryName {
    if (category == null) {
      return null;
    }
    final result = categoryState.categories
        .firstWhere((element) => element.id == category);
    return result.category;
  }

  List<TodoModel> get todoCard {
    return todos
        .where((element) =>
            (category == null || element.category == category) &
            (keyword == '' || element.title.contains(keyword)))
        .map((e) => TodoModel(
            title: e.title,
            color: categoryState.colors[e.category] ?? '0xff000000',
            isCompleted: e.isCompleted,
            content: e.content))
        .toList();
  }

  List<CategoryModel> get categoryCard {
    List<CategoryModel> result = categoryState.categories.map((category) {
      final int totalTasks =
          todos.where((todo) => todo.category == category.id).toList().length;
      final int completedTasks = todos
          .where((todo) => (todo.category == category.id && todo.isCompleted))
          .toList()
          .length;
      return CategoryModel(
          id: category.id,
          category: category.category,
          totalTasks: totalTasks,
          completedTasks: completedTasks,
          color: int.parse(category.color),
          isSelected: this.category == category.id);
    }).toList();
    final int totalTasks = todos.length;
    final int completedTasks =
        todos.where((todo) => todo.isCompleted).toList().length;
    result.insert(
        0,
        CategoryModel(
          id: null,
          category: 'All',
          totalTasks: totalTasks,
          completedTasks: completedTasks,
          color: 0xff6ff22e,
          isSelected: category == null,
        ));

    return result;
  }
}
