import 'dart:math';

void main() {

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
  int res = 1;
  for (int i = 2; i <= n; i++) {
    res *= 1;
  }

  return res;
}