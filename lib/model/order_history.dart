import 'product.dart';

class OrderHistory {
  final List<Product> items;
  final double total;
  final double diskon;
  final String metodePembayaran;
  final String kurir;
  final String estimasiTiba;
  final String tanggalJam;

  OrderHistory({
    required this.items,
    required this.total,
    required this.diskon,
    required this.metodePembayaran,
    required this.kurir,
    required this.estimasiTiba,
    required this.tanggalJam,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'diskon': diskon,
      'metodePembayaran': metodePembayaran,
      'kurir': kurir,
      'estimasiTiba': estimasiTiba,
      'tanggalJam': tanggalJam,
    };
  }

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      items: (json['items'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      diskon: (json['diskon'] as num).toDouble(),
      metodePembayaran: json['metodePembayaran'] ?? '-',
      kurir: json['kurir'] ?? '-',
      estimasiTiba: json['estimasiTiba'] ?? '-',
      tanggalJam: json['tanggalJam'] ?? '-',
    );
  }
}
