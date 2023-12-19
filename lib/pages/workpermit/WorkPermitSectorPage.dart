import 'package:flutter/material.dart';
import 'package:irelandstatistics/Constants.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsSector.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithMonth.dart';

import '../../widgets/ListBottomItem.dart';
import '../../widgets/SearchBox.dart';
import '../../widgets/SubWorkPermitListView.dart';

class WorkPermitSectorPage extends StatefulWidget {
  static const String tag = 'work-permit-sector-page';

  final int year;
  final PermitsSector grandTotal;

  const WorkPermitSectorPage(
      {super.key, required this.grandTotal, required this.year});

  @override
  State<WorkPermitSectorPage> createState() => _WorkPermitSectorPageState();
}

class _WorkPermitSectorPageState extends BasePageState<WorkPermitSectorPage> {

  final _orgData = <PermitsSector>[];
  final _data = ValueNotifier<List<PermitsSector>>([]);

  void _dataRequest() {
    service.getApiWorkPermitSector().getAllSectorDataByYear(
        WorkPermitSectorPage.tag + hashCode.toString(), widget.year.toString());
  }

  void _searchCallback(String result) {
    var tmpData = <PermitsSector>[];
    if(result.isNotEmpty) {
      for(var p in _orgData) {
        if(p.sector != null && p.sector!.contains(result)) {
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
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(Strings.page_title_work_permit_sector),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    var grandTotal = GrandTotalWithMonth<PermitsSector>(
        data: widget.grandTotal, icon: Icons.work);

    var search = SearchBox(
        hint: Strings.hint_sector_work_permit_search,
        supportChangeCallback: false,
        callback: _searchCallback);

    return ValueListenableBuilder<List<PermitsSector>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: search),
            SliverToBoxAdapter(child: grandTotal),
            SubWorkPermitListView<PermitsSector>(data: data),
            const SliverToBoxAdapter(child: ListBottomItem()),
          ],
        );
      },
    );
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return null;
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    if (WorkPermitSectorPage.tag + hashCode.toString() == id) {
      if (ts.isNotEmpty && ts[0] is PermitsSector) {
        _orgData.addAll(ts as Iterable<PermitsSector>);
        _data.value = _orgData;
      }
    }
  }
}
