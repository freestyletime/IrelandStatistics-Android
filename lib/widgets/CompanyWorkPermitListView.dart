import 'package:flutter/material.dart';
import 'package:irelandstatistics/models/workpermit/PermitsCompany.dart';

class CompanyWorkPermitListView extends StatelessWidget {
  final List<PermitsCompany> data;
  final Function callback;
  final bool isListView;

  const CompanyWorkPermitListView(this.data,
      {super.key, required this.callback, this.isListView = true});

  void _onItemClick(PermitsCompany data) {
    callback(data);
  }

  Widget _renderRow(int position, List<PermitsCompany> datas) {
    if (position.isOdd) return const Divider();

    final index = position ~/ 2;
    PermitsCompany data = datas[index];

    Widget getText(String str) {
      return Text(str,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
    }

    return Container(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 5.0,
          child: InkWell(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [getText('${data.employer}')],
            )),
            onTap: () {
              _onItemClick(data);
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (isListView) {
      return ListView.builder(
          itemCount: data.length * 2,
          itemBuilder: (context, index) => _renderRow(index, data));
    }
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _renderRow(index, data);
    }, childCount: data.length * 2));
  }
}
