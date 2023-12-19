import 'package:flutter/material.dart';

import '../Constants.dart';

class ListBottomItem extends StatelessWidget {
  const ListBottomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        child: const Text(Strings.hint_list_to_bottom));
  }
}
