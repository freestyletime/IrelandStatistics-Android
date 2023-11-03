import 'package:irelandstatistics/network/workpermit/WorkPermitRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Services {
  // email service
  // void sendEmail(String email) => launchUrl(Uri.parse('mailto:$email'));
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  API$WorkPermit$Company getApiWorkPermitCompany() => API$WorkPermit$Company();
}