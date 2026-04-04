import 'dart:io';
import 'a4.dart';

void main() {
  String buscasConteudo = '''
    Busca a ser realizada (escolha um número):
    1. Candidatos ao curso de Ciência da Computação com pontuação maior que 2500 pontos
    2. Candidato do sexo masculino com maior pontuação
    3. Candidato do sexo masculino com maior pontuação em Sistemas de Informação
    4. Percentual geral de candidatos do sexo masculino e feminino inscritos no vestibular
  ''';

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
    } else if (choice == '2') {
      stdout.write('Campos a serem exibidos (separados por vírgula ex: 1,2):\n0. Nenhum\n 1. Código\n 2. Curso\n 3. Nome\n 4. Sexo\n 5. Pontuação\n');
      String? camposInput = stdin.readLineSync();
      List<int> campos = camposInput?.split(',').map((e) => int.tryParse(e.trim()) ?? 0).toList() ?? [];
      
      stdout.write(buscasConteudo);
      String? buscaInput = stdin.readLineSync();

      if (buscaInput == '1') {
        var resultados = buscarCandidatos(candidatos, SearchCriteria.porCurso('Ciência da Computação'))
          .where((c) => c.pontuacao > 2500)
          .toList();
        print('Candidatos ao curso de Ciência da Computação com pontuação maior que 2500 pontos:');
        
        for (var c in resultados) {
          print(exibir(c, campos));
        }

      } else if (buscaInput == '2') {
        var resultado = buscarCandidatos(candidatos, SearchCriteria.porSexo(Sexo.masculino))
          .fold<Candidato?>(null, (max, c) => max == null || c.pontuacao > max.pontuacao ? c : max);
        if (resultado != null) {
          print('Candidato do sexo masculino com maior pontuação:');
          print(exibir(resultado, campos));
        } else {
          print('Nenhum candidato do sexo masculino encontrado.');
        }

      } else if (buscaInput == '3') {
        var resultado = buscarCandidatos(candidatos, SearchCriteria.porSexo(Sexo.masculino))
          .where((c) => c.curso.toLowerCase() == 'sistemas de informação')
          .fold<Candidato?>(null, (max, c) => max == null || c.pontuacao > max.pontuacao ? c : max);
        if (resultado != null) {
          print('Candidato do sexo masculino com maior pontuação em Sistemas de Informação:');
          print(exibir(resultado, campos));
        } else {
          print('Nenhum candidato do sexo masculino encontrado em Sistemas de Informação.');
        }
      } else if (buscaInput == '4') {
        int total = candidatos.length;
        int masculinos = candidatos.where((c) => c.sexo == Sexo.masculino).length;
        int femininos = candidatos.where((c) => c.sexo == Sexo.feminino).length;
        double percentualMasculino = total > 0 ? (masculinos / total) * 100 : 0;
        double percentualFeminino = total > 0 ? (femininos / total) * 100 : 0;

        print('Percentual geral de candidatos do sexo masculino: ${percentualMasculino.toStringAsFixed(2)}%');
        print('Percentual geral de candidatos do sexo feminino: ${percentualFeminino.toStringAsFixed(2)}%');
      } else {
        print('Opção de busca inválida.');
      }
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

List<Candidato> buscarCandidatos(List<Candidato> candidatos, SearchCriteria criteria) {
  return candidatos.where(criteria.predicado).toList();
}

class SearchCriteria {
  final String descricao;
  final bool Function(Candidato) predicado;
  SearchCriteria({required this.descricao, required this.predicado});

  factory SearchCriteria.porCodigo(String valor) => SearchCriteria(
    descricao: 'codigo == $valor',
    predicado: (c) => c.codigo.toLowerCase() == valor.toLowerCase(),
  );
 
  factory SearchCriteria.porNome(String valor) => SearchCriteria(
    descricao: 'nome contém "$valor"',
    predicado: (c) =>
      c.nome.toLowerCase().contains(valor.toLowerCase()),
  );
 
  factory SearchCriteria.porCurso(String valor) => SearchCriteria(
    descricao: 'curso == $valor',
    predicado: (c) =>
      c.curso.toLowerCase() == valor.toLowerCase(),
  );
 
  factory SearchCriteria.porSexo(Sexo valor) => SearchCriteria(
    descricao: 'sexo == ${valor == Sexo.masculino ? 'M' : 'F'}',
    predicado: (c) => c.sexo == valor,
  );
 
  factory SearchCriteria.pontuacaoMaiorQue(int valor) => SearchCriteria(
    descricao: 'pontuação > $valor',
    predicado: (c) => c.pontuacao > valor,
  );
 
  factory SearchCriteria.pontuacaoMenorQue(int valor) => SearchCriteria(
    descricao: 'pontuação < $valor',
    predicado: (c) => c.pontuacao < valor,
  );
 
  factory SearchCriteria.pontuacaoIgualA(int valor) => SearchCriteria(
    descricao: 'pontuação == $valor',
    predicado: (c) => c.pontuacao == valor,
  );
}

String exibir(Candidato resultado, List<int> campos) {
  return
    '${campos.contains(1) ? 'Código: ${resultado.codigo} ' : ''}'
    '${campos.contains(2) ? 'Curso: ${resultado.curso} ' : ''}'
    '${campos.contains(3) ? 'Nome: ${resultado.nome} ' : ''}'
    '${campos.contains(4) ? 'Sexo: ${resultado.sexo == Sexo.masculino ? 'M' : 'F'} ' : ''}'
    '${campos.contains(5) ? 'Pontuação: ${resultado.pontuacao}' : ''}';
}