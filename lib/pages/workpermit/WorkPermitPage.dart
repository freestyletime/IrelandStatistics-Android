import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCounty.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';
import 'package:irelandstatistics/models/workpermit/PermitsSector.dart';
import 'package:irelandstatistics/pages/BasePage.dart';
import 'package:irelandstatistics/pages/workpermit/WorkPermitCompanyPage.dart';
import 'package:irelandstatistics/pages/workpermit/WorkPermitCountyPage.dart';
import 'package:irelandstatistics/pages/workpermit/WorkPermitNationalityPage.dart';
import 'package:irelandstatistics/pages/workpermit/WorkPermitSectorPage.dart';
import 'package:irelandstatistics/widgets/WorkPermitListView.dart';

import '../../Constants.dart';
import '../../models/config/SubChannel.dart';
import '../../models/workpermit/PermitsCompany.dart';
import '../../widgets/EmptyCenterText.dart';
import '../../widgets/Logo.dart';
import '../CallbackController.dart';

class WorkPermitPage extends StatefulWidget {
  static const String tag = 'work-permit-page';

  final List<int>? years;
  final List<SubChannel>? data;

  const WorkPermitPage({super.key, required this.data, required this.years});

  @override
  State<WorkPermitPage> createState() => _WorkPermitPageState();
}

class _WorkPermitPageState extends BasePageState<WorkPermitPage> {
  late int selectedYear;
  late CallbackController _controller;
  final _data = ValueNotifier<List<SubChannel>>([]);

  void _searchCallback(String result) {
    if (result.isEmpty) {
      _data.value = widget.data!;
    } else {
      List<SubChannel> tmp = [];
      for (var subChannel in widget.data!) {
        if (subChannel.subChannelName!.contains(result)) {
          tmp.add(subChannel);
        }
      }
      _data.value = tmp;
    }
  }

  void _result(String val) {
    switch (val) {
      case Strings.tag_work_permit_page_nationality:
        service.getApiWorkPermitNationality().getNationalityDataByYear(
            WorkPermitPage.tag + hashCode.toString(),
            selectedYear.toString(),
            Constants.field_grand_total);
        break;
      case Strings.tag_work_permit_page_companies:
        service.getApiWorkPermitCompany().getCompanyDataByYear(
            WorkPermitPage.tag + hashCode.toString(),
            selectedYear.toString(),
            Constants.field_grand_total);
        break;
      case Strings.tag_work_permit_page_county:
        service.getApiWorkPermitCounty().getCountyDataByYear(
            WorkPermitPage.tag + hashCode.toString(),
            selectedYear.toString(),
            Constants.field_grand_total);
        break;
      case Strings.tag_work_permit_page_sector:
        service.getApiWorkPermitSector().getSectorDataByYear(
            WorkPermitPage.tag + hashCode.toString(),
            selectedYear.toString(),
            Constants.field_grand_total);
        break;
    }
  }

  @override
  void initState() {
    selectedYear = widget.years![0];
    _data.value = widget.data!;
    _controller = CallbackController(context, result: _result);
    super.initState();
  }

  @override
  AppBar? getAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true, title: const Text(Strings.page_title_work_permit));
  }

  @override
  Widget getBody(BuildContext context) {
    // var search = SearchBox(
    //     hint: Strings.hint_work_permit_search,
    //     supportChangeCallback: false,
    //     callback: _searchCallback);

    var yearPicker = Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.lightBlueAccent,
            width: 5,
          )),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(minWidth: double.infinity, minHeight: 40.0),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            const Expanded(
              flex: 2,
              child: Text('Year Picker :',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.limeAccent,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 5,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  alignment: AlignmentDirectional.center,
                  style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  value: selectedYear,
                  items: widget.years!
                      .map((e) => DropdownMenuItem<int>(
                            alignment: Alignment.center,
                            value: e,
                            child: Text(
                              e.toString(),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return widget.data == null
        ? const EmptyCenterText()
        : ValueListenableBuilder<List<SubChannel>>(
            valueListenable: _data,
            builder: (context, data, _) {
              return CustomScrollView(
                physics: const ScrollPhysics(),
                slivers: <Widget>[
                  const SliverToBoxAdapter(
                      child: WorkPermitsDataResourceLogo()),
                  // SliverToBoxAdapter(child: search),
                  SliverToBoxAdapter(child: yearPicker),
                  WorkPermitListView(data,
                      callback: _controller.itemClick, isListView: false)
                ],
              );
            });
  }

  @override
  FloatingActionButton? getFloatingActionButton(BuildContext context) {
    return null;
  }

  @override
  void success<E extends IBean>(String id, List<E> ts) {
    if (WorkPermitPage.tag + hashCode.toString() == id && ts.isNotEmpty) {
      if (ts[0] is PermitsCompany) {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => WorkPermitCompanyPage(
                  grandTotal: ts[0] as PermitsCompany, year: selectedYear)),
        );
      } else if (ts[0] is PermitsNationality) {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => WorkPermitNationalityPage(
                  grandTotal: ts[0] as PermitsNationality, year: selectedYear)),
        );
      } else if (ts[0] is PermitsSector) {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => WorkPermitSectorPage(
                  grandTotal: ts[0] as PermitsSector, year: selectedYear)),
        );
      } else if (ts[0] is PermitsCounty) {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => WorkPermitCountyPage(
                  grandTotal: ts[0] as PermitsCounty, year: selectedYear)),
        );
      }
    }
  }
}
