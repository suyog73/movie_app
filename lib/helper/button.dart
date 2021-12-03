import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.buttonName,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final String buttonName;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 35,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              icon,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
