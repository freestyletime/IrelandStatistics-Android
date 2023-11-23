import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/material/floating_action_button.dart';
import 'package:irelandstatistics/Constants.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

class WorkPermitCompanyPage extends StatefulWidget {

  final List<int>? years;

  const WorkPermitCompanyPage({super.key, required this.years});

  @override
  State<WorkPermitCompanyPage> createState() => _WorkPermitCompanyPageState();
}

class _WorkPermitCompanyPageState extends BasePageState<WorkPermitCompanyPage> {

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true, title: const Text(Strings.page_title_work_permit_company));
  }

  @override
  Widget getBody(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Center"),
    );
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return null;
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    // TODO: implement success
  }
}
