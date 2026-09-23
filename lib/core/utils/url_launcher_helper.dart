import 'url_launcher_helper_stub.dart'
    if (dart.library.html) 'url_launcher_helper_web.dart';

void launchUrlString(String url) {
  openExternalUrl(url);
}

class UrlLauncherHelper {
  static void openUrl(String url) {
    openExternalUrl(url);
  }
}
