import 'package:flutter/material.dart';

class Todo {
  String title;
  DateTime created;
  Status status;
  Todo({required this.title, required this.created, required this.status});
}

enum Status {
  pending(
    title: 'Pending',
    statusIcon: Icon(Icons.pending, color: Colors.white),
  ),
  inProgess(
    title: 'In-progess',
    statusIcon: Icon(Icons.work_history, color: Colors.white),
  ),
  completed(
    title: 'Completed',
    statusIcon: Icon(Icons.done, color: Colors.white),
  );

  final String title;
  final Icon statusIcon;
  const Status({required this.title, required this.statusIcon});
}

List<Todo> todo = [
  Todo(title: 'Pet a cat', created: DateTime.now(), status: Status.pending),
  Todo(
    title: 'Do some coding',
    created: DateTime.now(),
    status: Status.inProgess,
  ),
  Todo(
    title: 'Wash the dishes',
    created: DateTime.now(),
    status: Status.completed,
  ),
];
