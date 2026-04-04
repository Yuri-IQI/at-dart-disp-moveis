import 'dart:io';
import 'dart:math';
import 'a20.dart';

void main() {
  List<String> palavras = [
    'Morte', 'Misericórdia', 'Pestilência', 
    'Desespero', 'Agonia', 'Medo', 
    'Condenação', 'Penitência', 'Amor', 
    'Miséria', 'Tragédia', 'Desamparo',
    'Incompreensão', 'Inalcançável', 'Impróprio',
  ];

  String segredoOriginal = palavras[Random().nextInt(palavras.length)];
  String segredo = toNormalized(segredoOriginal.toLowerCase());

  List<String> adivinhado = List.filled(segredo.length, '_');
  List<String> letrasUsadas = [];

  int curErros = 0;
  int maxErros = 5;

  gameLoop(palavras.map((p) => toNormalized(p.toLowerCase()).split('')).toList(), segredo, segredoOriginal, adivinhado, letrasUsadas, curErros, maxErros);
}

void gameLoop(List<List<String>> palavras, String segredo, String segredoOriginal, List<String> adivinhado, List<String> letrasUsadas, int curErros, int maxErros) {
  while (true) {
    print('\nPalavra: ${adivinhado.map((c) => c.toUpperCase()).join(' ')}');
    print('Letras usadas: ${letrasUsadas.map((l) => l.toUpperCase()).join(', ')}');
    print('Erros: $curErros/$maxErros');

    stdout.write('adivinhe uma letra: ');
    String? letra = stdin.readLineSync()?.toUpperCase();

    if (letra == null || letra.length != 1 || !RegExp(r'^[A-Z]$').hasMatch(letra)) {
      print('Entrada inválida. Digite apenas uma letra.');
      continue;
    }

    String letraTratada = toNormalized(letra[0].toLowerCase());

    if (letrasUsadas.contains(letraTratada)) {
      print('Você já tentou a letra $letraTratada.');
      continue;
    }

    letrasUsadas.add(letraTratada);

    if (segredo.contains(letraTratada)) {
      for (int i = 0; i < segredo.length; i++) {
        if (segredo[i] == letraTratada) {
          adivinhado[i] = segredoOriginal[i];
        }
      }
    } else {
      curErros++;
    }

    limparTerminal();
    imprimirForca(curErros);

    if (!adivinhado.contains('_')) {
      print('\nVocê acertou, a palavra era: $segredoOriginal');
      break;
    }

    if (curErros >= maxErros) {
      print('\nVocê perdeu, a palavra era: $segredoOriginal');
      break;
    }
  }
}

enum StringNormalizada {
  a('aáàâãä'),
  e('eéèêë'),
  i('iíìîï'),
  o('oóòôõö'),
  u('uúùûü'),
  c('cç');

  final String chars;
  const StringNormalizada(this.chars);
}

String toNormalized(String str) {
  String res = str;
  for (var grupo in StringNormalizada.values) {
    res = res.replaceAll(
      RegExp('[${grupo.chars}]'),
      grupo.name,
    );
  }

  return res.toLowerCase();
}

void imprimirForca(int erros) {
  if (erros >= 1) print('  O');
  if (erros >= 2) print('  |');
  if (erros >= 3) print(' /|\\');
  if (erros >= 4) print('  |');
  if (erros >= 5) print(' / \\');
}