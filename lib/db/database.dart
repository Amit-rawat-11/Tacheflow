import 'package:hive_flutter/hive_flutter.dart';

class ToDoDateBase{
  List todolist = [];

final _mybox = Hive.box('mybox');

// first time ever opening app fucntion 

void createInitialData(){
todolist = [
  ['Swipe to remove',false]
];
}


// load the data from db 

void loadData(){
todolist = _mybox.get('TODOLIST');
}

void updateData(){
_mybox.put('TODOLIST', todolist);
}


}