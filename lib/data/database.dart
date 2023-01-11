import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box

  final _myBox = Hive.box('mybox');


  //run this method if this is the 1st time ever open this app
  void createInitialData(){
    toDoList = [
      ['Make Tutorial', false],
      ['Do Exercise',false],
    ];
  }

  //load dataBase from dataBase
  void loadData(){
    toDoList = _myBox.get('TODOLIST');

  }

  //update dataBase
  void updateDataBase(){
    _myBox.put('TODOLIST', toDoList);
  }
}
