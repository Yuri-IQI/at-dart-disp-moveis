import 'dart:io';
import 'dart:math';

void main() {
  int randomNumber = getRandomNumber(1, 100);
  int? guess;

  while (guess != randomNumber || guess == null) {
    print('Digite um número entre 1 e 100:');
    guess = int.tryParse(stdin.readLineSync() ?? '');

    if (guess == null) {
      print('O número era $randomNumber. Obrigado por jogar!');
      break;
    } else if (guess < 1 || guess > 100) {
      print('Número fora do intervalo. Por favor, digite um número entre 1 e 100.');
      continue;
    }

    if (guess < randomNumber) {
      print('O número está entre $guess e 100. Tente novamente.');
    } else if (guess > randomNumber) {
      print('O número está entre 0 e $guess. Tente novamente.');
    } else {
      print('Parabéns! Você acertou, o número era $randomNumber!');
    }
  }
}

int getRandomNumber(int? min, int? max) {
  final Random random = Random();
  if (min == null || max == null) {
    return random.nextInt(101 - 1);
  }
  return min + random.nextInt((max + 1) - min);
}