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
import '../models/config/Channel.dart';
import '../widgets/EmptyCenterText.dart';

class HomePage extends StatefulWidget {
  static const String tag = 'home-page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {

  final _data = ValueNotifier<List<Channel>>([]);

  // _initChannelData() {
    // channels = <Channel>[];
    // var value = await rootBundle.loadString('assets/config/home.json');
    // setState(() {
    //   List<dynamic> data = json.decode(value);
    //   for (var tmp in data) {
    //     channels.add(Channel.fromJson(tmp));
    //   }
    // });
  // }

  @override
  void initState() {
    super.initState();
    service.getApiUIConfig().getUIConfig(HomePage.tag + hashCode.toString());
  }

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true, title: const Text(Strings.page_title_home));
  }

  @override
  Widget getBody(BuildContext context) {
    return ValueListenableBuilder<List<Channel>>(
        valueListenable: _data,
        builder: (context, data, _) {
          if (data.isEmpty) return const EmptyCenterText();

          return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: data.map((Channel c) {
                return InkWell(
                    onTap: () {
                      switch (c.channelId) {
                        case Strings.tag_home_page_work_permit:
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    WorkPermitPage(data: c.subChannels!)),
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
        });
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: theme == Brightness.light
          ? const Icon(Icons.brightness_4_outlined)
          : const Icon(Icons.brightness_4_rounded),
      onPressed: () {
        setState(() {
          theme = context.read<ThemeCubit>().toggleTheme();
        });
      },
    );
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    if (HomePage.tag + hashCode.toString() == id) {
      for (var i in ts) {
        if (i is Channel) _data.value.add(i);
      }
    }
  }
}
