import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../todo_tile.dart';

import '../models/models.dart';
import '../todo_detail/todo_detail_page.dart';
import '../config/config.dart';
import 'my_todo_app_bar.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _todoManager = Provider.of<TodoManager>(context);
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
            subtitle: Padding(
              padding: const EdgeInsets.only(top: SizeConfig.defaultPadding),
              child: Text(
                '${_todoManager.completedTodoCount} out of ${_todoManager.todosLength}',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: SizeConfig.defaultPadding * 0.5,
                  ),
                  padding: const EdgeInsets.all(SizeConfig.defaultPadding),
                  shrinkWrap: true,
                  itemCount: _todoManager.todos.length,
                  itemBuilder: (context, index) => TodoTile(index),
                ),
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
