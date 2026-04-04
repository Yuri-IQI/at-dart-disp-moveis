import 'dart:math';

void main() {
  for (int i = 1000; i <= 9999; i++) {
    double sqrt_i = sqrt(i);

    String i_str = i.toString();
    int mid = i_str.length ~/ 2;
    int firstHalf = int.parse(i_str.substring(0, mid));
    int secondHalf = int.parse(i_str.substring(mid));

    if (firstHalf + secondHalf == sqrt_i) {
      print(i);
    }
  }
}