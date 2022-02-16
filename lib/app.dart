import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/todo_manager.dart';
import 'package:todo_app_fitz/todo_tile.dart';

import 'add_todo.dart';
import 'config.dart';

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
          body: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: SizeConfig.defaultPadding * 0.5,
            ),
            padding: const EdgeInsets.all(SizeConfig.defaultPadding),
            shrinkWrap: true,
            itemCount: _todoManager.todos.length,
            itemBuilder: (context, index) => TodoTile(index),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTodoPage()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class MyTodoAppBar extends AppBar {
  // ignore: annotate_overrides, overridden_fields
  final double toolbarHeight;
  final Widget heading;
  final Widget subtitle;
  final Widget? popupMenuButton;

  MyTodoAppBar({
    Key? key,
    required this.toolbarHeight,
    required this.heading,
    required this.subtitle,
    this.popupMenuButton = const SizedBox.shrink(),
  }) : super(
          automaticallyImplyLeading: false,
          key: key,
          toolbarHeight: toolbarHeight,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(
              left: SizeConfig.defaultPadding * 3,
              top: SizeConfig.defaultPadding * 3,
              right: SizeConfig.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading,
                    popupMenuButton ?? const SizedBox.shrink(),
                  ],
                ),
                subtitle,
              ],
            ),
          ),
        );
