import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final bool isCompleted;

  const Todo({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, title, description, dueDate, isCompleted];
}
