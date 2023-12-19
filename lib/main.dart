import 'package:flutter/material.dart';
import 'package:irelandstatistics/ServiceLocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irelandstatistics/pages/SplashPage.dart';

void main() {
  initLocator();
  runApp(const IrelandStatistics());
}

class IrelandStatistics extends StatelessWidget {
  const IrelandStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const SplashPage(),
    );
  }
}

class ThemeCubit extends Cubit<ThemeData> {

  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
  );

  static final _darkTheme = ThemeData(
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey,
  );

  Brightness toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
    return state.brightness;
  }
}
