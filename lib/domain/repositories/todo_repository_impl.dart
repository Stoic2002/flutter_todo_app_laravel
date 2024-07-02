import 'package:flutter_todo_app_laravel/data/datasources/todo_remote_data_source.dart';
import 'package:flutter_todo_app_laravel/domain/repositories/todo_repository.dart';

import '../../data/models/todo_model.dart';
import '../../domain/entities/todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Todo>> getTodos() async {
    final todoModels = await remoteDataSource.getTodos();
    return todoModels;
  }

  @override
  Future<Todo> addTodo(Todo todo) async {
    final todoModel = TodoModel(
      title: todo.title,
      description: todo.description,
      dueDate: todo.dueDate,
      isCompleted: todo.isCompleted,
    );
    return await remoteDataSource.addTodo(todoModel);
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    final todoModel = TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      dueDate: todo.dueDate,
      isCompleted: todo.isCompleted,
    );
    return await remoteDataSource.updateTodo(todoModel);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await remoteDataSource.deleteTodo(id);
  }
}
