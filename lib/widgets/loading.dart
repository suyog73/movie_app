import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.isLoad}) : super(key: key);
  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
