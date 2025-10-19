import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/product.dart';
import '../model/alamat_store.dart';

class DetailPesananPage extends StatelessWidget {
  final String alamat;
  final String metodePembayaran;
  final String kurir;
  final List<Map<String, dynamic>> items;
  final int total;
  final double diskon;
  final String estimasi;

  const DetailPesananPage({
    super.key,
    required this.alamat,
    required this.metodePembayaran,
    required this.kurir,
    required this.items,
    required this.total,
    required this.diskon,
    required this.estimasi,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pesanan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Alamat Pengiriman",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(alamat),
                    Text("Kurir: $kurir"),
                    Text("Metode Pembayaran: $metodePembayaran"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final kue = item['kue'] as Product;
                  final qty = item['quantity'] as int;
                  return ListTile(
                    leading: Image.asset(kue.gambar, width: 50, height: 50),
                    title: Text(kue.nama),
                    subtitle: Text("Jumlah: $qty"),
                    trailing: Text(currencyFormatter.format(kue.harga * qty)),
                  );
                },
              ),
            ),
            Text(
              "Total Bayar: ${currencyFormatter.format(total)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Estimasi Tiba: $estimasi",
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
