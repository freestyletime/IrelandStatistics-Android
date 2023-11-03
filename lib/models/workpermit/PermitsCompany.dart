import 'package:irelandstatistics/models/IBean.dart';

import '../Id.dart';

class PermitsCompany extends IBean{
  Id? id;
  String? employer;
  String? year;
  int? count;
  List<int>? monthCount;

  PermitsCompany(
      {this.id, this.employer, this.year, this.count, this.monthCount});

  PermitsCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    employer = json['employer'];
    year = json['year'];
    count = json['count'];
    monthCount = json['monthCount'].cast<int>();
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return PermitsCompany.fromJson(json);
  }
}