import 'package:logger/logger.dart';

class TLoggerHelper {
  TLoggerHelper._();

  /// Logger instance.
  static final Logger _logger = Logger(printer: PrettyPrinter(), level: Level.debug);

  /// Logs a debug message.
  static void debug(String message) => _logger.d(message);

  /// Logs an info message.
  static void info(String message) => _logger.i(message);

  /// Logs a warning message.
  static void warning(String message) => _logger.w(message);

  /// Logs an error message.
  static void error(String message) => _logger.e(message);
}
