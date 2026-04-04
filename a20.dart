import 'dart:io';

void main() {
  List<List<String>> mapa = [
    ['#', 'E', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
    ['#', ' ', ' ', '#', ' ', '#', ' ', ' ', ' ', '#', ' ', '#'],
    ['#', ' ', ' ', '#', ' ', '#', '#', ' ', '#', '#', ' ', '#'],
    ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'],
    ['#', '#', '#', ' ', ' ', ' ', '#', '#', '#', '#', ' ', '#'],
    ['#', ' ', ' ', ' ', ' ', ' ', ' ', '#', ' ', '#', ' ', '#'],
    ['#', ' ', ' ', '#', ' ', '#', ' ', '#', ' ', '#', 'S', '#'],
    ['#', ' ', ' ', ' ', ' ', '#', ' ', '#', ' ', '#', ' ', '#'],
    ['#', ' ', '#', ' ', '#', '#', '#', '#', ' ', '#', ' ', '#'],
    ['#', ' ', '#', ' ', ' ', ' ', ' ', '#', ' ', '#', ' ', '#'],
    ['#', ' ', '#', '#', '#', '#', ' ', '#', ' ', ' ', ' ', '#'],
    ['#', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', '#'],
    ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
  ];

  List<int> pos = encontrarEntrada(mapa);

  while (true) {
    imprimirMapa(mapa, pos[0], pos[1]);

    print('\nUse W A S D para mover (ou 0 para sair):');
    String? movimento = stdin.readLineSync();

    if (movimento == '0') break;

    update(mapa, movimento, pos);

    if (mapa[pos[0]][pos[1]] == 'S') {
      print('Você chegou ao objetivo!');
      break;
    }

    print('\x1B[2J\x1B[0;0H');
  }
}

List<int> encontrarEntrada(List<List<String>> mapa) {
  for (int i = 0; i < mapa.length; i++) {
    for (int j = 0; j < mapa[i].length; j++) {
      if (mapa[i][j] == 'E') {
        return [i, j];
      }
    }
  }
  return [0, 0];
}

void imprimirMapa(List<List<String>> mapa, int playerX, int playerY) {
  for (int i = 0; i < mapa.length; i++) {
    for (int j = 0; j < mapa[i].length; j++) {
      if (i == playerX && j == playerY) {
        stdout.write('P ');
      } else {
        stdout.write('${mapa[i][j]} ');
      }
    }
    print('');
  }
}

bool update(List<List<String>> mapa, String? movimento, List<int> pos) {
  int x = pos[0];
  int y = pos[1];

  int novoX = x;
  int novoY = y;

  if (movimento == 'w') novoX--;
  if (movimento == 's') novoX++;
  if (movimento == 'a') novoY--;
  if (movimento == 'd') novoY++;

  if (mapa[novoX][novoY] != '#') {
    pos[0] = novoX;
    pos[1] = novoY;
    return true;
  }

  return false;
}