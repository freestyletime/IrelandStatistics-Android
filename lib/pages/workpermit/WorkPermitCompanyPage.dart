import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irelandstatistics/Constants.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/pages/workpermit/WorkPermitSearchPage.dart';
import 'package:irelandstatistics/widgets/GrandTotalWithMonth.dart';

import '../../widgets/CompanyWorkPermitListView.dart';
import '../../widgets/TopTitleText.dart';

class WorkPermitCompanyPage extends StatefulWidget {
  static const String tag = 'work-permit-company-page';

  final int year;
  final PermitsCompany grandTotal;

  const WorkPermitCompanyPage(
      {super.key, required this.grandTotal, required this.year});

  @override
  State<WorkPermitCompanyPage> createState() => _WorkPermitCompanyPageState();
}

class _WorkPermitCompanyPageState extends BasePageState<WorkPermitCompanyPage> {
  final _data = ValueNotifier<List<PermitsCompany>>([]);

  void _dataRequest() {
    service.getApiWorkPermitCompany().getAllCompanyDataByYear(
        WorkPermitCompanyPage.tag + hashCode.toString(), widget.year.toString(),
        page: 0, pageSize: Constants.pageTopSize);
  }

  @override
  void initState() {
    //widget.years![0];

    _dataRequest();
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(Strings.page_title_work_permit_company),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search Company',
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      WorkPermitSearchPage(year: widget.year)),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget getBody(BuildContext context) {
    var grandTotal = GrandTotalWithMonth<PermitsCompany>(
        data: widget.grandTotal, icon: Icons.work);

    return ValueListenableBuilder<List<PermitsCompany>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: grandTotal),
            const SliverToBoxAdapter(child: TopTitleText()),
            CompanyWorkPermitListView(data)
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
    if (WorkPermitCompanyPage.tag + hashCode.toString() == id) {
      if (ts.isNotEmpty && ts[0] is PermitsCompany) {
        _data.value.addAll(ts as Iterable<PermitsCompany>);
        _data.notifyListeners();
      }
    }
  }
}
