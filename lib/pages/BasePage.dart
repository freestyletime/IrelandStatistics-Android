import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irelandstatistics/ServiceLocator.dart';
import 'package:irelandstatistics/Services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constants.dart';
import '../events/Event.dart';
import '../models/IBean.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T> {
  // title
  AppBar? getAppBar(BuildContext context);

  // content
  Widget getBody(BuildContext context);

  // action button
  FloatingActionButton? getFloatingActionButton(BuildContext context);

  void success<E extends IBean>(String id, List<E> ts);

  late StreamSubscription s_subscription;
  late StreamSubscription d_subscription;
  late StreamSubscription c_subscription;
  late StreamSubscription f_subscription;

  // is page loading data
  var _isLoading = 0;
  var isLoading = ValueNotifier<bool>(false);

  // facade pattern
  var service = locator<Services>();

  void showSnackBar(String msg) {
    var snackBar =
        SnackBar(content: Text(msg), duration: const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    s_subscription = Constants.eventBus.on<SEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {
        if (_isLoading == 0) {
          isLoading.value = true;
        }
        _isLoading += 1;
      }
    });

    d_subscription = Constants.eventBus.on<BeanEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {
        success(event.id, event.ts);
      }
    });

    c_subscription = Constants.eventBus.on<CEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {
        _isLoading -= 1;
        if (_isLoading <= 0) {
          _isLoading = 0;
          isLoading.value = false;
        }
      }
    });

    f_subscription = Constants.eventBus.on<FEvent>().listen((event) {
      if (event.id.endsWith(hashCode.toString())) {
        showSnackBar(event.msg);
      }
    });
    super.initState();
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
    var progressWidget = Center(
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: SizedBox(
            width: 125.0,
            height: 125.0,
            child: Container(
              decoration: const ShapeDecoration(
                color: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(color: Colors.purpleAccent),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: Text(
                      Strings.msg_loading,
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.purpleAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: getAppBar(context),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, saving, _) => ModalProgressHUD(
          color: Colors.black87,
          dismissible: true,
          progressIndicator: progressWidget,
          inAsyncCall: saving,
          child: Container(child: getBody(context)),
        ),
      ),
      floatingActionButton: getFloatingActionButton(context),
    );
  }
}
