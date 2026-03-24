import 'dart:io';
import 'dart:math';

void main() {
  while (true) {
    print('Informe o tamanho da sequência:');
    String? input = stdin.readLineSync();
    if (input == null || input == '') {
      break;
    }

    int length = int.tryParse(input) ?? 0;

    print('Informe o valor de X:');
    String? xInput = stdin.readLineSync();
    int x = xInput != null ? int.tryParse(xInput) ?? 0 : 0;
  
    double total = 0;
    for (int i = 0; i < length; i++) {
      double fraction = buildFraction(x, i);
      print('Termo $i: $fraction');
      total += fraction;
    }

    print('Resultado: $total');
  }
}

double buildFraction(int numerator, int length) {
  int expoent = getExpoent(2, length);
  int denominator = getDenominator(length);
  return pow(numerator, expoent) / solveFatorial(denominator);
}

int getExpoent(int base, int length) {
  return base + length;
}

int getDenominator(int length) {
  return 4 - ((length % 6) - 3).abs();
}

int solveFatorial(int n) {
  if (n < 0) {
    throw ArgumentError('Número negativo não é permitido para fatorial.');
  }

  int res = 1;
  for (int i = 2; i <= n; i++) {
    res *= i;
  }

  return res;
}