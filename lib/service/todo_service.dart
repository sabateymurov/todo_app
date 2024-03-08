import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:todo_app/model/todo.dart';

class TodoService {
  String url = 'https://dummyjson.com/todos';
  String addUrl = 'https://dummyjson.com/todos/add';

  Future<List<Todo>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));

    List<dynamic> resp = jsonDecode(response.body)['todos'];
    List<Todo> todos = List.empty(growable: true);

    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == false) {
        todos.add(task);
      }
    });

    return todos;
  }

  Future<List<Todo>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));

    List<dynamic> resp = jsonDecode(response.body)['todos'];
    List<Todo> todos = List.empty(growable: true);

    resp.forEach((element) {
      Todo task = Todo.fromJson(element);
      if (task.completed! == true) {
        todos.add(task);
      }
    });
    return todos;
  }

  Future<String> addTodo(Todo newTodo) async {
    final response = await http.post(Uri.parse(addUrl),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(newTodo.toJson()));

    print(response.body);

    return response.body;
  }
}
