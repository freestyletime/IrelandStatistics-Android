import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:irelandstatistics/models/config/Country.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithIssued.dart';

import '../../Constants.dart';
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
  var _isLoadMore = false;
  late ScrollController _scrollController;

  final _data = ValueNotifier<List<PermitsNationality>>([]);

  void _dataRequest() {
    service.getApiWorkPermitNationality().getAllNationalityDataByYear(
        WorkPermitNationalityPage.tag + hashCode.toString(),
        widget.year.toString());
  }

  void _loadMore() {
    if (!_isLoadMore &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _isLoadMore = true;
      // TODO add the last item to show users the data is completed loaded.
    }
  }

  Future<void> _loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/config/countries.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    Map<String, Country> data = {};

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
    _scrollController = ScrollController()..addListener(_loadMore);
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

    return ValueListenableBuilder<List<PermitsNationality>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: grandTotal),
            SubWorkPermitListView<PermitsNationality>(data: data, countries: _countries),
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
        _data.value.addAll(ts as Iterable<PermitsNationality>);
        _data.notifyListeners();
      }
    }
  }
}
