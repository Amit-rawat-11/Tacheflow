import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tacheflow/db/database.dart';
import 'package:tacheflow/screens/home_screen.dart';

import 'package:tacheflow/screens/splash_screen.dart';

void main() async {
// Init hive
  await Hive.initFlutter();

//opening a boc
  var box = await Hive.openBox("mybox");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget nextscreen = SplashScreen();

  final _mybox = Hive.box('mybox');
  ToDoDateBase db = ToDoDateBase();
  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      setState(() {
        nextscreen = SplashScreen();
      });
    } else {
      nextscreen = HomeScreen();
    }
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Tache Flow ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: nextscreen,
      
    );
  }
}
