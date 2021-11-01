part of 'category_bloc.dart';

// @immutable
// abstract class CategoryState {}

// class CategoryLoading extends CategoryState {}

// class CategoryLoaded extends CategoryState {

// }
class CategoryState {
  CategoryState({this.categories = const []});
  List<Category> categories;

  Map<int, String> get colors =>
      {for (Category category in categories) category.id: category.color};
}
