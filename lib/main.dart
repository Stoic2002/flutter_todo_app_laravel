import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app_laravel/data/datasources/todo_remote_data_source.dart';
import 'package:flutter_todo_app_laravel/domain/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_app_laravel/domain/usecases/add_todo.dart';
import 'package:flutter_todo_app_laravel/presentation/pages/todo_list_page.dart';
import 'package:http/http.dart' as http;
import 'domain/usecases/delete_todo.dart';
import 'domain/usecases/get_todos.dart';
import 'domain/usecases/update_todo.dart';
import 'presentation/bloc/todo_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Pindahkan BlocProvider ke level tertinggi
    return BlocProvider(
      create: (context) {
        final todoRemoteDataSource =
            TodoRemoteDataSourceImpl(client: http.Client());
        final todoRepository =
            TodoRepositoryImpl(remoteDataSource: todoRemoteDataSource);
        return TodoBloc(
          GetTodos(todoRepository),
          AddTodo(todoRepository),
          UpdateTodo(todoRepository),
          DeleteTodo(todoRepository),
        )..add(LoadTodos());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoListPage(),
      ),
    );
  }
}
