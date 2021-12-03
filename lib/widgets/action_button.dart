import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.color,
    required this.buttonName,
    required this.icon,
  }) : super(key: key);

  final Color color;
  final String buttonName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Color colors = buttonName == 'Save' ? Colors.lightBlueAccent : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: colors,
        border: Border.all(
          color: color,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            buttonName,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
