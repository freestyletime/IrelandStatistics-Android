import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/IBean.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';

class SubWorkPermitListView<T extends IBean> extends StatelessWidget {
  final List<T> data;

  const  SubWorkPermitListView(this.data, {super.key});

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
                      height: 15,
                    ),
                    Text('Total Permit(${data.year}): ${data.count ?? 0}',
                        style: const TextStyle(
                            color: Colors.deepPurpleAccent, fontSize: 14))
                  ]))
            ]));
  }

  Widget _monthCountInfo(List<int> monthCount) {
    Widget getContent(String str) {
      const fixedHeight = 40.0;
      return Container(
        alignment: Alignment.center,
        color: Colors.blueGrey,
        height: fixedHeight,
        child: Text(str,
            style: const TextStyle(fontSize: 14, color: Colors.white)),
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
            getContent('Jan ${monthCount[0]}'),
            getContent('Feb ${monthCount[1]}'),
            getContent('Mar ${monthCount[2]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            getContent('Apr ${monthCount[3]}'),
            getContent('May ${monthCount[4]}'),
            getContent('Jun ${monthCount[5]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            getContent('Jul ${monthCount[6]}'),
            getContent('Aug ${monthCount[7]}'),
            getContent('Sep ${monthCount[8]}'),
          ],
        ),
        TableRow(
          children: <Widget>[
            getContent('Oct ${monthCount[9]}'),
            getContent('Nov ${monthCount[10]}'),
            getContent('Dec ${monthCount[11]}'),
          ],
        ),
      ],
    );
  }

  Widget _renderRow(int position, List<T> datas) {
    
    if(datas[position] is PermitsCompany) {
      PermitsCompany data = datas[position] as PermitsCompany;

      return Container(
          padding: const EdgeInsets.all(5),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_basicCompanyInfo(data), _monthCountInfo(data.monthCount!)],
            ),
          ));
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
