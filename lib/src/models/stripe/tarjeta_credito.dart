import 'package:meta/meta.dart';

class TarjetaCredito {
  final String cardNumber;
  final String cvv;
  final int expiracyMonth;
  final int expiracyYear;
  final String name;

  TarjetaCredito({
    this.cardNumber,
    this.cvv,
    this.expiracyMonth,
    this.expiracyYear,
    this.name,
  });
}
