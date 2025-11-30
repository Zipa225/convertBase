
import 'dart:math' as Math;

class ConvertBase {
  final String number;
  final int fromBase;
  final int toBase;
  final int fractionPrecision;

  ConvertBase({
    required this.number,
    required this.fromBase,
    required this.toBase,
    this.fractionPrecision = 10,
  });

  String convert() {
    if (fromBase == toBase) return number;

    // Séparer partie entière et fractionnaire
    List<String> parts = number.split('.');
    String intPart = parts[0];
    String fracPart = parts.length > 1 ? parts[1] : '';

    BigInt decimalInt = _toDecimalInt(intPart, fromBase);
    double decimalFrac = _toDecimalFraction(fracPart, fromBase);

    // Conversion vers base cible
    String convertedInt = _fromDecimalInt(decimalInt, toBase);
    String convertedFrac = fracPart.isNotEmpty
        ? _fromDecimalFraction(decimalFrac, toBase, fractionPrecision)
        : '';

    return convertedFrac.isNotEmpty ? '$convertedInt.$convertedFrac' : convertedInt;
  }

  // Partie entière → BigInt
  BigInt _toDecimalInt(String number, int base) {
    number = number.toUpperCase();
    BigInt result = BigInt.zero;

    for (int i = 0; i < number.length; i++) {
      int digit = _charToValue(number[i]);
      if (digit >= base) {
        throw FormatException("Caractère '${number[i]}' invalide pour la base $base");
      }
      result = result * BigInt.from(base) + BigInt.from(digit);
    }
    return result;
  }

  // Partie fractionnaire → double
  double _toDecimalFraction(String fraction, int base) {
    fraction = fraction.toUpperCase();
    double result = 0.0;

    for (int i = 0; i < fraction.length; i++) {
      int digit = _charToValue(fraction[i]);
      if (digit >= base) {
        throw FormatException("Caractère '${fraction[i]}' invalide pour la base $base");
      }
      result += digit / Math.pow(base, i + 1);
    }
    return result;
  }

  // Partie entière BigInt → base cible
  String _fromDecimalInt(BigInt number, int base) {
    if (number == BigInt.zero) return '0';
    String result = '';
    BigInt b = BigInt.from(base);
    BigInt n = number;

    while (n > BigInt.zero) {
      int remainder = (n % b).toInt();
      result = _valueToChar(remainder) + result;
      n ~/= b;
    }
    return result;
  }

  // Partie fractionnaire double → base cible
  String _fromDecimalFraction(double fraction, int base, int precision) {
    String result = '';
    double frac = fraction;

    for (int i = 0; i < precision; i++) {
      frac *= base;
      int digit = frac.floor();
      result += _valueToChar(digit);
      frac -= digit;
      if (frac == 0) break;
    }

    return result;
  }

  // Convertit un caractère en valeur (0-35)
  int _charToValue(String c) {
    c = c.toUpperCase();
    if (RegExp(r'^[0-9]$').hasMatch(c)) {
      return int.parse(c);
    } else if (RegExp(r'^[A-Z]$').hasMatch(c)) {
      return c.codeUnitAt(0) - 'A'.codeUnitAt(0) + 10;
    } else {
      throw FormatException("Caractère '$c' non valide");
    }
  }

  // Convertit une valeur (0-35) en caractère
  String _valueToChar(int value) {
    if (value < 10) return value.toString();
    return String.fromCharCode('A'.codeUnitAt(0) + value - 10);
  }
}

// Utilisation
// var c = ConvertBase(number: '1A.F', fromBase: 16, toBase: 2);
// print(c.convert()); // => partie entière et fraction converties
