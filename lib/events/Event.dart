import 'package:irelandstatistics/events/IEvent.dart';

import '../models/IBean.dart';


class SEvent extends IEvent {
  SEvent(super.id);
}

class ModelEvent<T extends IBean> extends IEvent{
  T t;

  ModelEvent(super.id, this.t);
}

class FEvent extends IEvent {
  String msg;

  FEvent(super.id, this.msg);
}

class CEvent extends IEvent {
  CEvent(super.id);
}