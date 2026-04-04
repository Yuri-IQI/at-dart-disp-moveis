import 'dart:io';

void main() {
  List<List<String>> tabuleiro = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' '],
  ];

  gameLoop(tabuleiro);
}

void gameLoop(List<List<String>> tabuleiro) {
  String jogadorAtual = 'X';

  while (true) {
    imprimirTabuleiro(tabuleiro);

    print('\n($jogadorAtual) Digite linha e coluna (ex: 0,1) ou "sair":');
    String? entrada = stdin.readLineSync();

    if (entrada == null || entrada.trim().isEmpty) {
      print('Entrada inválida');
      continue;
    }

    if (entrada.toLowerCase() == 'sair') break;

    List<String> partes = entrada.split(',');

    if (partes.length != 2) {
      print('Formato inválido, use: linha,coluna');
      continue;
    }

    int? linha = int.tryParse(partes[0].trim());
    int? coluna = int.tryParse(partes[1].trim());

    if (linha == null || coluna == null) {
      print('Valores inválidos');
      continue;
    }

    if (linha < 0 || linha > 2 || coluna < 0 || coluna > 2) {
      print('Posição fora do tabuleiro');
      continue;
    }

    if (tabuleiro[linha][coluna] != ' ') {
      print('Posição já está ocupada');
      continue;
    }

    tabuleiro[linha][coluna] = jogadorAtual;

    if (verificarResultado(tabuleiro, jogadorAtual)) {
      imprimirTabuleiro(tabuleiro);
      print('\n$jogadorAtual venceu');
      break;
    }

    if (verificarEmpate(tabuleiro)) {
      imprimirTabuleiro(tabuleiro);
      print('\nEmpate');
      break;
    }

    jogadorAtual = (jogadorAtual == 'X') ? 'O' : 'X';
  }
}

void imprimirTabuleiro(List<List<String>> tabuleiro) {
  print('');
  for (int i = 0; i < 3; i++) {
    print(' ${tabuleiro[i][0]} | ${tabuleiro[i][1]} | ${tabuleiro[i][2]} ');
    if (i < 2) {
      print('---+---+---');
    }
  }
}

bool verificarResultado(List<List<String>> t, String jogador) {
  for (int i = 0; i < 3; i++) {
    if (t[i][0] == jogador && t[i][1] == jogador && t[i][2] == jogador) {
      return true;
    }
  }

  for (int i = 0; i < 3; i++) {
    if (t[0][i] == jogador && t[1][i] == jogador && t[2][i] == jogador) {
      return true;
    }
  }

  if (t[0][0] == jogador && t[1][1] == jogador && t[2][2] == jogador) {
    return true;
  }

  if (t[0][2] == jogador && t[1][1] == jogador && t[2][0] == jogador) {
    return true;
  }

  return false;
}

bool verificarEmpate(List<List<String>> t) {
  for (var linha in t) {
    for (var celula in linha) {
      if (celula == ' ') return false;
    }
  }
  return true;
}