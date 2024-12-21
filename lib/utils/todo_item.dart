import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String task;
  final bool iscompleted;
  final Function(bool?) onChanged;

  const TodoItem({
    super.key,
    required this.task,
    required this.iscompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 23, left: 28, right: 28),
      child: Container(
        height: 78,
        width: 332,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.3,
              child: Checkbox(
                value: iscompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
                checkColor: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Expanded( // Makes sure the text can expand within available space
              child: Text(
                task,
      
                style:  TextStyle(fontSize: 16,decoration: iscompleted? TextDecoration.lineThrough:null),
                softWrap: true, // Ensures wrapping to the next line
              ),
            ),
          ],
        ),
      ),
    );
  }
}
