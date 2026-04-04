import 'dart:io';

void main() {
  List<List<int>> vetores = [];
  criarVetor(vetores);
  criarVetor(vetores);

  List<int> vetor1 = vetores[0];
  List<int> vetor2 = vetores[1];

  List<int> vetor3 = List.generate(
    vetor1.length < vetor2.length ? vetor1.length : vetor2.length,
    (i) => vetor1[i] + vetor2[i],
  );

  print('Vetor 3 gerado: ${vetor3.join(', ')}');
  print('Soma do vetor 3: ${vetor3.reduce((a, b) => a + b)}');
}

void criarVetor(List<List<int>> vetores) {
  int vetorAtual = vetores.length;

  stdout.write('Digite os valores do vetor ${vetorAtual + 1} (separados por vírgula): ');
  String? vetorInput = stdin.readLineSync();

  List<int> vetor = vetorInput?.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList() ?? [];
  vetores.add(vetor);
}