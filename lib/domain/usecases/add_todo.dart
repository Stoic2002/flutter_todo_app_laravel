import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<Todo> call(Todo todo) async {
    return await repository.addTodo(todo);
  }
}
