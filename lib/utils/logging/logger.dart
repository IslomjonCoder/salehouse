import 'package:logger/logger.dart';

class TLoggerHelper {
  TLoggerHelper._();

  /// Logger instance.
  static final Logger _logger = Logger(printer: PrettyPrinter(), level: Level.debug);

  /// Logs a debug message.
  static void debug(Object message) => _logger.d(message.toString());

  /// Logs an info message.
  static void info(Object message) => _logger.i(message.toString());

  /// Logs a warning message.
  static void warning(Object message) => _logger.w(message.toString());

  /// Logs an error message.
  static void error(Object message) => _logger.e(message.toString());
}
