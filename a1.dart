void main() {
  Map boloPrecos = {'ovos' : 5.5, 'chocolate' : 7.5, 'cenoura' : 6.5 };
  List ordem = ['ovos', 'chocolate', 'repolho'];

  double res = calcularTotal(boloPrecos, ordem);
  print('Valor Total: ' + res.toString());
}

double calcularTotal(Map cakeOptions, List order) {
  double total = 0;
  for (var cake in order) {
    if (!cakeOptions.keys.contains(cake)) {
      print(cake + " não está no cardápio");
      break;
    }

    total += cakeOptions[cake];
  }

  return total;
}