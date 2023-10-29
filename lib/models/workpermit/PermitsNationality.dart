import 'package:irelandstatistics/models/IBean.dart';

import '../Id.dart';

class PermitsNationality extends IBean{
  Id? id;
  String? nationality;
  String? year;
  int? issued;
  int? refused;
  int? withdrawn;

  PermitsNationality({this.id,
    this.nationality,
    this.year,
    this.issued,
    this.refused,
    this.withdrawn});

  PermitsNationality.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    nationality = json['nationality'];
    year = json['year'];
    issued = json['issued'];
    refused = json['refused'];
    withdrawn = json['withdrawn'];
  }
}