class ConvertBase {
  final String number;
  final int fromBase;
  final int toBase;

  ConvertBase({
    required this.number,
    required this.fromBase,
    required this.toBase,
  });

  // Lance la conversion en fonction des bases
  String convert() {
    if (fromBase == toBase) {
      return number;
    }


    int decimalValue = _toDecimal(number, fromBase);

    // la base cible est 10 → retour direct
    if (toBase == 10) {
      return decimalValue.toString();
    }

    //  convertir du décimal vers la base cible
    return _fromDecimal(decimalValue, toBase);
  }

  /// Conversion d'une base X vers décimal
  int _toDecimal(String number, int base) {
    int result = 0;
    int power = 0;

    for (int i = number.length - 1; i >= 0; i--) {
      int digitValue = _charToValue(number[i]);
      if (digitValue >= base) {
        throw Exception("Chiffre '${number[i]}' invalide pour la base $base");
      }
      result += digitValue * (basePow(base, power));
      power++;
    }
    return result;
  }

  /// Conversion du décimal vers une base X (algo #2)
  String _fromDecimal(int number, int base) {
    if (number == 0) return "0";
    String result = "";
    int n = number;

    while (n > 0) {
      int remainder = n % base;
      result = _valueToChar(remainder) + result;
      n ~/= base;
    }
    return result;
  }

  /// Convertit un caractère en valeur (ex: 'A'->10)
  int _charToValue(String c) {
    if (RegExp(r'^[0-9]$').hasMatch(c)) {
      return int.parse(c);
    } else {
      return c.codeUnitAt(0) - 'A'.codeUnitAt(0) + 10;
    }
  }

  /// Convertit une valeur en caractère (ex: 10->'A')
  String _valueToChar(int value) {
    if (value < 10) {
      return value.toString();
    } else {
      return String.fromCharCode('A'.codeUnitAt(0) + value - 10);
    }
  }

  /// Fonction puissance (base^exp)
  int basePow(int base, int exp) {
    int result = 1;
    for (int i = 0; i < exp; i++) {
      result *= base;
    }
    return result;
  }
}
