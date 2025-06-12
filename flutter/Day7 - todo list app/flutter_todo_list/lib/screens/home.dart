import 'package:flutter/material.dart';
import 'package:flutter_todo_list/model/todo.dart';
import 'package:flutter_todo_list/screens/add_todo_form.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Dialog
  void _showDialog(BuildContext context, index) {
    final TextEditingController controller = TextEditingController(
      text: todo[index].title,
    );
    Status status = todo[index].status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit a ToDo (${todo[index].title})',
            style: TextStyle(fontSize: 18),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  DropdownButton<Status>(
                    value: status,
                    items: Status.values.map((Status key) {
                      return DropdownMenuItem<Status>(
                        value: key,
                        child: Text(key.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        status = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todo[index].title = controller.text;
                  todo[index].status = status;
                });
                Navigator.pop(context);
              },
              child: Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todo.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => const AddForm()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.create, color: Colors.white),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            String title = todo[index].title;
            DateTime created = todo[index].created;
            String formattedDate = DateFormat(
              'yyyy-MM-dd – HH:mm',
            ).format(created);
            String status = todo[index].status.title;
            Icon statusIcon = todo[index].status.statusIcon;
            return ListTile(
              tileColor: Colors.blueAccent,
              textColor: Colors.white,
              leading: Text(
                '${index + 1}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status : $status', style: TextStyle(fontSize: 16)),
                  Text(
                    'Created : $formattedDate',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              trailing: statusIcon,
              onTap: () => _showDialog(context, index), // show dialog
            );
          },
          itemCount: todo.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
        ),
      ),
    );
  }
}
