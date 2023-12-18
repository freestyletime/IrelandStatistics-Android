import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithIssued.dart';

import '../../Constants.dart';
import '../../widgets/SubWorkPermitListView.dart';
import 'WorkPermitSearchWithoutPagingPage.dart';

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

  @override
  void initState() {
    //widget.years![0];
    _dataRequest();
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(Strings.page_title_work_permit_nationality),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search Nationality',
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => WorkPermitSearchWithoutPagingPage(
                      type: Strings.tag_work_permit_page_nationality,
                      year: widget.year)),
            );
          },
        ),
      ],
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
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: grandTotal),
            SubWorkPermitListView<PermitsNationality>(data)
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
