import 'package:flutter/cupertino.dart';
import 'package:irelandstatistics/models/local/SubChannel.dart';

import '../models/IBean.dart';

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