import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/material/floating_action_button.dart';
import 'package:irelandstatistics/Constants.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithMonth.dart';

import '../../widgets/CompanyWorkPermitListView.dart';
import '../../widgets/SearchBox.dart';

class WorkPermitCompanyPage extends StatefulWidget {
  static const String tag = 'home-work-permit-company-page';

  final int year;
  final PermitsCompany grandTotal;

  const WorkPermitCompanyPage({super.key, required this.grandTotal, required this.year});

  @override
  State<WorkPermitCompanyPage> createState() => _WorkPermitCompanyPageState();
}

class _WorkPermitCompanyPageState extends BasePageState<WorkPermitCompanyPage> {
  var _page = 0;
  final _pageSize = 20;

  final _scrollController = ScrollController();
  final _data = ValueNotifier<List<PermitsCompany>>([]);

  void _searchCallback(String result) {}

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _dataRequest();
    }
  }

  void _dataRequest() {
    service.getApiWorkPermitCompany().getAllCompanyDataByYear(
        WorkPermitCompanyPage.tag + hashCode.toString(),
        widget.year.toString(),
        page: _page,
        pageSize: _pageSize);
  }

  @override
  void initState() {//widget.years![0];
    _scrollController.addListener(_loadMore);

    _dataRequest();
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: const Text(Strings.page_title_work_permit_company));
  }

  @override
  Widget getBody(BuildContext context) {
    var search = SearchBox(
        hint: Strings.hint_comapany_work_permit_search,
        callback: _searchCallback);

    var grandTotal = GrandTotalWithMonth<PermitsCompany>(data: widget.grandTotal);

    return ValueListenableBuilder<List<PermitsCompany>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: search),
            SliverToBoxAdapter(child: grandTotal),
            CompanyWorkPermitListView(data)
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
    if (WorkPermitCompanyPage.tag + hashCode.toString() == id) {
      if(ts.isNotEmpty && ts[0] is PermitsCompany) {
        _data.value.addAll(ts as Iterable<PermitsCompany>);
        _data.notifyListeners();
        _page++;
      }
    }
  }
}
