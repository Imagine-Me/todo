import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/src/database/database.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late final StreamSubscription<List<Category>> tableStream;

  CategoryBloc() : super(CategoryState()) {
    on<GetCategory>((event, emit) {
      emit(CategoryState(categories: event.categories));
    });
    on<AddCategory>((event, _) {
      database.addCategory(event.category);
    });

    on<DeleteCategory>((event, _) {
      database.deleteCategory(event.category);
    });
    subscribeCategoryTable();
  }

  StreamSubscription<List<Category>> subscribeCategoryTable() {
    return tableStream = database.watchCategories().listen((event) {
      add(GetCategory(categories: event));
    });
  }

  @override
  Future<void> close() {
    tableStream.cancel();
    return super.close();
  }
}
