import 'package:flutter/material.dart';

import 'todo.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  AddTodoPageState createState() => AddTodoPageState();
}

class AddTodoPageState extends State<AddTodoPage> {
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Todo')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
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
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(
                        context,
                        Todo(
                          title: _titleController.text,
                          id: _titleController.text,
                          date: DateTime.now(),
                        ),
                      );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
