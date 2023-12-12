import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/material/floating_action_button.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

import '../../Constants.dart';
import '../../widgets/SearchBox.dart';

class WorkPermitSearchPage extends StatefulWidget {

  final String type;
  final int year;

  const WorkPermitSearchPage({super.key, required this.type, required this.year});

  @override
  State<WorkPermitSearchPage> createState() => _WorkPermitSearchPageState();
}

class _WorkPermitSearchPageState extends BasePageState<WorkPermitSearchPage> {

  var _page = 0;
  final _pageSize = 20;

  final _scrollController = ScrollController();
  final _data = ValueNotifier<List<IBean>>([]);

  void _dataRequest() {

  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _dataRequest();
    }
  }

  void _searchCallback(String result) {

  }

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    _dataRequest();

    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(Strings.page_title_work_permit_search)
    );
  }

  @override
  Widget getBody(BuildContext context) {
    var search = SearchBox(
        hint: Strings.hint_comapany_work_permit_search,
        callback: _searchCallback);


    return ValueListenableBuilder<List<IBean>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: search),

          ],
        );
      },
    );
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_upward_rounded),
      onPressed: () {
        if(_scrollController.position.pixels > 0) {
          _scrollController.jumpTo(0);
        }
      },
    );
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    // TODO: implement success
  }
}
