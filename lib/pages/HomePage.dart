import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

import '../Constants.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: const Text(Strings.page_title_home)
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return const Center(child: Text('Hello World!'),);
  }

  @override
  Widget? getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.brightness_6),
      onPressed: () {
        context.read<ThemeCubit>().toggleTheme();
        showSnackBar(context, 'theme change!');
      },
    );
  }
}
