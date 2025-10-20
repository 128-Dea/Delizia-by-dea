import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/order_history.dart';
import '../services/order_history_service.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void _hapusSemua(BuildContext context) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Semua Riwayat?"),
        content: const Text(
          "Apakah kamu yakin ingin menghapus seluruh riwayat pesanan?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (konfirmasi == true) {
      await OrderHistoryService.hapusSemuaPesanan();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Riwayat pesanan berhasil dihapus.")),
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final riwayat = OrderHistoryService.riwayatPesanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
        actions: riwayat.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_forever_rounded),
                  onPressed: () => _hapusSemua(context),
                ),
              ]
            : null,
      ),
      body: riwayat.isEmpty
          ? const Center(
              child: Text(
                "Belum ada riwayat pesanan.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                final pesanan = riwayat[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pesanan ${index + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("Tanggal: ${pesanan.tanggalJam}"),
                        const SizedBox(height: 4),
                        Text("Metode Pembayaran: ${pesanan.metodePembayaran}"),
                        Text(
                          "Kurir: ${pesanan.kurir} | Estimasi Tiba: ${pesanan.estimasiTiba}",
                        ),
                        const Divider(height: 16),
                        const Text(
                          "Items:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Column(
                          children: pesanan.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("• ${item.nama}")),
                                  Text(_currencyFormatter.format(item.harga)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const Divider(height: 16),
                        Text(
                          "Diskon: ${_currencyFormatter.format(pesanan.diskon)}",
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text(
                          "Total: ${_currencyFormatter.format(pesanan.total)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
