part of 'todo_bloc.dart';

class TodoState {
  List<Todo> todos;
  CategoryState categoryState;
  TodoState({
    this.todos = const [],
    required this.categoryState,
  });

  List<TodoModel> get todoCard {
    return todos
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
          category: category.category,
          totalTasks: totalTasks,
          completedTasks: completedTasks,
          color: int.parse(category.color));
    }).toList();
    final int totalTasks = todos.length;
    final int completedTasks =
        todos.where((todo) => todo.isCompleted).toList().length;
    result.insert(
        0,
        CategoryModel(
            category: 'All',
            totalTasks: totalTasks,
            completedTasks: completedTasks,
            color: 0xff6ff22e));

    return result;
  }
}
