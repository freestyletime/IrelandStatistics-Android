import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/material/floating_action_button.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

class WorkPermitNationalityPage extends StatefulWidget {
  const WorkPermitNationalityPage({super.key});

  @override
  State<WorkPermitNationalityPage> createState() => _WorkPermitNationalityPageState();
}

class _WorkPermitNationalityPageState extends BasePageState<WorkPermitNationalityPage> {

  @override
  AppBar? getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    throw UnimplementedError();
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    throw UnimplementedError();
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    // TODO: implement getFloatingActionButton
    throw UnimplementedError();
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    // TODO: implement success
  }
}
