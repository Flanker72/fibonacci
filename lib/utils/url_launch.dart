import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  if (await canLaunch(url)) {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(url);
    }
  } else {
    throw 'Could not launch $url';
  }
}
