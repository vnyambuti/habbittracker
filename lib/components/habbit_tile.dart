import 'package:flutter/material.dart';

class HabbitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  const HabbitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.secondary),
      child: ListTile(
        title: Text(text),
        leading: Checkbox(value: isCompleted, onChanged: onChanged),
      ),
    );
  }
}
