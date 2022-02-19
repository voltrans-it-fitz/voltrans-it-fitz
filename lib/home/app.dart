import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/data/todo_repository.dart';

import '../config/config.dart';
import '../todo_detail/todo_detail_page.dart';
import 'my_todo_app_bar.dart';
import 'todo_tile.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  PopupMenuItem<String>(
                    value: '',
                    child: const Text('Show only completed'),
                    onTap: () =>
                        context.read<TodoRepository>().showCompletedTodos(),
                  ),
                ];
              },
            ),
            subtitle: const CountingTitle(),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
    return Consumer<TodoRepository>(
      builder: (_, provider, __) {
        // if ((provider as FirebaseTodoRepository).isLoading) {
        //   return Container(
        //     alignment: Alignment.center,
        //     width: double.infinity,
        //     height: MediaQuery.of(context).size.height * 0.725,
        //     // 1 - appbar height - 0.1
        //     child: const Center(child: CircularProgressIndicator()),
        //   );
        // }
        if (provider.todoCount != 0) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(
              height: SizeConfig.defaultPadding * 0.5,
            ),
            padding: const EdgeInsets.all(SizeConfig.defaultPadding),
            shrinkWrap: true,
            itemCount: provider.todos.length,
            itemBuilder: (context, index) => TodoTile(provider.todos[index]),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.725,
            // 1 - appbar height - 0.1
            child: const Text('You don\'t have any todo. Create one'),
          );
        }
      },
    );
  }
}

class CountingTitle extends StatelessWidget {
  const CountingTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoRepository>(
      builder: (_, provider, __) {
        return Text(
          '${provider.completedTodoCount} out of ${provider.todoCount}',
        );
      },
    );
  }
}
