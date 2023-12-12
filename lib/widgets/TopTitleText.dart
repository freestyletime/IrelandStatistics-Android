import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitleText extends StatelessWidget {

  const TopTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.all(10),
      child: const Text('Top 50 List', style: TextStyle(fontSize: 18)),

    );
  }
}
