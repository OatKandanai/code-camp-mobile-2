import 'package:flutter/material.dart';
import 'package:flutter_todo_list/model/todo.dart';
import 'package:flutter_todo_list/screens/home.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  late final _formKey = GlobalKey<FormState>();
  String _title = '';
  Status _status = Status.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      appBar: AppBar(
        title: const Text(
          'Add To-Do',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                maxLength: 20,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Input Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueAccent,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.done_all_outlined,
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _status,
                validator: (value) =>
                    value == null ? 'Please Select Status' : null,
                items: Status.values.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Text(
                      key.title,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      todo.add(
                        Todo(
                          title: _title,
                          created: DateTime.now(),
                          status: _status,
                        ),
                      );
                      _formKey.currentState!.reset();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (ctx) => const Home()),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
