import 'dart:io';

void main() {
  List<CandidatoServico> candidatos = [];
  loopMenu(candidatos);
}

void loopMenu(List<CandidatoServico> candidatos) {
  print("""
    Menu:
    1. Cadastrar candidato
    2. Número de candidatos por sexo
    3. Idade média dos homens com experiência
    4. Porcentagem de homens com mais de 45 anos do total de homens
    5. Número de mulheres com idade inferior a 30 anos e com experiência
    6. Nome da candidata com a menor idade que possuí experiência
    7. Sair
  """);

  String? escolha = stdin.readLineSync();

  switch (escolha) {
    case '1':
      loopCadastro(candidatos);
      break;
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
      consulta(candidatos, escolha);
      break;
    case '7':
    case 'Sair':
    case 'sair':
    case 'SAIR':
    case 'FIM':
    case 'fim':
    case 'Fim':
      return;
    default:
      print('Opção inválida');
  }
}

void loopCadastro(List<CandidatoServico> candidatos) {
  print('Digite o nome do candidato (ou "FIM" para encerrar):');
  String? nome = stdin.readLineSync();

  if (nome == 'FIM' || nome == 'fim') {
    loopMenu(candidatos);
    return;
  }

  print('Digite o sexo do candidato (M/F):');
  String? sexo = stdin.readLineSync();

  print('Digite a idade do candidato:');
  String? idade = stdin.readLineSync();

  print('O candidato tem experiência? (S/N):');
  String? experienciaInput = stdin.readLineSync();
  bool temExperiencia = experienciaInput?.toLowerCase() == 's';

  candidatos.add(CandidatoServico(nome ?? '', sexo ?? '', idade ?? '', temExperiencia));

  loopCadastro(candidatos);
}

void consulta(List<CandidatoServico> candidatos, String? escolha) {
  switch (escolha) {
    case '2':
      int numHomens = candidatos.where((c) => c.sexo == 'M' || c.sexo == 'm').length;
      int numMulheres = candidatos.where((c) => c.sexo == 'F' || c.sexo == 'f').length;
      print('Número de homens: $numHomens');
      print('Número de mulheres: $numMulheres');
      break;
    case '3':
      List<CandidatoServico> homensComExperiencia = candidatos
        .where((c) => (c.sexo == 'M' || c.sexo == 'm') && c.temExperiencia)
        .toList();

      int soma = homensComExperiencia.fold(0, (prev, c) => prev + (int.tryParse(c.idade) ?? 0));

      if (homensComExperiencia.length == 0) {
        print('Nenhum homem com experiência encontrado para calcular a idade média.');
        break;
      }

      double idadeMediaHomens = soma / homensComExperiencia.length;
      print('Idade média dos homens com experiência: $idadeMediaHomens');
      break;
    case '4':
      int numHomensAcima45 = candidatos
        .where((c) => (c.sexo == 'M' || c.sexo == 'm') && int.tryParse(c.idade) != null && int.tryParse(c.idade)! > 45)
        .length;
      double porcentagemHomensAcima45 = (numHomensAcima45 / candidatos.where((c) => (c.sexo == 'M' || c.sexo == 'm')).length) * 100;
      print('Porcentagem de homens com mais de 45 anos: $porcentagemHomensAcima45%');
      break;
    case '5':
      int numMulheresAbaixo30 = candidatos
        .where((c) => (c.sexo == 'F' || c.sexo == 'f') && int.tryParse(c.idade) != null && int.tryParse(c.idade)! < 30 && c.temExperiencia)
        .length;
      print('Número de mulheres com menos de 30 anos e com experiência: $numMulheresAbaixo30');
      break;
    case '6':
      List<CandidatoServico> candidatasComExperiencia = candidatos
        .where((c) => (c.sexo == 'F' || c.sexo == 'f') && c.temExperiencia)
        .toList();

      if (candidatasComExperiencia.isEmpty) {
        print('Nenhuma candidata com experiência encontrada.');
        break;
      }

      String? nomeCandidataMaisNova = candidatasComExperiencia
        .map((c) => c.nome)
        .reduce((a, b) => a.compareTo(b) < 0 ? a : b);
      print('Nome da candidata mais nova com experiência: $nomeCandidataMaisNova');
      break;
    default:
      print('Opção inválida');
  }

  loopMenu(candidatos);
}

class CandidatoServico {
  String nome;
  String sexo;
  String idade;
  bool temExperiencia;

  CandidatoServico(this.nome, this.sexo, this.idade, this.temExperiencia);
}