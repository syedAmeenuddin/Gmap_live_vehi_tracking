import 'package:flutter/material.dart';

class Kloader extends StatelessWidget {
  const Kloader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
