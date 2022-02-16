import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/app.dart';
import 'package:todo_app_fitz/todo_manager.dart';

import 'config.dart';
import 'todo.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

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
          body: const Padding(
            padding: EdgeInsets.all(SizeConfig.defaultPadding * 3),
            child: TodoForm(),
          ),
        ),
      ),
    );
  }
}

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoManager = context.read<TodoManager>();
    final today = DateTime.now();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'You must enter a todo title';
              } else {
                return null;
              }
            },
            controller: _titleController,
            decoration: InputDecoration(
              label: const Text('Title'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  SizeConfig.defaultRadius * 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: SizeConfig.defaultPadding * 2),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding * 1.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('dd MMMM yyyy').format(DateTime.now())),
                IconButton(
                  icon: Icon(Icons.calendar_month, color: Colors.black),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: today,
                      firstDate: DateTime(2000, 1, 1),
                      lastDate: DateTime(2100, 12, 31),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SizeConfig.defaultPadding,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    todoManager.addTodo(Todo(
                      title: _titleController.text,
                      id: _titleController.text,
                      date: DateTime.now(),
                    ));
                    Navigator.pop(context);
                  } else {}
                },
                child: const Text('Add'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const StadiumBorder(
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
