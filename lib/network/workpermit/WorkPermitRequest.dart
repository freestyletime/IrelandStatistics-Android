import 'dart:convert';

import 'package:irelandstatistics/models/workpermit/PermitsCounty.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';
import 'package:irelandstatistics/models/workpermit/PermitsSector.dart';
import 'package:irelandstatistics/network/RequestMethod.dart';

import '../../Constants.dart';
import '../../events/Event.dart';
import '../../models/IBean.dart';
import '../../models/workpermit/PermitsCompany.dart';

void _get<T extends IBean>(String id, String url, {T? t, Map<String, dynamic>? map}) {
  Constants.eventBus.fire(SEvent(id));
  NetWork.isConnected().then((isConnected) => {
    if(isConnected) {
      NetWork.get(id, url, t: t, data: map)
    } else {
      Constants.eventBus.fire(FEvent(id, Strings.msg_not_connection))
    }
  });
}

class API$WorkPermit$Company{
  static const String united = '/company';
  getAllCompanyDataByYear(String id, String year, {int page = 0, int pageSize = 20}) {
    String url = '$united/$year';
    Map<String, dynamic> data = {'page': page, 'pageSize': pageSize};
    _get(id, url, t: PermitsCompany(), map: data);
  }

  getCompanyDataByYear(String id, String year, String company, {int page = 0, int pageSize = 20}) {
    String url = '$united/$year/$company';
    Map<String, dynamic> data = {'page': page, 'pageSize': pageSize};
    _get(id, url, t: PermitsCompany(), map: data);
  }
}

class API$WorkPermit$Nationality{
  static const String united = '/nationality';
  getAllNationalityDataByYear(String id, String year) {
    String url = '$united/$year';
    _get(id, url, t: PermitsNationality());
  }

  getNationalityDataByYear(String id, String year, String nationality) {
    String url = '$united/$year/$nationality';
    _get(id, url, t: PermitsNationality());
  }
}

class API$WorkPermit$County{
  static const String united = '/county';
  getAllCountyDataByYear(String id, String year) {
    String url = '$united/$year';
    _get(id, url, t: PermitsCounty());
  }

  getCountyDataByYear(String id, String year, String county) {
    String url = '$united/$year/$county';
    _get(id, url, t: PermitsCounty());
  }
}

class API$WorkPermit$Sector{
  static const String united = '/sector';
  getAllSectorDataByYear(String id, String year) {
    String url = '$united/$year';
    _get(id, url, t: PermitsSector());
  }

  getSectorDataByYear(String id, String year, String sector) {
    String url = '$united/$year/$sector';
    _get(id, url, t: PermitsSector());
  }
}