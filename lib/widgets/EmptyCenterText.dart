import 'package:flutter/cupertino.dart';

import '../Constants.dart';

class EmptyCenterText extends StatelessWidget {
  const EmptyCenterText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(Strings.hint_data_empty,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
