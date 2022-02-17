import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../todo_detail/todo_detail_page.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(this.todo, {Key? key}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    var lineThrough = TextStyle(
      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
    );

    return Dismissible(
      background: Container(color: Colors.red),
      onDismissed: (_) => Provider.of<TodoManager>(
        context,
        listen: false,
      ).deleteTodo(todo.id),
      direction: DismissDirection.endToStart,
      key: UniqueKey(), // key distinguishes it from the other items
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TodoDetailPage(todo: todo)),
          );
        },
        child: Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            title: Text(
              todo.title,
              style: lineThrough,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (v) {
                Provider.of<TodoManager>(context, listen: false)
                    .toggleTodo(id: todo.id);
              },
            ),
            subtitle: Text(todo.formattedDate, style: lineThrough),
          ),
        ),
      ),
    );
  }
}
