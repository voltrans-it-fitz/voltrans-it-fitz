import 'package:flutter/material.dart';

import '../config/config.dart';
import '../home/my_todo_app_bar.dart';
import '../models/models.dart';
import 'todo_form.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({Key? key, this.todo}) : super(key: key);
  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeData().primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyTodoAppBar(
            toolbarHeight:
                MediaQuery.of(context).size.height * SizeConfig.appBarRatio,
            heading: IconButton(
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.symmetric(
                vertical: SizeConfig.defaultPadding,
              ),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            subtitle: Text(
              'Add new Todo',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(SizeConfig.defaultPadding * 3),
            child: TodoForm(todo),
          ),
        ),
      ),
    );
  }
}
