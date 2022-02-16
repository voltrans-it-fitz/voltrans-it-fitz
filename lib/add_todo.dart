import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Container(
      color: ThemeData().primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height * 0.18,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Add new Todo',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
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
        ),
      ),
    );
  }
}
