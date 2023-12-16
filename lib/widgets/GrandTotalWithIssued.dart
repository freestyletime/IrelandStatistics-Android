import 'package:flutter/cupertino.dart';

import '../models/IBean.dart';

class GrandTotalWithIssued<E extends IBean> extends StatelessWidget {

  final E data;
  final IconData icon;

  const GrandTotalWithIssued({super.key, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
