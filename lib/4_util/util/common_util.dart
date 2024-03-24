import 'dart:html';

class CommonUtil {
  static String getBrowserLocale() {
    String locale = window.navigator.language;
    return locale;
  }
}
