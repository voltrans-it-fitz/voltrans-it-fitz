import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../config/config.dart';

import '../models/models.dart';

class TodoForm extends StatefulWidget {
  const TodoForm(this.todo, {Key? key}) : super(key: key);
  final Todo? todo;
  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  late DateTime date;

  @override
  void initState() {
    date = widget.todo?.date ?? DateTime.now();
    _dateController.text = date.ddMMYYYY();
    _titleController.text = widget.todo?.title ?? '';
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
              hintText: 'Your Todo Title',
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
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.calendar,
                  color: Colors.blue,
                ),
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
                  var todo = Todo(title: _titleController.text, date: date);
                  var isEditting = widget.todo != null;

                  if (isEditting) {
                    todoManager.updateTodo(widget.todo!.id, todo);
                  } else {
                    todoManager.addTodo(todo);
                  }

                  Navigator.pop(context);
                } else {}
              },
              child: Padding(
                padding: const EdgeInsets.all(SizeConfig.defaultPadding * 2),
                child: Text(
                  (widget.todo == null) ? 'Add' : 'Update',
                  style: const TextStyle(fontSize: 16),
                ),
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
