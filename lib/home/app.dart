import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../models/models.dart';
import '../todo_detail/todo_detail_page.dart';
import 'my_todo_app_bar.dart';
import 'todo_tile.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('App rebuild');
    return Container(
      color: ThemeData().primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyTodoAppBar(
            heading: Text(
              'My Todos',
              style: Theme.of(context).textTheme.headline3,
            ),
            toolbarHeight:
                MediaQuery.of(context).size.height * SizeConfig.appBarRatio,
            popupMenuButton: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<String>(
                    value: '',
                    child: Text('Show only completed'),
                  ),
                ];
              },
            ),
            subtitle: const CountingTitle(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const TodoList(),
                Divider(
                  thickness: 1.5,
                  indent: MediaQuery.of(context).size.width * 0.4,
                  endIndent: MediaQuery.of(context).size.width * 0.4,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TodoDetailPage()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoManager>(builder: (context, value, child) {
      debugPrint('Todo List rebuild');
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(
          height: SizeConfig.defaultPadding * 0.5,
        ),
        padding: const EdgeInsets.all(SizeConfig.defaultPadding),
        shrinkWrap: true,
        itemCount: value.todos.length,
        itemBuilder: (context, index) => TodoTile(value.todos[index]),
      );
    });
  }
}

class CountingTitle extends StatelessWidget {
  const CountingTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoManager>(
      builder: (_, manager, __) {
        debugPrint('Counting title rebuild');
        return Text(
          '${manager.completedTodoCount} out of ${manager.todosLength}',
        );
      },
    );
  }
}
