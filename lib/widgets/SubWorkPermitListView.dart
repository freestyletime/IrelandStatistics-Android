import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/config/Country.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';

class SubWorkPermitListView<T extends IBean> extends StatelessWidget {
  final List<T> data;
  final Map<String, Country>? countries;

  const SubWorkPermitListView(
      {super.key, required this.data, this.countries = const {}});

  Widget _basicCompanyInfo(PermitsCompany data) {
    return Container(
        color: Colors.amberAccent,
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(data.employer ?? '',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Total Permit(${data.year}): ${data.count ?? 0}',
                        style: const TextStyle(
                            color: Colors.deepPurpleAccent, fontSize: 14))
                  ]))
            ]));
  }

  Widget _basicNationalityInfo(PermitsNationality data) {
    var parser = EmojiParser();
    var title = '';

    print(data.nationality);
    if (countries != null &&
        countries!.isNotEmpty &&
        countries!.containsKey(data.nationality)) {
      var emoji = ':flag-${countries![data.nationality]?.alpha2Code?.toLowerCase()}:';
      title += '${parser.emojify(emoji)} ';
    } else {
      title += '${parser.emojify(':globe_with_meridians:')} ';
    }

    title += '${data.nationality}';

    return Container(
        color: Colors.amberAccent,
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Total Issued Permit(${data.year}): ${data.issued ?? 0}',
                        style: const TextStyle(
                            color: Colors.deepPurpleAccent, fontSize: 14))
                  ]))
            ]));
  }

  Widget _getContent(String str) {
    const fixedHeight = 40.0;
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey,
      height: fixedHeight,
      child:
          Text(str, style: const TextStyle(fontSize: 14, color: Colors.white)),
    );
  }

  Widget _monthCountInfo(List<int> monthCount) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            _getContent('Jan ${monthCount[0]}'),
            _getContent('Feb ${monthCount[1]}'),
            _getContent('Mar ${monthCount[2]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            _getContent('Apr ${monthCount[3]}'),
            _getContent('May ${monthCount[4]}'),
            _getContent('Jun ${monthCount[5]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            _getContent('Jul ${monthCount[6]}'),
            _getContent('Aug ${monthCount[7]}'),
            _getContent('Sep ${monthCount[8]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            _getContent('Oct ${monthCount[9]}'),
            _getContent('Nov ${monthCount[10]}'),
            _getContent('Dec ${monthCount[11]}'),
          ],
        ),
      ],
    );
  }

  Widget _issuedCountInfo(int issued, int refused, int withdrawn) {
    return Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              _getContent('Issued $issued'),
              _getContent('Refused $refused'),
              _getContent('Withdrawn $withdrawn'),
            ],
          ),
        ]);
  }

  Widget _getUnitWrap(List<Widget> children) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        )));
  }

  Widget _renderRow(int position, List<T> datas) {
    if (datas[position] is PermitsCompany) {
      PermitsCompany data = datas[position] as PermitsCompany;

      return _getUnitWrap(
          [_basicCompanyInfo(data), _monthCountInfo(data.monthCount!)]);
    } else if (datas[position] is PermitsNationality) {
      PermitsNationality data = datas[position] as PermitsNationality;

      return _getUnitWrap([
        _basicNationalityInfo(data),
        _issuedCountInfo(
            data.issued ?? 0, data.refused ?? 0, data.withdrawn ?? 0)
      ]);
    }

    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _renderRow(index, data);
    }, childCount: data.length));
  }
}
