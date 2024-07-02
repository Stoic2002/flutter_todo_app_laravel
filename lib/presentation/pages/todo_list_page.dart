import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_laravel/domain/entities/todo.dart';
import 'package:flutter_todo_app_laravel/presentation/pages/todo_form_page.dart';
import 'package:flutter_todo_app_laravel/presentation/widgets/todo_list_item.dart';
import '../bloc/todo_bloc.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return TodoListItem(
                  todo: state.todos[index],
                  onComplete: (bool? value) {
                    if (value != null) {
                      final todo = state.todos[index];
                      final updatedTodo = Todo(
                        id: todo.id,
                        title: todo.title,
                        description: todo.description,
                        dueDate: todo.dueDate,
                        isCompleted: value,
                      );
                      context
                          .read<TodoBloc>()
                          .add(UpdateTodoEvent(updatedTodo));
                    }
                  },
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No todos found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<TodoBloc>(context),
                child: const TodoFormPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
