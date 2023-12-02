import 'package:event_bus/event_bus.dart';

class Constants {
  static final EventBus eventBus = EventBus();

  static const int pageFrom = 0;
  static const int pageSize = 20;
}

class Strings {
  static const String page_title_home = 'Home';
  static const String page_title_work_permit = 'Work Permit';
  static const String page_title_work_permit_company = 'Company Work Permit';

  static const String hint_work_permit_search = 'Search your item';
  static const String hint_comapany_work_permit_search = 'Company Name';
  static const String hint_data_empty = 'Out of data';
  static const String hint_year_select = 'Select the year you want to search for.';

  static const String msg_400 = 'Something wrong with the request parameters.';
  static const String msg_403 = 'Current user has not permission to access.';
  static const String msg_404 = 'Data not found!';
  static const String msg_default = 'unknown happened';
  static const String msg_not_connection = 'Please check the network!';
  static const String msg_request_error = 'Something wrong while request.';
  static const String msg_loading = 'Loading...';

  static const String msg_connection_timeout = 'Connection timeout, please try it again.';
  static const String msg_network_timeout = 'Network error, please try it again.';
  static const String msg_params_error = 'Sorry, the data is preparing.';
  static const String msg_cert_error = 'You have no permission to access.';
  static const String msg_connection_cancel = 'Your request was cancelled.';
  static const String msg_unknow = 'Unknow internet error, please try it again.';



  static const String tag_home_page_work_permit = '0';

  static const String tag_work_permit_page_nationality = '0';
  static const String tag_work_permit_page_companies = '1';
  static const String tag_work_permit_page_county = '2';
  static const String tag_work_permit_page_sector = '3';
}

class URLConstants {
  static const String host = 'http://141.148.240.29/';
  static const String application = '$host/ireland_statistics';
  static const String workPermit = '$application/api/v1/employment-permit';

  static const int TIMEOUT = 10; // 10s
}