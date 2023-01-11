import 'package:flutter/material.dart';
import 'package:todo_app/utility/my_button.dart';
class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogueBox({super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[500],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                ),
              hintText: "Add a new task",
            ),
          ),

          // buttons -> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Save button
              MyButton(text: 'Save', onPressed: onSave),
              const SizedBox(width: 8,),

              //cancel button
              MyButton(text: 'Cancel', onPressed: onCancel),
            ],
          )
        ],),
      ),
    );
  }
}
