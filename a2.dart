import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Informe o tamanho da sequência: ');
  String? input = stdin.readLineSync();
  int? length = input != null ? int.tryParse(input) : null;

  double res = 0;
  for (int i = 1; i <= length!; i++) {
    double fraction = buildFraction(i);

    if (i <= 3 || i % 2 != 0) {
      res += fraction;
    } else {
      res -= fraction;
    }
  }
  
  print('Resultado: $res');
}

double buildFraction(int length) {
  int numerator = getNumerator(3, length);
  int fatorial = getFatorial(4, length);
  int denominator = getDenominator(5, length);

  return pow(numerator, solveFatorial(fatorial)) / denominator;
}

int getNumerator(int base, int length) {
  return base + ((length - 1) * 2);
}

int getFatorial(int base, int length) {
  return base * length;
}

int getDenominator(int base, int length) {
  return base + (base * (length - 1));
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