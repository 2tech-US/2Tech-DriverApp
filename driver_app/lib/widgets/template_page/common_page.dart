import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  CommonPage({
    Key? key,
    required this.content,
  }) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, body: SafeArea(child: content));
  }
}
