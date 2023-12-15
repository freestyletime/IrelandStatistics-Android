import 'package:flutter/cupertino.dart';

class WorkPermitSearchWithoutPagingPage extends StatefulWidget {

  static const String tag = 'work-permit-search-page';

  final String type;
  final int year;

  const WorkPermitSearchWithoutPagingPage(
      {super.key, required this.type, required this.year});

  @override
  State<WorkPermitSearchWithoutPagingPage> createState() => _WorkPermitSearchWithoutPagingPageState();
}

class _WorkPermitSearchWithoutPagingPageState extends State<WorkPermitSearchWithoutPagingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
