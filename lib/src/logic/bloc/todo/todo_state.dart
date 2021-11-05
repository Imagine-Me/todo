part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  final List<Todo> todos;
  final CategoryState categoryState;
  final int? category;
  const TodoState({
    this.todos = const [],
    required this.categoryState,
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
        .where((element) => (category == null || element.category == category))
        .map((e) => TodoModel(
            title: e.title,
            color: categoryState.colors[e.category] ?? '0xff000000',
            isCompleted: e.isCompleted,))
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

class TodoInitial extends TodoState {
  const TodoInitial({required CategoryState categoryState})
      : super(categoryState: categoryState);
}

class TodoLoaded extends TodoState with EquatableMixin {
  const TodoLoaded(
      {required CategoryState categoryState,
      int? category,
      required List<Todo> todos})
      : super(categoryState: categoryState, category: category, todos: todos);

  @override
  List<Object?> get props => todos.isEmpty
      ? [todos, categoryState]
      : [
          ...todos.map((e) => e.title).toList(),
          ...todos.map((e) => e.isCompleted).toList(),
          ...todos.map((e) => e.id).toList(),
          ...todos.map((e) => e.remindAt).toList(),
          ...todos.map((e) => e.notification).toList(),
          category,
          categoryState
        ];

  @override
  bool? get stringify => true;
}
