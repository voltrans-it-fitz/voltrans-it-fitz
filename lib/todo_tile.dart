import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/todo_manager.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodoManager>(context).todos[index];
    var lineThrough = TextStyle(
      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
    );
    return Dismissible(
      background: Container(color: Colors.red),
      onDismissed: (_) =>
          Provider.of<TodoManager>(context, listen: false).deleteTodo(index),
      direction: DismissDirection.endToStart,
      key: UniqueKey(), // key distinguishes it from the other items
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          title: Text(todo.title, style: lineThrough),
          trailing: Checkbox(
            value: todo.isCompleted,
            onChanged: (v) {
              Provider.of<TodoManager>(context, listen: false)
                  .toggleTodo(index);
            },
          ),
          subtitle: Text(todo.formattedDate, style: lineThrough),
        ),
      ),
    );
  }
}
