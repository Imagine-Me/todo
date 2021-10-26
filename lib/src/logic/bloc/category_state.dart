part of 'category_bloc.dart';

// @immutable
// abstract class CategoryState {}

// class CategoryLoading extends CategoryState {}

// class CategoryLoaded extends CategoryState {

// }
class CategoryState {
  CategoryState({this.categories = const []});
  List<Category> categories;
  List<Category> get categoriesOrdered => categories.reversed.toList();
}
