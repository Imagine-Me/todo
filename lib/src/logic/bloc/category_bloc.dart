import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/src/database/database.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late StreamSubscription<List<Category>> tableStream;

  CategoryBloc() : super(CategoryState()) {
    on<GetCategory>((event, emit) {
      print('CATEGORY TABLE CHANGED, EMITING NEW STATE');
      emit(CategoryState(categories: event.categories));
    });
    on<AddCategory>((event, emit) {
      print('NEW CATEGORY IS ADDED');
      database.addCategory(event.category);
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
