import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/material/floating_action_button.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/WorkPermitListView.dart';

import '../../Constants.dart';
import '../../models/config/SubChannel.dart';
import '../../widgets/EmptyCenterText.dart';
import '../../widgets/SearchBox.dart';
import '../CallbackController.dart';

class WorkPermitPage extends StatefulWidget {

  final List<SubChannel> data;

  const WorkPermitPage({super.key, required this.data});

  @override
  State<WorkPermitPage> createState() => _WorkPermitPageState();
}

class _WorkPermitPageState extends BasePageState<WorkPermitPage> {

  late String _searchKey;
  late CallbackController _controller;
  final _data = ValueNotifier<List<SubChannel>>([]);


  void _searchCallback(String result) {
    _searchKey = result;
    if (result.isEmpty) {
      _data.value = widget.data;
    } else {
      List<SubChannel> tmp = [];
      for (var subChannel in widget.data) {
        if (subChannel.subChannelName!.contains(result)) {
          tmp.add(subChannel);
        }
      }
      _data.value = tmp;
    }
  }

  void _result(String val) {
    switch(val){
      case '0':
        service.getApiWorkPermitNationality().getAllNationalityDataByYear('cc' + hashCode.toString(), '2020');
        break;
      case '1':
        break;
      case '2':
        break;
      case '3':
        break;
    }
  }

  @override
  void initState() {
    _searchKey = '';
    _data.value = widget.data;
    _controller = CallbackController(context, result: _result);
    super.initState();
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

    return ValueListenableBuilder<List<SubChannel>>(
        valueListenable: _data,
        builder: (context, data, _) {
          var search = SearchBox(
              content: _searchKey,
              hint: Strings.hint_work_permit_search,
              callback: _searchCallback);

          if (data.isEmpty)  if (data.isEmpty) return const EmptyCenterText();

          return CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(child: search),
              WorkPermitListView(data, callback: _controller.itemClick, isListView: false)
            ],
          );
        });
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return null;
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {

  }
}