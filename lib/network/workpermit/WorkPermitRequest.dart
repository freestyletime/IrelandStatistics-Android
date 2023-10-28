import 'package:irelandstatistics/network/RequestMethod.dart';

import '../../Constants.dart';
import '../../events/Event.dart';
import '../../models/IBean.dart';
import '../../models/workpermit/PermitsCompany.dart';

void _get<T extends IBean>(String id, String url, {T? t, Map<String, dynamic>? map}) {
  const _delay = 100;
  Constants.eventBus.fire(SEvent(id));

  Future.delayed(const Duration(milliseconds: _delay)).then((_) => {
    NetWork.isConnected().then((isConnected) => {
      if(isConnected) {
        if (t == null) {
          NetWork.get(url, data: map)
          // TODO
        } else {
          
        }
      } else {
        Constants.eventBus.fire(FEvent(id, Strings.msg_not_connection))
      }
    })
  });

}

class API$WorkPermit$Company{
  static const String company = '/company';
  getAllCompanyDataByYear(String id, String year, int page, int pageSize){
    String url = '$company/$year';
    Map<String, dynamic> data = {'page': page, 'pageSize': pageSize};
    _get(id, url, t: PermitsCompany());
  }
}