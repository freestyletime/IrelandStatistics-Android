import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

import '../../Constants.dart';

class WorkPermitPage extends StatefulWidget {
  const WorkPermitPage({super.key});

  @override
  State<WorkPermitPage> createState() => _WorkPermitPageState();
}

class _WorkPermitPageState extends BasePageState<WorkPermitPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: const Text(Strings.page_title_work_permit)
    );
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    throw UnimplementedError();
  }

  @override
  Widget? getFloatingActionButton(BuildContext context) {
    return null;
  }
}
