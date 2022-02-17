import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';

import '../models/models.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void initState() {
    _dateController.text = date.ddMMYYYY();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoManager = context.read<TodoManager>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: _titleValidate,
            controller: _titleController,
            maxLength: 150,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: SizeConfig.defaultPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  enabled: false,
                  controller: _dateController,
                  decoration: const InputDecoration(label: Text('Date')),
                ),
              ),
              TextButton(
                child: const Text('sDP'),
                // icon: const Icon(Icons.calendar_month),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000, 1, 1),
                    lastDate: DateTime(2100, 12, 31),
                  );
                  if (selectedDate != null) {
                    date = selectedDate;
                    _dateController.text = date.ddMMYYYY();
                  }
                },
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  todoManager.addTodo(
                    Todo(title: _titleController.text, date: date),
                  );
                  Navigator.pop(context);
                } else {}
              },
              child: const Padding(
                padding: EdgeInsets.all(SizeConfig.defaultPadding * 2),
                child: Text('Add', style: TextStyle(fontSize: 16)),
              ),
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
    );
  }

  String? _titleValidate(title) {
    if (title == null || title.isEmpty) {
      return 'You must enter a todo title';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
