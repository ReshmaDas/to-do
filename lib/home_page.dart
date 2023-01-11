import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utility/dialogue_box.dart';
import 'package:todo_app/utility/todo_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState(){

    //if this is the 1st time ever opening the app then create detault data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    }else {
// there already exits data
    db.loadData();

  }
    super.initState();
  }
  final _controller = TextEditingController();


  void checkBoxChange(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

    });
    db.updateDataBase();

  }
  // save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogueBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: ()=>Navigator.of(context).pop(),
          );
        },
    );
  }
  //delete Task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar:AppBar(
        title: Text('Todo'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskComplete: db.toDoList[index][1],
            onChanged: (value) => checkBoxChange(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        }
      ),
    );
  }
}
