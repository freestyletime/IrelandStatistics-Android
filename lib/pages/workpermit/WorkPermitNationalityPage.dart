import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:irelandstatistics/models/config/Country.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithIssued.dart';
import 'package:irelandstatistics/widgets/ListBottomItem.dart';

import '../../Constants.dart';
import '../../widgets/SearchBox.dart';
import '../../widgets/SubWorkPermitListView.dart';

class WorkPermitNationalityPage extends StatefulWidget {
  static const String tag = 'work-permit-nationality-page';

  final int year;
  final PermitsNationality grandTotal;

  const WorkPermitNationalityPage(
      {super.key, required this.grandTotal, required this.year});

  @override
  State<WorkPermitNationalityPage> createState() =>
      _WorkPermitNationalityPageState();
}

class _WorkPermitNationalityPageState
    extends BasePageState<WorkPermitNationalityPage> {

  var _countries = <String, Country>{};
  late ScrollController _scrollController;


  final _orgData = <PermitsNationality>[];
  final _data = ValueNotifier<List<PermitsNationality>>([]);

  void _dataRequest() {
    service.getApiWorkPermitNationality().getAllNationalityDataByYear(
        WorkPermitNationalityPage.tag + hashCode.toString(),
        widget.year.toString());
  }

  void _searchCallback(String result) {
    var tmpData = <PermitsNationality>[];
    if(result.isNotEmpty) {
      for(var p in _orgData) {
        if(p.nationality != null && p.nationality!.contains(result)) {
          tmpData.add(p);
        }
      }
      _data.value = tmpData;
    } else {
      _data.value = _orgData;
    }
  }

  Future<void> _loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/config/countries.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    var data = <String, Country>{};

    for(var s in jsonData) {
      var c = Country.fromJson(s);
      data.putIfAbsent(c.enShortName ?? '', () => c);
    }

    setState(() {
      _countries = data;
    });
  }

    @override
  void initState() {
    _loadJsonAsset();
    _dataRequest();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(Strings.page_title_work_permit_nationality),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    var grandTotal = GrandTotalWithIssued<PermitsNationality>(
        data: widget.grandTotal, icon: Icons.place_rounded);

    var search = SearchBox(
        hint: Strings.hint_nationality_work_permit_search,
        supportChangeCallback: false,
        callback: _searchCallback);

    return ValueListenableBuilder<List<PermitsNationality>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: search),
            SliverToBoxAdapter(child: grandTotal),
            SubWorkPermitListView<PermitsNationality>(data: data, countries: _countries),
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
    if (WorkPermitNationalityPage.tag + hashCode.toString() == id) {
      if (ts.isNotEmpty && ts[0] is PermitsNationality) {
        _orgData.addAll(ts as Iterable<PermitsNationality>);
        _data.value = _orgData;
      }
    }
  }
}
