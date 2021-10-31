part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategory extends CategoryEvent {
  final List<Category> categories;

  GetCategory({this.categories = const []});
}

class AddCategory extends CategoryEvent {
  final CategoriesCompanion category;
  AddCategory({required this.category});
}

class DeleteCategory extends CategoryEvent {
  final CategoriesCompanion category;

  DeleteCategory({required this.category});
}
