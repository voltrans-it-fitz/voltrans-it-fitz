import 'package:flutter/material.dart';

import 'todo.dart';

class TodoTile extends StatefulWidget {
  const TodoTile(
    this.todo, {
    required this.onSwipe,
    Key? key,
  }) : super(key: key);
  final Todo todo;
  final Function(dynamic) onSwipe;
  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      onDismissed: widget.onSwipe,
      direction: DismissDirection.endToStart,
      key: GlobalKey(),
      child: Card(
        child: ListTile(
          title: Text(
            widget.todo.title,
            style: TextStyle(
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            value: isCompleted,
            onChanged: (newValue) {
              setState(() => isCompleted = newValue ?? false);
            },
          ),
          subtitle: Text(widget.todo.formattedDate),
        ),
      ),
    );
  }
}
