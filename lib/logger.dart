import 'package:logger/logger.dart' show Logger;

class Log {
  static final Logger _logger = Logger();

  static void debug(String message) {
    _logger.d(message);
  }

  static void debugWithTag(String tag, String message) {
    _logger.d("$tag: $message");
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void infoWithTag(String tag, String message) {
    _logger.i("$tag: $message");
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void warningWithTag(String tag, String message) {
    _logger.w("$tag: $message");
  }

  static void error(String message) {
    _logger.e(message);
  }

  static void errorWithTag(String tag, String message) {
    _logger.e("$tag: $message");
  }

  static void errorWithStackTrace(String message) {
    _logger.e(message, stackTrace: StackTrace.current);
  }

  static errorWithException(String message, Exception exception) {
    _logger.e(message, error: exception, stackTrace: StackTrace.current);
  }
}
