// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final int? category;
  final bool isCompleted;
  final DateTime? remindAt;
  final DateTime? isCreatedAt;
  final int? notification;
  Todo(
      {required this.id,
      required this.title,
      this.category,
      required this.isCompleted,
      this.remindAt,
      this.isCreatedAt,
      this.notification});
  factory Todo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Todo(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      isCompleted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_completed'])!,
      remindAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}remind_at']),
      isCreatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_created_at']),
      notification: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notification']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || remindAt != null) {
      map['remind_at'] = Variable<DateTime?>(remindAt);
    }
    if (!nullToAbsent || isCreatedAt != null) {
      map['is_created_at'] = Variable<DateTime?>(isCreatedAt);
    }
    if (!nullToAbsent || notification != null) {
      map['notification'] = Variable<int?>(notification);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isCompleted: Value(isCompleted),
      remindAt: remindAt == null && nullToAbsent
          ? const Value.absent()
          : Value(remindAt),
      isCreatedAt: isCreatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(isCreatedAt),
      notification: notification == null && nullToAbsent
          ? const Value.absent()
          : Value(notification),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<int?>(json['category']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      remindAt: serializer.fromJson<DateTime?>(json['remindAt']),
      isCreatedAt: serializer.fromJson<DateTime?>(json['isCreatedAt']),
      notification: serializer.fromJson<int?>(json['notification']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<int?>(category),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'remindAt': serializer.toJson<DateTime?>(remindAt),
      'isCreatedAt': serializer.toJson<DateTime?>(isCreatedAt),
      'notification': serializer.toJson<int?>(notification),
    };
  }

  Todo copyWith(
          {int? id,
          String? title,
          int? category,
          bool? isCompleted,
          DateTime? remindAt,
          DateTime? isCreatedAt,
          int? notification}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        category: category ?? this.category,
        isCompleted: isCompleted ?? this.isCompleted,
        remindAt: remindAt ?? this.remindAt,
        isCreatedAt: isCreatedAt ?? this.isCreatedAt,
        notification: notification ?? this.notification,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('remindAt: $remindAt, ')
          ..write('isCreatedAt: $isCreatedAt, ')
          ..write('notification: $notification')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, category, isCompleted, remindAt, isCreatedAt, notification);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.isCompleted == this.isCompleted &&
          other.remindAt == this.remindAt &&
          other.isCreatedAt == this.isCreatedAt &&
          other.notification == this.notification);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> category;
  final Value<bool> isCompleted;
  final Value<DateTime?> remindAt;
  final Value<DateTime?> isCreatedAt;
  final Value<int?> notification;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.remindAt = const Value.absent(),
    this.isCreatedAt = const Value.absent(),
    this.notification = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.category = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.remindAt = const Value.absent(),
    this.isCreatedAt = const Value.absent(),
    this.notification = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int?>? category,
    Expression<bool>? isCompleted,
    Expression<DateTime?>? remindAt,
    Expression<DateTime?>? isCreatedAt,
    Expression<int?>? notification,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (remindAt != null) 'remind_at': remindAt,
      if (isCreatedAt != null) 'is_created_at': isCreatedAt,
      if (notification != null) 'notification': notification,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int?>? category,
      Value<bool>? isCompleted,
      Value<DateTime?>? remindAt,
      Value<DateTime?>? isCreatedAt,
      Value<int?>? notification}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      remindAt: remindAt ?? this.remindAt,
      isCreatedAt: isCreatedAt ?? this.isCreatedAt,
      notification: notification ?? this.notification,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (remindAt.present) {
      map['remind_at'] = Variable<DateTime?>(remindAt.value);
    }
    if (isCreatedAt.present) {
      map['is_created_at'] = Variable<DateTime?>(isCreatedAt.value);
    }
    if (notification.present) {
      map['notification'] = Variable<int?>(notification.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('remindAt: $remindAt, ')
          ..write('isCreatedAt: $isCreatedAt, ')
          ..write('notification: $notification')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TodosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  late final GeneratedColumn<bool?> isCompleted = GeneratedColumn<bool?>(
      'is_completed', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_completed IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _remindAtMeta = const VerificationMeta('remindAt');
  late final GeneratedColumn<DateTime?> remindAt = GeneratedColumn<DateTime?>(
      'remind_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _isCreatedAtMeta =
      const VerificationMeta('isCreatedAt');
  late final GeneratedColumn<DateTime?> isCreatedAt =
      GeneratedColumn<DateTime?>('is_created_at', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _notificationMeta =
      const VerificationMeta('notification');
  late final GeneratedColumn<int?> notification = GeneratedColumn<int?>(
      'notification', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, category, isCompleted, remindAt, isCreatedAt, notification];
  @override
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('remind_at')) {
      context.handle(_remindAtMeta,
          remindAt.isAcceptableOrUnknown(data['remind_at']!, _remindAtMeta));
    }
    if (data.containsKey('is_created_at')) {
      context.handle(
          _isCreatedAtMeta,
          isCreatedAt.isAcceptableOrUnknown(
              data['is_created_at']!, _isCreatedAtMeta));
    }
    if (data.containsKey('notification')) {
      context.handle(
          _notificationMeta,
          notification.isAcceptableOrUnknown(
              data['notification']!, _notificationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Todo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String category;
  final String color;
  Category({required this.id, required this.category, required this.color});
  factory Category.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Category(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category'])!,
      color: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['color'] = Variable<String>(color);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      category: Value(category),
      color: Value(color),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      color: serializer.fromJson<String>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'color': serializer.toJson<String>(color),
    };
  }

  Category copyWith({int? id, String? category, String? color}) => Category(
        id: id ?? this.id,
        category: category ?? this.category,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.category == this.category &&
          other.color == this.color);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> color;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.color = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String color,
  })  : category = Value(category),
        color = Value(color);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (color != null) 'color': color,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id, Value<String>? category, Value<String>? color}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  late final GeneratedColumn<String?> color = GeneratedColumn<String?>(
      'color', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category, color];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Category.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final bool showDrawer;
  final bool showCategory;
  final bool showTodo;
  User(
      {required this.id,
      required this.name,
      required this.showDrawer,
      required this.showCategory,
      required this.showTodo});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      showDrawer: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}show_drawer'])!,
      showCategory: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}show_category'])!,
      showTodo: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}show_todo'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['show_drawer'] = Variable<bool>(showDrawer);
    map['show_category'] = Variable<bool>(showCategory);
    map['show_todo'] = Variable<bool>(showTodo);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      showDrawer: Value(showDrawer),
      showCategory: Value(showCategory),
      showTodo: Value(showTodo),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      showDrawer: serializer.fromJson<bool>(json['showDrawer']),
      showCategory: serializer.fromJson<bool>(json['showCategory']),
      showTodo: serializer.fromJson<bool>(json['showTodo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'showDrawer': serializer.toJson<bool>(showDrawer),
      'showCategory': serializer.toJson<bool>(showCategory),
      'showTodo': serializer.toJson<bool>(showTodo),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          bool? showDrawer,
          bool? showCategory,
          bool? showTodo}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        showDrawer: showDrawer ?? this.showDrawer,
        showCategory: showCategory ?? this.showCategory,
        showTodo: showTodo ?? this.showTodo,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('showDrawer: $showDrawer, ')
          ..write('showCategory: $showCategory, ')
          ..write('showTodo: $showTodo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, showDrawer, showCategory, showTodo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.showDrawer == this.showDrawer &&
          other.showCategory == this.showCategory &&
          other.showTodo == this.showTodo);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> showDrawer;
  final Value<bool> showCategory;
  final Value<bool> showTodo;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.showDrawer = const Value.absent(),
    this.showCategory = const Value.absent(),
    this.showTodo = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.showDrawer = const Value.absent(),
    this.showCategory = const Value.absent(),
    this.showTodo = const Value.absent(),
  }) : name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? showDrawer,
    Expression<bool>? showCategory,
    Expression<bool>? showTodo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (showDrawer != null) 'show_drawer': showDrawer,
      if (showCategory != null) 'show_category': showCategory,
      if (showTodo != null) 'show_todo': showTodo,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? showDrawer,
      Value<bool>? showCategory,
      Value<bool>? showTodo}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      showDrawer: showDrawer ?? this.showDrawer,
      showCategory: showCategory ?? this.showCategory,
      showTodo: showTodo ?? this.showTodo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (showDrawer.present) {
      map['show_drawer'] = Variable<bool>(showDrawer.value);
    }
    if (showCategory.present) {
      map['show_category'] = Variable<bool>(showCategory.value);
    }
    if (showTodo.present) {
      map['show_todo'] = Variable<bool>(showTodo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('showDrawer: $showDrawer, ')
          ..write('showCategory: $showCategory, ')
          ..write('showTodo: $showTodo')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _showDrawerMeta = const VerificationMeta('showDrawer');
  late final GeneratedColumn<bool?> showDrawer = GeneratedColumn<bool?>(
      'show_drawer', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (show_drawer IN (0, 1))',
      defaultValue: const Constant(true));
  final VerificationMeta _showCategoryMeta =
      const VerificationMeta('showCategory');
  late final GeneratedColumn<bool?> showCategory = GeneratedColumn<bool?>(
      'show_category', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (show_category IN (0, 1))',
      defaultValue: const Constant(true));
  final VerificationMeta _showTodoMeta = const VerificationMeta('showTodo');
  late final GeneratedColumn<bool?> showTodo = GeneratedColumn<bool?>(
      'show_todo', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (show_todo IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, showDrawer, showCategory, showTodo];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('show_drawer')) {
      context.handle(
          _showDrawerMeta,
          showDrawer.isAcceptableOrUnknown(
              data['show_drawer']!, _showDrawerMeta));
    }
    if (data.containsKey('show_category')) {
      context.handle(
          _showCategoryMeta,
          showCategory.isAcceptableOrUnknown(
              data['show_category']!, _showCategoryMeta));
    }
    if (data.containsKey('show_todo')) {
      context.handle(_showTodoMeta,
          showTodo.isAcceptableOrUnknown(data['show_todo']!, _showTodoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;
  final String todo;
  final int? category;
  final DateTime? remindAt;
  Notification(
      {required this.id, required this.todo, this.category, this.remindAt});
  factory Notification.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Notification(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      todo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      remindAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}remind_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['todo'] = Variable<String>(todo);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    if (!nullToAbsent || remindAt != null) {
      map['remind_at'] = Variable<DateTime?>(remindAt);
    }
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      todo: Value(todo),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      remindAt: remindAt == null && nullToAbsent
          ? const Value.absent()
          : Value(remindAt),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      todo: serializer.fromJson<String>(json['todo']),
      category: serializer.fromJson<int?>(json['category']),
      remindAt: serializer.fromJson<DateTime?>(json['remindAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'todo': serializer.toJson<String>(todo),
      'category': serializer.toJson<int?>(category),
      'remindAt': serializer.toJson<DateTime?>(remindAt),
    };
  }

  Notification copyWith(
          {int? id, String? todo, int? category, DateTime? remindAt}) =>
      Notification(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        category: category ?? this.category,
        remindAt: remindAt ?? this.remindAt,
      );
  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('todo: $todo, ')
          ..write('category: $category, ')
          ..write('remindAt: $remindAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, todo, category, remindAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.todo == this.todo &&
          other.category == this.category &&
          other.remindAt == this.remindAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<String> todo;
  final Value<int?> category;
  final Value<DateTime?> remindAt;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.todo = const Value.absent(),
    this.category = const Value.absent(),
    this.remindAt = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    required String todo,
    this.category = const Value.absent(),
    this.remindAt = const Value.absent(),
  }) : todo = Value(todo);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<String>? todo,
    Expression<int?>? category,
    Expression<DateTime?>? remindAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todo != null) 'todo': todo,
      if (category != null) 'category': category,
      if (remindAt != null) 'remind_at': remindAt,
    });
  }

  NotificationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? todo,
      Value<int?>? category,
      Value<DateTime?>? remindAt}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      category: category ?? this.category,
      remindAt: remindAt ?? this.remindAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (todo.present) {
      map['todo'] = Variable<String>(todo.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    if (remindAt.present) {
      map['remind_at'] = Variable<DateTime?>(remindAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('todo: $todo, ')
          ..write('category: $category, ')
          ..write('remindAt: $remindAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NotificationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _todoMeta = const VerificationMeta('todo');
  late final GeneratedColumn<String?> todo = GeneratedColumn<String?>(
      'todo', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _remindAtMeta = const VerificationMeta('remindAt');
  late final GeneratedColumn<DateTime?> remindAt = GeneratedColumn<DateTime?>(
      'remind_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, todo, category, remindAt];
  @override
  String get aliasedName => _alias ?? 'notifications';
  @override
  String get actualTableName => 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('todo')) {
      context.handle(
          _todoMeta, todo.isAcceptableOrUnknown(data['todo']!, _todoMeta));
    } else if (isInserting) {
      context.missing(_todoMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('remind_at')) {
      context.handle(_remindAtMeta,
          remindAt.isAcceptableOrUnknown(data['remind_at']!, _remindAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Notification.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(_db, alias);
  }
}

abstract class _$TodoTable extends GeneratedDatabase {
  _$TodoTable(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodosTable todos = $TodosTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [todos, categories, users, notifications];
}
