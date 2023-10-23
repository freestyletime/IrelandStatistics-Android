import 'package:flutter/material.dart';
import 'package:irelandstatistics/pages/Splash.dart';

void main() {
  runApp(const IrelandStatistics());
}

class IrelandStatistics extends StatelessWidget {
  const IrelandStatistics({super.key});
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'IrelandStatistics',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{

      },
      home: const SplashPage(),
    );
  }
}


