import 'package:flutter/material.dart';

class TrendingPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSelectDiscount;

  const TrendingPage({super.key, required this.onSelectDiscount});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final List<Map<String, dynamic>> discounts = [
    {
      "title": "Diskon 10% Semua Kue Ulang Tahun 🎂",
      "description": "Nikmati potongan harga 10% untuk semua kue ulang tahun!",
      "type": "percent",
      "value": 0.10,
      "color": Colors.pinkAccent,
    },
    {
      "title": "Potongan Rp20.000 Kue Kering 🍪",
      "description": "Diskon langsung Rp20.000 untuk semua kue kering.",
      "type": "flat",
      "value": 20000,
      "color": Colors.orangeAccent,
    },
    {
      "title": "Gratis Ongkir 🚚",
      "description": "Bebas biaya kirim untuk pembelian minimal Rp50.000.",
      "type": "flat",
      "value": 10000,
      "color": Colors.lightBlueAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 242),
      appBar: AppBar(
        title: const Text("Trending Diskon"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: discounts.length,
        itemBuilder: (context, index) {
          final item = discounts[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item["color"].withOpacity(0.2),
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                ),
              ),
              title: Text(
                item["title"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item["description"]),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: item["color"],
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  widget.onSelectDiscount(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Diskon diterapkan: ${item["title"]}"),
                      backgroundColor: item["color"],
                    ),
                  );
                },
                child: const Text("Ambil"),
              ),
            ),
          );
        },
      ),
    );
  }
}
