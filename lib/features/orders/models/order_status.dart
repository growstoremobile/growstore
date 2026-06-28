enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered;

  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'PENDING';
      case OrderStatus.processing:
        return 'PROCESSING';
      case OrderStatus.shipped:
        return 'SHIPPED';
      case OrderStatus.delivered:
        return 'DELIVERED';
    }
  }

  static OrderStatus fromString(Object? value) {
    final normalized = value?.toString().trim().toUpperCase();

    return switch (normalized) {
      'PROCESSING' => OrderStatus.processing,
      'SHIPPED' => OrderStatus.shipped,
      'DELIVERED' => OrderStatus.delivered,
      _ => OrderStatus.pending,
    };
  }
}
