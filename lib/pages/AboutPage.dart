import 'package:flutter/material.dart';

import '../ServiceLocator.dart';
import '../Services.dart';

class AboutPage extends StatelessWidget {

  final Brightness theme;

  const AboutPage({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors:

            theme == Brightness.light ?
            [
              Colors.white60,
              Colors.deepPurpleAccent
            ]
                :
            [
              Colors.blueGrey,
              Colors.deepPurple
            ],
              begin:Alignment.topRight,
              end: Alignment.bottomLeft
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const FlutterLogo(
                size: 75.0,
              ),
              const SizedBox(height: 5),
              const Text('Author：Chris Chen',
                  style:
                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text('This app is only for learning purposes'),
              const SizedBox(height: 5),
              GestureDetector(
                child: Text(
                  'Github：https://github.com/freestyletime',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      decoration:
                      TextDecoration.combine([TextDecoration.underline])),
                ),
                onTap: () {
                  locator<Services>().launchURL('https://github.com/freestyletime');
                },
              )
            ],
          ),
        ));
  }
}
