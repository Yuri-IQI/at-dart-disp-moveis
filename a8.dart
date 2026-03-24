import 'dart:io';

import 'a4.dart';

void main() {
  List<Candidato> candidatos = [];

  while (true) {
    stdout.write('Menu:\n0. Sair\n1. Cadastrar candidato\n2. Buscar candidatos\n');
    String? choice = stdin.readLineSync();

    if (choice == '0') {
      break;
    } else if (choice == '1') {
      stdout.write('Código: ');
      String? codigo = stdin.readLineSync();
      if (codigo == '0000') {
        print('Finalizando cadastro de candidatos.');
        break;
      }

      stdout.write('Curso: ');
      String? curso = stdin.readLineSync();
      stdout.write('Nome: ');
      String? nome = stdin.readLineSync();
      stdout.write('Sexo (M/F): ');
      String? sexoInput = stdin.readLineSync();
      Sexo sexo = sexoInput == 'M' ? Sexo.masculino : Sexo.feminino;
      stdout.write('Pontuação: ');
      String? pontuacaoInput = stdin.readLineSync();
      int pontuacao = int.tryParse(pontuacaoInput ?? '') ?? 0;

      candidatos.add(Candidato(codigo ?? '', curso ?? '', nome ?? '', sexo, pontuacao));
    }
  }
}

class Candidato {
  String codigo;
  String curso;
  String nome;
  Sexo sexo;
  int pontuacao;

  Candidato(this.codigo, this.curso, this.nome, this.sexo, this.pontuacao);
}

class SearchCriteria {
  String? atribute;
  String? value;

  SearchCriteria({this.atribute, this.value});
}