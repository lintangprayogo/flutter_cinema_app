import 'package:intl/intl.dart';

extension IntExtension on int {
  String toIdrFormat() =>
      NumberFormat.currency(locale: "id_ID", symbol: "IDR").format(this);
}
