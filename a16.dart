import 'a17.dart';

void main() {
  List<List<int>> vetores = [];
  criarVetor(vetores);
  criarVetor(vetores);
  criarVetor(vetores);
  criarVetor(vetores);

  List<int> vetor5 = [];
  vetores.forEach((vetor) {
    vetor5.addAll(vetor);
  });

  vetor5.sort();

  print('Vetor 5 gerado pela adição e organização dos demais vetores: ${vetor5.join(', ')}');

  List<int> vetor6 = [];
  for (var val in vetores[0]) {
    if (vetores[1].contains(val) && vetores[2].contains(val) && vetores[3].contains(val)) {
      vetor6.add(val);
    }
  }

  print('Vetor 6 gerado pelos valores comuns entre os demais vetores: ${vetor6.join(', ')}');
}

