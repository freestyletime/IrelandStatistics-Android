import 'package:flutter/cupertino.dart';

import '../models/IBean.dart';
import '../models/config/SubChannel.dart';

class CallbackController {
  final BuildContext context;
  final Function result;

  CallbackController(this.context, {required this.result});

  void itemClick(IBean bean) {
    if (bean is SubChannel) {
      result(bean.subChannelId);
    }
  }
}