// ignore_for_file: must_call_super

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tacheflow/db/database.dart';
import 'package:tacheflow/utils/todo_item.dart';

import '../utils/date_format.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _mybox = Hive.box('mybox');
  ToDoDateBase db = ToDoDateBase();

  @override
  void initState() {
    if(_mybox.get('TODOLIST')== null){
      db.createInitialData();
    }
    else{
      db.loadData();
      }

      super.initState();
  }
  

  void taskclicked(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
      db.updateData();
    });
  }

  String getGreeting() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }
  String getTaskProgress() {
  int completedTasks = db.todolist.where((task) => task[1] == true).length;
  int totalTasks = db.todolist.length;

  return "You've completed $completedTasks tasks out of $totalTasks. Keep going! 🙌💫";
}


  void addNewTask(){
    setState(() {
      db.todolist.add([newtask.text,false]);
      db.updateData();
      // print("Item addedd!!!");
      newtask.clear();  
    });
  }

void deleteTask(int index){
  print(index);
    setState(() {
      db.todolist.removeAt(index);
      db.updateData();
       
    });
  }


  TextEditingController newtask = TextEditingController();

final int month = DateTime.now().month;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
                shape: BoxShape.rectangle),
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    getGreeting(),
                    style: const TextStyle(fontSize: 32),
                  ),
                  const Text(
                    "Let's make today productive and fulfilling! ☺️ ",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        "Today is $date ${monthName(month)} $year . A great day to conquer your goals!",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                   Center(
                    child: SizedBox(
                      width: 220,
                      child: Text(
                        getTaskProgress(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: db.todolist.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  task: db.todolist[index][0],
                  iscompleted: db.todolist[index][1],
                  onChanged: (value) => taskclicked(value, index),
                );
              },
            ),
          ),
          Padding(
            
            padding:
                const EdgeInsets.only(bottom: 18, top: 18, left: 35, right: 25),
            child: Row(
              
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: 278,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: TextFormField(
                    controller: newtask,
                    decoration: const InputDecoration(
                        hintText: 'Add New Task', border: InputBorder.none),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  
                  height: 50,
                  child: ElevatedButton(
                    onPressed: addNewTask,
                    child: const Icon(CupertinoIcons.add,color: Colors.black,),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
