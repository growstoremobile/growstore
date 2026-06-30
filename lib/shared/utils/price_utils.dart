double parseGrowPrice(Object? value) {
  if (value is num) return value.toDouble();

  var raw = value?.toString().trim() ?? '';
  if (raw.isEmpty) return 0;

  raw = raw.replaceAll(RegExp(r'[^0-9,.\-]'), '');
  if (raw.isEmpty) return 0;

  final lastComma = raw.lastIndexOf(',');
  final lastDot = raw.lastIndexOf('.');
  final separatorIndex = lastComma > lastDot ? lastComma : lastDot;

  if (separatorIndex == -1) {
    return double.tryParse(raw.replaceAll(RegExp(r'[^0-9\-]'), '')) ?? 0;
  }

  final decimals = raw
      .substring(separatorIndex + 1)
      .replaceAll(RegExp(r'[^0-9]'), '');
  final separatorCount = RegExp(r'[,\.]').allMatches(raw).length;

  if (separatorCount == 1 && decimals.length == 3) {
    return double.tryParse(raw.replaceAll(RegExp(r'[^0-9\-]'), '')) ?? 0;
  }

  final integer = raw
      .substring(0, separatorIndex)
      .replaceAll(RegExp(r'[^0-9\-]'), '');
  final normalized = '$integer.$decimals';

  return double.tryParse(normalized) ?? 0;
}

String groupThousands(String digits) {
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }

  return buffer.toString();
}

String formatGrowCurrencyValue(double value) {
  final parts = value.toStringAsFixed(2).split('.');

  return '${groupThousands(parts[0])},${parts[1]}';
}

String formatGrowCurrency(double value) {
  return 'R\$ ${formatGrowCurrencyValue(value)}';
}
