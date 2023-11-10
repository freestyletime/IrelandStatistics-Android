import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/pages/workpermit/WorkPermitPage.dart';

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

  Future<void> _initChannelData() async {
    channels = <Channel>[];
    var value = await rootBundle.loadString('assets/config/home.json');
    setState(() {
      List<dynamic> data = json.decode(value);
      for (var tmp in data) {
        channels.add(Channel.fromJson(tmp));
      }
    });
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
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: channels.map((Channel c) {
          return InkWell(
              onTap: () {
                switch (c.channelId) {
                  case "0":
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkPermitPage(data: c.subChannels!)),
                    );
                    break;
                }
              },
              child: Container(
                  color: theme == Brightness.light
                      ? Colors.teal[100]
                      : Colors.blueGrey,
                  child: Center(
                    child: Text(c.channelName ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  )));
        }).toList());
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: theme == Brightness.light ? const Icon(
          Icons.brightness_4_outlined) : const Icon(
          Icons.brightness_4_rounded),
      onPressed: () {
        setState(() {
          theme = context.read<ThemeCubit>().toggleTheme();
        });
      },
    );
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
  }
}
