import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/task_type.dart';
import 'package:todo_app/model/header.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';

import 'package:todo_app/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todo = ['Study Lessons', 'Run 5K', 'Go to Party'];
  // List<String> completed = ['Game meetup', 'Take out trash'];
  List<Task> todo = [
    Task(
        type: TaskType.note,
        title: 'Study Lesson',
        description: 'Study Comp117',
        isCompleted: false),
    Task(
        type: TaskType.calendar,
        title: 'Go to Party',
        description: 'Attend to Party',
        isCompleted: false),
    Task(
        type: TaskType.contest,
        title: 'Run 5K',
        description: 'Run 5 kilometers',
        isCompleted: false),
  ];
  List<Task> completed = [
    Task(
        type: TaskType.calendar,
        title: 'Game meetup',
        description: '',
        isCompleted: false),
    Task(
        type: TaskType.note,
        title: 'Take out trush',
        description: 'Study Comp117',
        isCompleted: false),
  ];

  void addNewTask(newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              //Header
              Header(deviceWidth: deviceWidth, deviceHeight: deviceHeight),
              //Top Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                    future: todoService.getUncompletedTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TodoItem(
                              task: snapshot.data![index],
                            );
                          },
                        );
                      }
                    },
                  )),
                ),
              ),

              //Completed Test
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Completed',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              //Bottom Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                      child: FutureBuilder(
                    future: todoService.getCompletedTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return TodoItem(task: snapshot.data![index]);
                          },
                        );
                      }
                    },
                  )),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 40),
                    backgroundColor: Color.fromARGB(163, 71, 14, 150),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 300),
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddNewTaskScreen(
                      addNewTask: (newTask) => addNewTask(newTask),
                    ),
                  ));
                },
                child: const Text('Add New Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
