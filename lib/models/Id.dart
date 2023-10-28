import 'package:irelandstatistics/models/IBean.dart';

class Id extends IBean{
  int? timestamp;
  String? date;

  Id({this.timestamp, this.date});

  Id.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    date = json['date'];
  }
}
