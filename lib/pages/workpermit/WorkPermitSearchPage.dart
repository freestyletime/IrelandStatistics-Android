import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

import '../../Constants.dart';
import '../../models/workpermit/PermitsCompany.dart';
import '../../widgets/CompanyWorkPermitListView.dart';
import '../../widgets/SearchBox.dart';

class WorkPermitSearchPage extends StatefulWidget {
  static const String tag = 'work-permit-search-page';

  final String type;
  final int year;

  const WorkPermitSearchPage(
      {super.key, required this.type, required this.year});

  @override
  State<WorkPermitSearchPage> createState() => _WorkPermitSearchPageState();
}

class _WorkPermitSearchPageState extends BasePageState<WorkPermitSearchPage> {

  late String _name;
  bool _isLoadMore = true;

  var _page = 0;
  final _pageSize = 20;

  late ScrollController _scrollController;
  final _data = ValueNotifier<List<PermitsCompany>>([]);

  void _dataRequest() {
    service.getApiWorkPermitCompany().getCompanyDataByYear(
        WorkPermitSearchPage.tag + hashCode.toString(),
        widget.year.toString(),
        _name,
        page: _page,
        pageSize: _pageSize);
  }

  void _loadMore() {
    if (_isLoadMore && _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _dataRequest();
    }
  }

  void _searchCallback(String result) {
    _name = result;
    _page = 0;

    _data.value.clear();
    _dataRequest();
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: const Text(Strings.page_title_work_permit_search));
  }

  @override
  Widget getBody(BuildContext context) {

    var search = SearchBox(
        hint: Strings.hint_comapany_work_permit_search,
        supportChangeCallback: false,
        callback: _searchCallback);

    return ValueListenableBuilder<List<IBean>>(
      valueListenable: _data,
      builder: (context, data, _) {

        var ws = <Widget>[];
        ws.add(SliverToBoxAdapter(child: search));

        if (data.isNotEmpty) {
          ws.add(CompanyWorkPermitListView(data as List<PermitsCompany>));
        }

        return CustomScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(),
          slivers: ws,
        );
      },
    );
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_upward_rounded),
      onPressed: () {
        if (_scrollController.position.pixels > 0) {
          _scrollController.jumpTo(0);
        }
      },
    );
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    if (WorkPermitSearchPage.tag + hashCode.toString() == id) {
      if (ts.isNotEmpty) {
        for(var t in ts){
          if(t is PermitsCompany) {
            _data.value.add(t);
          }
        }

        if(ts.length == _pageSize) {
          _page++;
        } else {
          _isLoadMore = false;
        }
      }
    }
  }
}
