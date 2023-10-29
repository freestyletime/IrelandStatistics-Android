import 'package:irelandstatistics/events/IEvent.dart';

import '../models/IBean.dart';


class SEvent extends IEvent {
  SEvent(super.id);
}

class BeanEvent<T extends IBean> extends IEvent{
  List<T> ts;

  BeanEvent(super.id, this.ts);
}

class FEvent extends IEvent {
  String msg;

  FEvent(super.id, this.msg);
}

class CEvent extends IEvent {
  CEvent(super.id);
}