// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool _watchLater = false;

class WatchLaterButton extends StatefulWidget {
  const WatchLaterButton({Key? key}) : super(key: key);

  @override
  State<WatchLaterButton> createState() => _WatchLaterButtonState();
}

class _WatchLaterButtonState extends State<WatchLaterButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _watchLater = !_watchLater;
        });
      },
      child: Icon(
        _watchLater ? FontAwesomeIcons.solidClock : FontAwesomeIcons.clock,
        color: Color(0xFF05a823),
        size: 28,
      ),
    );
  }
}
