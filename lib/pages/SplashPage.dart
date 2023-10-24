import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irelandstatistics/pages/HomePage.dart';

import '../main.dart';
class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
              title: 'IrelandStatistics',
              theme: theme,
              home: const HomePage()
          );
        }
    );
  }
}
