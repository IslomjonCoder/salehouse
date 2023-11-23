import 'package:crm/utils/constants/enums.dart';

class TEnumFormatter {
  /// Convert Enum to String
  static String enumToString(Languages value) {
    switch (value) {
      case Languages.uz:
        return 'O`z';
      case Languages.ru:
        return 'Ru';
      case Languages.en:
        return 'En';
      case Languages.crylic:
        return 'Ўз';
    }
  }
}
