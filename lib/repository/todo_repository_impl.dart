import 'dart:math';

import 'package:todo_app/data_source/todo_data_source.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource _todoDataSource;

  const TodoRepositoryImpl({required TodoDataSource datasource})
    : _todoDataSource = datasource;

  Future<int> _getMaxId() async {
    final List<Todo> todos = await getTodos();

    return todos.map((e) => e.id).reduce(max);
  }

  @override
  Future<void> addTodo(String title) async {
    final Todo todo = Todo(
      userId: 1,
      id: (await _getMaxId()) + 1,
      title: title,
      completed: false,
      createdAt: DateTime.now(),
    );

    _todoDataSource.writeTodos([todo.toJson()]);
  }

  @override
  Future<void> deleteTodo(int id) async {
    final List<Todo> todos = await getTodos();

    _todoDataSource.writeTodos(
      (todos..removeWhere((element) => element.id == id))
          .map((e) => e.toJson())
          .toList(),
    );
  }

  @override
  Future<List<Todo>> getTodos() async {
    final List<Map<String, dynamic>> todoJsons =
        await _todoDataSource.readTodos();

    return todoJsons.cast<Todo>();
  }

  @override
  Future<void> toggleTodo(int id) async {
    final List<Todo> todos = await getTodos();

    Todo? todo = todos.where((element) => element.id == id).firstOrNull;

    if (todo != null) {
      final int index = todos.indexOf(todo);
      todos[index] = todo.copyWith(completed: !todo.completed);
    }

    _todoDataSource.writeTodos(todos.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> updateTodo(int id, String newTitle) async {
    final List<Todo> todos = await getTodos();

    Todo? todo = todos.where((element) => element.id == id).firstOrNull;

    if (todo != null) {
      final int index = todos.indexOf(todo);
      todos[index] = todo.copyWith(title: newTitle);
    }

    _todoDataSource.writeTodos(todos.map((e) => e.toJson()).toList());
  }

  @override
  Future<List<Todo>> getTodosByCompleted(bool completed) async {
    return (await getTodos()).where((e) => e.completed == completed).toList();
  }

  @override
  Future<List<Todo>> getTodosByCreatedAt() async {
    return (await getTodos())..sort();
  }
}
