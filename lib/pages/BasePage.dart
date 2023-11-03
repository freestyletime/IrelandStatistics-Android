import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irelandstatistics/ServiceLocator.dart';
import 'package:irelandstatistics/Services.dart';

import '../Constants.dart';
import '../events/Event.dart';
import '../models/IBean.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T> {

  // title
  AppBar getAppBar(BuildContext context);
  // content
  Widget getBody(BuildContext context);
  // floating action button
  Widget? getFloatingActionButton(BuildContext context);

  void success<E extends IBean>(String id, List<E> ts);

  late StreamSubscription s_subscription;
  late StreamSubscription d_subscription;
  late StreamSubscription c_subscription;
  late StreamSubscription f_subscription;

  // facade pattern
  var service = locator<Services>();

  void showSnackBar(String msg) {
    var snackBar = SnackBar(content: Text(msg), duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    s_subscription = Constants.eventBus.on<SEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {

      }
    });

    d_subscription = Constants.eventBus.on<BeanEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {
        success(event.id, event.ts);
      }
    });

    c_subscription = Constants.eventBus.on<CEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {

      }
    });

    f_subscription = Constants.eventBus.on<FEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {
        showSnackBar(event.msg);
      }
    });
  }

  @override
  void dispose() {
    s_subscription.cancel();
    d_subscription.cancel();
    c_subscription.cancel();
    f_subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Container(
          child: getBody(context)),
          floatingActionButton: getFloatingActionButton(context),
    );
  }
}