import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

import '../Constants.dart';
import '../main.dart';
import '../models/local/Channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  // home data from local json configuration file
  late List<Channel> channels;

  Future<String> _initChannelData() async {
    channels = <Channel>[];
    var value = await rootBundle.loadString("assets/config/home.json");
    setState(() {
      List<dynamic> data = json.decode(value);

      for (var tmp in data) {
        channels.add(Channel.fromJson(tmp));
      }
    });
    return "success";
  }

  @override
  void initState() {
    super.initState();
    _initChannelData();
  }

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: const Text(Strings.page_title_home)
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: channels.map((Channel c) {
        return Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Text(c.channelName ?? '')
        );
      }).toList()
    );
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
