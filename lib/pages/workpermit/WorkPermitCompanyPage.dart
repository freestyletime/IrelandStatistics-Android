import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/material/floating_action_button.dart';
import 'package:irelandstatistics/Constants.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';
import 'package:irelandstatistics/pages/BasePage.dart';

import '../../widgets/CompanyWorkPermitListView.dart';
import '../../widgets/SearchBox.dart';

class WorkPermitCompanyPage extends StatefulWidget {
  static const String tag = 'home-work-permit-company-page';
  final List<int>? years;

  const WorkPermitCompanyPage({super.key, required this.years});

  @override
  State<WorkPermitCompanyPage> createState() => _WorkPermitCompanyPageState();
}

class _WorkPermitCompanyPageState extends BasePageState<WorkPermitCompanyPage> {
  var page = 0;
  var pageSize = 20;

  late int _selectedYear;
  final _data = ValueNotifier<List<PermitsCompany>>([]);

  void _searchCallback(String result) {

  }

  @override
  void initState() {
    _selectedYear = widget.years![0];
    service.getApiWorkPermitCompany().getAllCompanyDataByYear(
        WorkPermitCompanyPage.tag + hashCode.toString(),
        _selectedYear.toString(),
        page: 0,
        pageSize: 20);
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

    return ValueListenableBuilder<List<PermitsCompany>>(
      valueListenable: _data,
      builder: (context, data, _) {
        return CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(child: search),
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
      var tmp = <PermitsCompany>[];
      for (var e in ts) {
        if (e is PermitsCompany) {
          tmp.add(e);
        }
      }
      _data.value = tmp;
    }
  }
}
