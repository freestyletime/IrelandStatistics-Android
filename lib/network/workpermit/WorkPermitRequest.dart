import 'package:irelandstatistics/models/workpermit/PermitsCounty.dart';
import 'package:irelandstatistics/models/workpermit/PermitsNationality.dart';
import 'package:irelandstatistics/models/workpermit/PermitsSector.dart';
import 'package:irelandstatistics/network/RequestMethod.dart';

import '../../models/workpermit/PermitsCompany.dart';

class API$WorkPermit$Company{
  static const String united = '/company';
  getAllCompanyDataByYear(String id, String year, {int page = 0, int pageSize = 20}) {
    String url = '$united/$year';
    Map<String, dynamic> data = {'page': page, 'pageSize': pageSize};
    NetWork.get(id, url, t: PermitsCompany(), data: data);
  }

  getCompanyDataByYear(String id, String year, String company, {int page = 0, int pageSize = 20}) {
    String url = '$united/$year/$company';
    Map<String, dynamic> data = {'page': page, 'pageSize': pageSize};
    NetWork.get(id, url, t: PermitsCompany(), data: data);
  }
}

class API$WorkPermit$Nationality{
  static const String united = '/nationality';
  getAllNationalityDataByYear(String id, String year) {
    String url = '$united/$year';
    NetWork.get(id, url, t: PermitsNationality());
  }

  getNationalityDataByYear(String id, String year, String nationality) {
    String url = '$united/$year/$nationality';
    NetWork.get(id, url, t: PermitsNationality());
  }
}

class API$WorkPermit$County{
  static const String united = '/county';
  getAllCountyDataByYear(String id, String year) {
    String url = '$united/$year';
    NetWork.get(id, url, t: PermitsCounty());
  }

  getCountyDataByYear(String id, String year, String county) {
    String url = '$united/$year/$county';
    NetWork.get(id, url, t: PermitsCounty());
  }
}

class API$WorkPermit$Sector{
  static const String united = '/sector';
  getAllSectorDataByYear(String id, String year) {
    String url = '$united/$year';
    NetWork.get(id, url, t: PermitsSector());
  }

  getSectorDataByYear(String id, String year, String sector) {
    String url = '$united/$year/$sector';
    NetWork.get(id, url, t: PermitsSector());
  }
}