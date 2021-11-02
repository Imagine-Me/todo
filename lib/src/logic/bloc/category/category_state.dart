part of 'category_bloc.dart';

// @immutable
// abstract class CategoryState {}

// class CategoryLoading extends CategoryState {}

// class CategoryLoaded extends CategoryState {

// }
class CategoryState extends Equatable {
  CategoryState({this.categories = const []});
  List<Category> categories;

  Map<int, String> get colors =>
      {for (Category category in categories) category.id: category.color};

  @override
  List<Object?> get props => categories.isEmpty
      ? [categories]
      : [categories[0].category, categories[0].id, categories[0].color];
}
