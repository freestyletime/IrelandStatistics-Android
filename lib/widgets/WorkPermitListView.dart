import 'package:flutter/material.dart';

import '../models/config/SubChannel.dart';

class WorkPermitListView extends StatelessWidget {
  final List<SubChannel> data;
  final Function callback;
  final bool isListView;

  const WorkPermitListView(this.data,
      {super.key, required this.callback, this.isListView = true});

  void _onItemClick(SubChannel data) {
    callback(data);
  }

  Widget _renderRow(int position, List<SubChannel> datas) {
    if (position.isOdd) return const Divider();

    final index = position ~/ 2;
    SubChannel data = datas[index];

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
              children: [getText('${data.subChannelName}')],
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
