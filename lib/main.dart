import 'package:flutter/material.dart';

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todoItems = [];

  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(TodoItem(task));
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].toggleCompleted();
    });
  }

  void _promptAddTodoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';

        return AlertDialog(
          title: const Text('Nueva Tarea'),
          content: TextField(
            onChanged: (String value) {
              newTask = value;
            },
            decoration: const InputDecoration(hintText: 'Escribe la tarea aquí'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
              Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Agregar'),
                onPressed: () {
                if (newTask.isNotEmpty) {
                _addTodoItem(newTask);
                 Navigator.of(context).pop();
                }
              },
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
        title: const Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _todoItems[index].task,
              style: TextStyle(
                decoration: _todoItems[index].isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: _todoItems[index].isCompleted,
              onChanged: (bool? value) {
                _toggleTodoItem(index);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _removeTodoItem(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Agregar Tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  final String task;
  bool isCompleted;

  TodoItem(this.task) : isCompleted = false;

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
