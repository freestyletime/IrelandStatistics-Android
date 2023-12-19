import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCounty.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithIssued.dart';
import 'package:irelandstatistics/widgets/ListBottomItem.dart';

import '../../Constants.dart';
import '../../widgets/SearchBox.dart';
import '../../widgets/SubWorkPermitListView.dart';

class WorkPermitCountyPage extends StatefulWidget {
  static const String tag = 'work-permit-county-page';

  final int year;
  final PermitsCounty grandTotal;

  const WorkPermitCountyPage(
      {super.key, required this.grandTotal, required this.year});

  @override
  State<WorkPermitCountyPage> createState() =>
      _WorkPermitCountyPageState();
}

class _WorkPermitCountyPageState
    extends BasePageState<WorkPermitCountyPage> {

  late ScrollController _scrollController;


  final _orgData = <PermitsCounty>[];
  final _data = ValueNotifier<List<PermitsCounty>>([]);

  void _dataRequest() {
    service.getApiWorkPermitCounty().getAllCountyDataByYear(
        WorkPermitCountyPage.tag + hashCode.toString(),
        widget.year.toString());
  }

  void _searchCallback(String result) {
    var tmpData = <PermitsCounty>[];
    if(result.isNotEmpty) {
      for(var p in _orgData) {
        if(p.county != null && p.county!.contains(result)) {
          tmpData.add(p);
        }
      }
      _data.value = tmpData;
    } else {
      _data.value = _orgData;
    }
  }

  @override
  void initState() {
    _dataRequest();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(Strings.page_title_work_permit_county),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    var grandTotal = GrandTotalWithIssued<PermitsCounty>(
        data: widget.grandTotal, icon: Icons.place_rounded);

    var search = SearchBox(
        hint: Strings.hint_county_work_permit_search,
        supportChangeCallback: false,
        callback: _searchCallback);

    return ValueListenableBuilder<List<PermitsCounty>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: search),
            SliverToBoxAdapter(child: grandTotal),
            SubWorkPermitListView<PermitsCounty>(data: data),
            const SliverToBoxAdapter(child: ListBottomItem()),
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
        if (_scrollController.position.pixels > 0) {
          _scrollController.jumpTo(0);
        }
      },
    );
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    if (WorkPermitCountyPage.tag + hashCode.toString() == id) {
      if (ts.isNotEmpty && ts[0] is PermitsCounty) {
        _orgData.addAll(ts as Iterable<PermitsCounty>);
        _data.value = _orgData;
      }
    }
  }
}
