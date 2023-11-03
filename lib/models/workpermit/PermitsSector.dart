import 'package:irelandstatistics/models/IBean.dart';

import '../Id.dart';

class PermitsSector extends IBean{
  Id? id;
  String? sector;
  String? year;
  int? count;
  List<int>? monthCount;

  PermitsSector({this.id, this.sector, this.year, this.count, this.monthCount});

  PermitsSector.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    sector = json['sector'];
    year = json['year'];
    count = json['count'];
    monthCount = json['monthCount'].cast<int>();
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return PermitsSector.fromJson(json);
  }
}