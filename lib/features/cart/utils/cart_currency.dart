// Formatação de moeda em pt-BR (ex: R$ 1.234,56), sem dependência externa.

String _groupThousands(String digits) {
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

// Apenas o número com separadores: 1002.0 -> "1.002,00"
String cartCurrencyValue(double value) {
  final parts = value.toStringAsFixed(2).split('.');
  return '${_groupThousands(parts[0])},${parts[1]}';
}

// Com o prefixo de moeda: 1002.0 -> "R$ 1.002,00"
String cartCurrency(double value) => 'R\$ ${cartCurrencyValue(value)}';
