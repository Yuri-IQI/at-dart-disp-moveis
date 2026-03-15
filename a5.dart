import 'dart:io';

import 'a4.dart';

void main() {
  List<RecemNascido> recemNascidos = [];

  while (true) {
    stdout.write('Menu:\n0. Sair\n1. Cadastrar rescém-nascido\n2. Classificação de pesos\n3. Recém-nascido do sexo feminino com maior peso\n4. Percentual por classificação\nEscolha uma opção: ');
    String? option = stdin.readLineSync();
    int optionInt = int.tryParse(option ?? '0') ?? 0;

    if (optionInt == 0) {
      print('Finalizando...');
      break;
    }

    switch (optionInt) {
      case 1:
        RecemNascido recemNascido = cadastrarRescemNascido();
        recemNascidos.add(recemNascido);
        break;
      case 2:
        classificarPesos(recemNascidos);
        break;
      case 3:
        rescemNascidoMaiorPeso(recemNascidos, Sexo.feminino);
        break;
      case 4:
        percentualPorClassificacao(recemNascidos);
        break;
      default:
        print('Opção inválida. Tente novamente.');
    }
  }
}

class RecemNascido {
  String nome;
  Sexo sexo;
  double peso;
  ClassificacaoPeso? classificacaoPeso;

  RecemNascido(this.nome, this.sexo, this.peso);
}

enum ClassificacaoPeso {
  baixoPeso("Baixo peso"),
  normal("Normal"),
  altoPeso("Alto peso");

  final String label;
  const ClassificacaoPeso(this.label);
}

RecemNascido cadastrarRescemNascido() {
  stdout.write('Informe o nome do recém-nascido: ');
  String? nome = stdin.readLineSync();

  stdout.write('Informe o sexo do recém-nascido (M/F): ');
  String? sexoInput = stdin.readLineSync();
  Sexo sexo = sexoInput?.toUpperCase() == 'M' ? Sexo.masculino : Sexo.feminino;

  stdout.write('Informe o peso (kg) do recém-nascido: ');
  String? pesoInput = stdin.readLineSync();
  double peso = double.tryParse(pesoInput ?? '0') ?? 0;

  RecemNascido recemNascido = RecemNascido(nome ?? '', sexo, peso);
  print('Recém-nascido cadastrado: Nome: ${recemNascido.nome}, Sexo: ${recemNascido.sexo.sigla}, Peso: ${recemNascido.peso} kg\n');
  return recemNascido;
}

void classificarPesos(List<RecemNascido> recemNascidos) {
  recemNascidos.forEach((recemNascido) {
    if (0 <= recemNascido.peso && recemNascido.peso <= 2) {
      recemNascido.classificacaoPeso = ClassificacaoPeso.baixoPeso;
    } else if (recemNascido.peso > 2 && recemNascido.peso <= 4.0) {
      recemNascido.classificacaoPeso = ClassificacaoPeso.normal;
    } else {
      recemNascido.classificacaoPeso = ClassificacaoPeso.altoPeso;
    }

    print('Recém-nascido: ${recemNascido.nome}, Sexo: ${recemNascido.sexo.sigla}, Peso: ${recemNascido.peso} kg, Classificação: ${recemNascido.classificacaoPeso?.label}');
  });
}

void rescemNascidoMaiorPeso(List<RecemNascido> recemNascidos, Sexo sexo) {
  RecemNascido? recemNascidoMaiorPeso;

  recemNascidos.forEach((recemNascido) {
    if (recemNascido.sexo == sexo) {
      if (recemNascidoMaiorPeso == null || recemNascido.peso > recemNascidoMaiorPeso!.peso) {
        recemNascidoMaiorPeso = recemNascido;
      }
    }
  });

  if (recemNascidoMaiorPeso != null) {
    print('Recém-nascido do sexo ${sexo.sigla} com maior peso: ${recemNascidoMaiorPeso!.nome} com ${recemNascidoMaiorPeso!.peso} kg\n');
  } else {
    print('Nenhum recém-nascido do sexo ${sexo.sigla} encontrado.\n');
  }
}

void percentualPorClassificacao(List<RecemNascido> recemNascidos) {
  int total = recemNascidos.length;
  if (total == 0) {
    print('Nenhum recém-nascido cadastrado.\n');
    return;
  }

  List<int> counts = recemNascidos.fold([0, 0, 0], (list, recemNascido) => [
    list[0] + (recemNascido.classificacaoPeso == ClassificacaoPeso.baixoPeso ? 1 : 0),
    list[1] + (recemNascido.classificacaoPeso == ClassificacaoPeso.normal ? 1 : 0),
    list[2] + (recemNascido.classificacaoPeso == ClassificacaoPeso.altoPeso ? 1 : 0),
  ]);

  double baixoPesoPercentual = (counts[0] / total) * 100;
  double pesoNormalPercentual = (counts[1] / total) * 100;
  double altoPesoPercentual = (counts[2] / total) * 100;

  print('Percentual de recém-nascidos por classificação:');
  print('Baixo peso: $baixoPesoPercentual%');
  print('Peso Normal: $pesoNormalPercentual%');
  print('Alto peso: $altoPesoPercentual%\n');
}