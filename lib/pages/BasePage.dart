import 'package:flutter/material.dart';
import 'package:irelandstatistics/ServiceLocator.dart';
import 'package:irelandstatistics/Services.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T> {
  // title
  AppBar getAppBar(BuildContext context);
  // content
  Widget getBody(BuildContext context);
  // floating action button
  Widget? getFloatingActionButton(BuildContext context);
  // facade pattern
  var service = locator<Services>();

  void showSnackBar(BuildContext context, String msg) {
    var snackBar = SnackBar(content: Text(msg), duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueGrey,
                  Colors.black,
                ]),
          ),
          child: getBody(context)),
          floatingActionButton: getFloatingActionButton(context),
    );
  }
}