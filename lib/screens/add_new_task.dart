import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/task_type.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_service.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});

  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TodoService todoService = TodoService();

  TaskType taskType = TaskType.note;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 10,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'lib/assets/images/add_new_task_header.png'))),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                          size: 40,
                        )),
                    const Expanded(
                      child: Text(
                        'Add New Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Task Title',
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Task Title')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Category'),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          taskType = TaskType.note;
                        });

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Category is selected'),
                          duration: Duration(milliseconds: 300),
                        ));
                      },
                      child: Image.asset('lib/assets/images/category.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          taskType = TaskType.calendar;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Category is selected'),
                          duration: Duration(milliseconds: 300),
                        ));
                      },
                      child: Image.asset('lib/assets/images/category1.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          taskType = TaskType.contest;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Category is selected'),
                          duration: Duration(milliseconds: 300),
                        ));
                      },
                      child: Image.asset('lib/assets/images/category2.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('UserId'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextField(
                              controller: userIdController,
                              decoration: const InputDecoration(
                                  hintText: 'Date',
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(children: [
                      const Text('Time'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller: timeController,
                          decoration: const InputDecoration(
                              hintText: 'Time',
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      )
                    ]))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Description'),
              ),
              SizedBox(
                height: 300,
                child: TextField(
                  controller: descriptionController,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Note',
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 40),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 200),
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Color((0xFF5E35B1))),
                  onPressed: () {
                    /*Task newTask = Task(
                        type: taskType,
                        title: titleController.text,
                        description: descriptionController.text,
                        isCompleted: false);
                    widget.addNewTask(newTask);*/
                    saveTodo();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    Todo newTodo = Todo(
        id: -1,
        todo: titleController.text,
        completed: false,
        userId: int.parse(userIdController.text));

    todoService.addTodo(newTodo);
  }
}
