import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';

class CompanyWorkPermitListView extends StatelessWidget {
  final List<PermitsCompany> data;

  const CompanyWorkPermitListView(this.data, {super.key });

  Widget _basicInfo(PermitsCompany data) {
    return Container(
        color: Colors.amberAccent,
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 300,
                        child: Text(data.employer ?? '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16))),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('Total Permit(${data.year}): ${data.count ?? 0}',
                        style: const TextStyle(color: Colors.deepPurpleAccent, fontSize: 14))
                  ])
            ]));
  }

  Widget _monthCountInfo(PermitsCompany data) {

    Widget getContent(String str){
      const fixedHeight = 40.0;
      return Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        height: fixedHeight,
        child: Text(str, style: const TextStyle(fontSize: 14, color: Colors.white)),
      );
    }

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
            getContent('Jan ${data.monthCount?[0]}'),
            getContent('Feb ${data.monthCount?[1]}'),
            getContent('Mar ${data.monthCount?[2]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            getContent('Apr ${data.monthCount?[3]}'),
            getContent('May ${data.monthCount?[4]}'),
            getContent('Jun ${data.monthCount?[5]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            getContent('Jul ${data.monthCount?[6]}'),
            getContent('Aug ${data.monthCount?[7]}'),
            getContent('Sep ${data.monthCount?[8]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            getContent('Oct ${data.monthCount?[9]}'),
            getContent('Nov ${data.monthCount?[10]}'),
            getContent('Dec ${data.monthCount?[11]}'),
          ],
        ),
      ],
    );
  }

  Widget _renderRow(int position, List<PermitsCompany> datas) {
    PermitsCompany data = datas[position];

    return Container(
        padding: const EdgeInsets.all(5),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_basicInfo(data), _monthCountInfo(data)],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _renderRow(index, data);
    }, childCount: data.length));
  }
}
