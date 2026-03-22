import 'dart:io';

void main() {
  String FLAG = '00000';
  List<Aluno> alunos = [];

  while (true) {
    stdout.write('Informe a matrícula do aluno (00000 para sair): ');
    String? matricula = stdin.readLineSync();
    
    if (matricula == FLAG) {
      print('Encerrando cadastro de alunos.');
      break;
    }

    stdout.write('Informe o nome do aluno: ');
    String? nome = stdin.readLineSync();

    stdout.write('Informe o sexo do aluno (M/F): ');
    String? sexoInput = stdin.readLineSync();
    Sexo sexo = sexoInput?.toUpperCase() == 'M' ? Sexo.masculino : Sexo.feminino;

    List<double> notas = [];
    for (int i = 1; i <= 3; i++) {
      stdout.write('Informe a nota $i: ');
      String? notaInput = stdin.readLineSync();
      double nota = double.tryParse(notaInput ?? '0') ?? 0;
      notas.add(nota);
    }

    stdout.write('Informe o número de faltas: ');
    String? faltasInput = stdin.readLineSync();
    int faltas = int.tryParse(faltasInput ?? '0') ?? 0;
  
    Aluno aluno = Aluno(matricula ?? '', nome ?? '', sexo, notas, faltas);
    alunos.add(aluno);
  }

  print('\nAlunos cadastrados:');
  for (Aluno aluno in alunos) {
    print('Matrícula: ${aluno.matricula}, Nome: ${aluno.nome}, Sexo: ${aluno.sexo.sigla}, Notas: ${aluno.notas}, Faltas: ${aluno.faltas}');
  }
  print('------------------------------------');

  do {
    stdout.write('Menu:\n0. Sair\n1. Média da turma\n2. Percentual de alunos aprovados\n3. Alunos aprovados com maior média\n4. Média de alunos do sexo feminino\nEscolha uma opção: ');
    String? option = stdin.readLineSync();
    int optionInt = int.tryParse(option ?? '0') ?? 0;

    if (optionInt == 0) {
      print('Finalizando...');
      break;
    }

    handleMenu(optionInt, alunos);
  } while (true);
}

void handleMenu(int option, List<Aluno> alunos) {
  switch (option) {
    case 1:
      double mediaTurma = 0;
      List<double> mediasAlunos = [];
      alunos.forEach((aluno) {
        double media = aluno.notas.reduce((a, b) => a + b) / aluno.notas.length;
        mediasAlunos.add(media);
        print('Média do aluno ${aluno.nome}: $media');
      });
      mediaTurma = mediasAlunos.reduce((a, b) => a + b) / mediasAlunos.length;
      print('\nMédia da turma: $mediaTurma\n');
      break;
    case 2:
      int aprovados = alunos.where((aluno) => isAprovado(aluno)).length;
      double percentualAprovados = (aprovados / alunos.length) * 100;
      print('Percentual de alunos aprovados: $percentualAprovados%\n');
      break;
    case 3:
      double media(Aluno aluno) => aluno.notas.reduce((a, b) => a + b) / aluno.notas.length;
      final alunosAprovados = alunos.where(isAprovado).toList();

      if (alunosAprovados.isEmpty) {
        print('Nenhum aluno aprovado encontrado.\n');
        return;
      }

      final masc = alunosAprovados.where((a) => a.sexo == Sexo.masculino).toList();
      final fem = alunosAprovados.where((a) => a.sexo == Sexo.feminino).toList();

      Aluno? alunoMascAprovadoMaiorMedia =
        masc.isEmpty ? null : masc.reduce((a, b) => media(a) > media(b) ? a : b);

      Aluno? alunaFemAprovadaMaiorMedia =
        fem.isEmpty ? null : fem.reduce((a, b) => media(a) > media(b) ? a : b);

      if (alunoMascAprovadoMaiorMedia != null) {
        print(
          'Aluno aprovado com maior média: '
          '${alunoMascAprovadoMaiorMedia.matricula} '
          'com média ${media(alunoMascAprovadoMaiorMedia)}\n'
        );
      }

      if (alunaFemAprovadaMaiorMedia != null) {
        print(
          'Aluna aprovada com maior média: '
          '${alunaFemAprovadaMaiorMedia.matricula} '
          'com média ${media(alunaFemAprovadaMaiorMedia)}\n'
        );
      }

      if (alunoMascAprovadoMaiorMedia == null && alunaFemAprovadaMaiorMedia == null) {
        print('Nenhum aluno aprovado com maior média encontrado.\n');
      }

      break;
    case 4:
      List<Aluno> alunas = alunos.where((aluno) => aluno.sexo == Sexo.feminino).toList();
      double mediaAlunas = 0;
      List<double> mediasAlunas = [];
      alunas.forEach((aluna) {
        double media = aluna.notas.reduce((a, b) => a + b) / aluna.notas.length;
        mediasAlunas.add(media);
      });
      mediaAlunas = mediasAlunas.reduce((a, b) => a + b) / mediasAlunas.length;
      print('Média de alunos do sexo feminino: $mediaAlunas\n');
      break;
    default:
      print('Opção inválida. Por favor, escolha uma opção válida.');
  }
}

bool isAprovado(Aluno aluno) {
  double media = aluno.notas.reduce((a, b) => a + b) / 3;
  print('Média do aluno ${aluno.nome}: $media, Faltas: ${aluno.faltas}');
  return media >= 7 && aluno.faltas <= 18;
}

enum Sexo {
  masculino("M"),
  feminino("F");

  final String sigla;
  const Sexo(this.sigla);
}

class Aluno {
  String matricula;
  String nome;
  Sexo sexo;
  List<double> notas;
  int faltas;

  Aluno(this.matricula, this.nome, this.sexo, this.notas, this.faltas);
}