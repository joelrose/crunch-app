class Utilities {
  static String currencyFormat(num price) {
    return '${(price / 100).toStringAsFixed(2)} €';
  }
}
