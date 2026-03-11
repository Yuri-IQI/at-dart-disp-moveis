import 'dart:io';

// pos 0: 1 | pos 0+3 (3): 2 | pos 0+6 (6): 4
// pos 1: 5 | pos 1+3 (4): 10 | pos 1+6 (7): 15
//

// 0, 3, 6, 9, 12, 15, 18, 21, 24
// 1, 4, 7, 10, 13, 16, 19, 22, 25
// 2, 5, 8, 11, 14, 17, 20, 23, 26
// linha < 3

void main() {
  stdout.write('Informe o tamanho da sequência (contando a partir de 1): ');
  String? input = stdin.readLineSync();
  int? length = input != null ? int.tryParse(input) : null;

  if (length == null) {
    print('Por favor, insira um número inteiro positivo para o tamanho da sequência.');
    return;
  }

  int maxSequenceLength = (length / 3).ceil();
  print(maxSequenceLength);

  List<int> earlySequence = []; // números multiplicados por 2
  for (int i = 0; i < maxSequenceLength; i++) {
    int? prev = i > 0 ? earlySequence[i - 1] : null;
    earlySequence.add(getNextInEarlySequence(prev));
  }
  
  List<int> middleSequence = []; // números que incrementam de 5 em 5
  for (int i = 0; i < maxSequenceLength; i++) {
    middleSequence.add( 5 + (i * 5));
  }

  List<int> laterSequence = []; // números que decrementam de 10 em 10
  for (int i = 0; i < maxSequenceLength; i++) {
    laterSequence.add(100 - (i * 10));
  }

  List<int> finalSequence = [];
  for (int i = 0; i < maxSequenceLength && finalSequence.length < length; i++) {
    for (var seq in [earlySequence, middleSequence, laterSequence]) {
      if (finalSequence.length >= length) break;
      finalSequence.add(seq[i]);
    }
  }

  print('Sequência final: $finalSequence');
}

int getNextInEarlySequence(int? prev) {
  if (prev == null) {
    return 1;
  }

  return prev * 2;
}