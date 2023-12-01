
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
import '../widgets/SliverAppBarDelegate.dart';

class HomePage extends StatefulWidget {
  static const String tag = 'home-page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {

  // theme
  var theme = Brightness.light;

  final _data = ValueNotifier<List<Channel>>([]);

  SliverPersistentHeader _makeHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 35.0,
        maxHeight: 260.0,
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/header.jpeg"),
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    service.getApiUIConfig().getUIConfig(HomePage.tag + hashCode.toString());
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return null;
    // AppBar(centerTitle: true, title: const Text(Strings.page_title_home));
  }

  @override
  Widget getBody(BuildContext context) {
    Widget getFunc(String? channelId) {
      if (channelId == '0') {
        return Container(
          alignment: Alignment.center,
          child: const Text('Employment permits',
              style: TextStyle(
                fontSize: 14,
              )),
        );
      }
      return const EmptyCenterText();
    }

    return ValueListenableBuilder<List<Channel>>(
        valueListenable: _data,
        builder: (context, data, _) {
          if (data.isEmpty) return const EmptyCenterText();

          return CustomScrollView(slivers: <Widget>[
            _makeHeader(),
            SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: data.map((Channel c) {
                      return Card(
                          elevation: 5.0,
                          child: InkWell(
                          onTap: () {
                            switch (c.channelId) {
                              case Strings.tag_home_page_work_permit:
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => WorkPermitPage(
                                          data: c.subChannels,
                                          years: c.subChannelYears)),
                                );
                                break;
                            }
                          },
                          child: Container(
                              color: theme == Brightness.light
                                  ? Colors.teal[100]
                                  : Colors.blueGrey,
                              child: getFunc(c.channelId))));
                    }).toList()))
          ]);
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
      var tmp = <Channel>[];
      for (var i in ts) {
        if (i is Channel) tmp.add(i);
      }
      _data.value = tmp;
    }
  }
}
