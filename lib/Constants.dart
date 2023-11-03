import 'package:event_bus/event_bus.dart';

class Constants {
  static final EventBus eventBus = EventBus();
}

class Strings {
  static const String page_title_home = 'Home';
  static const String page_title_work_permit = 'Work Permit';

  static const String msg_not_connection = 'Please check the network!';
  static const String msg_request_error = 'Something wrong while request.';
}

class URLConstants {
  static const String host = 'http://141.148.240.29/';
  static const String application = '$host/ireland_statistics';
  static const String workPermit = '$application/api/v1/employment-permit';

  static const int TIMEOUT = 10; // 10s
}