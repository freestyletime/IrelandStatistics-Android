import 'package:irelandstatistics/models/IBean.dart';

import '../Id.dart';

class PermitsCounty extends IBean{
  Id? id;
  String? county;
  String? year;
  int? issued;
  int? refused;
  int? withdrawn;

  PermitsCounty({this.id,
    this.county,
    this.year,
    this.issued,
    this.refused,
    this.withdrawn});

  PermitsCounty.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    county = json['county'];
    year = json['year'];
    issued = json['issued'];
    refused = json['refused'];
    withdrawn = json['withdrawn'];
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return PermitsCounty.fromJson(json);
  }
}