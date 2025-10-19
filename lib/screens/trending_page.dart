import 'package:flutter/material.dart';
import 'detail_kue_page.dart'; // ✅ pastikan path sesuai struktur project kamu

class TrendingPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSelectDiscount;

  const TrendingPage({super.key, required this.onSelectDiscount});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  // 🎁 Daftar Diskon
  final List<Map<String, dynamic>> discounts = [
    {
      "title": "Diskon 10% Semua Kue Ulang Tahun 🎂",
      "description": "Nikmati potongan harga 10% untuk semua kue ulang tahun!",
      "type": "percent",
      "value": 0.10,
      "color": Colors.orangeAccent,
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
      "description": "Bebas biaya kirim untuk pembelian minimal Rp250.000.",
      "type": "flat",
      "value": 10000,
      "color": Colors.orangeAccent,
    },
    {
      "title": "Beli 3 diskon 10% 🎉",
      "description":
          "Khusus Hari ini! Setiap pembelian 3 kue, dapatkan diskon hingga 10%!",
      "type": "bonus",
      "value": 0,
      "color": Colors.orangeAccent,
    },
    {
      "title": "Cashback Rp15.000 💸",
      "description":
          "Dapatkan cashback Rp15.000 untuk transaksi di atas Rp100.000.",
      "type": "flat",
      "value": 15000,
      "color": Colors.orangeAccent,
    },
  ];

  // 🍰 Daftar Kue Trending
  final List<Map<String, dynamic>> trendingCakes = [
    {
      "nama": "Red Velvet",
      "harga": 150000,
      "gambar": "assets/images/Red Velvet Cake.jpeg",
      "deskripsi": "Kue lembut berlapis krim keju khas Red Velvet.",
      "jenis": "Ulang Tahun",
    },
    {
      "nama": "Kue Putu Ayu",
      "harga": 3000,
      "gambar": "assets/images/putu ayu.jpeg",
      "deskripsi":
          "Kue tradisional lembut dengan aroma pandan dan kelapa parut.",
      "jenis": "Basah",
    },
    {
      "nama": "Nastar Premium",
      "harga": 75000,
      "gambar": "assets/images/nastar.jpeg",
      "deskripsi":
          "Kue kering isi nanas premium dengan rasa gurih dan manis seimbang.",
      "jenis": "Kering",
    },
    {
      "nama": "Black Forest",
      "harga": 150000,
      "gambar": "assets/images/black forest.jpeg",
      "deskripsi":
          "Kue cokelat klasik dengan krim dan taburan ceri di atasnya.",
      "jenis": "Ulang Tahun",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),
      appBar: AppBar(
        title: const Text(
          "Trending & Promo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🎁 Bagian Diskon
          const Text(
            "Penawaran Spesial Hari Ini 🎉",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Column(
            children: discounts.map((item) {
              final Color color = item["color"] as Color;
              return Card(
                color: color.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withOpacity(0.4),
                    child: const Icon(Icons.local_offer, color: Colors.white),
                  ),
                  title: Text(
                    item["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(item["description"]),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      widget.onSelectDiscount(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Diskon diterapkan: ${item["title"]}"),
                          backgroundColor: color,
                        ),
                      );
                    },
                    child: const Text("Ambil"),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          // 🍰 Bagian Kue Trending
          const Text(
            "Trending Kue Paling Laris 🍰",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: trendingCakes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final cake = trendingCakes[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    // ✅ Cukup munculin pesan dulu kalau diklik
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${cake['nama']} diklik!"),
                        backgroundColor: Colors.orangeAccent,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          cake["gambar"],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cake["nama"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Rp${cake["harga"]}",
                              style: const TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
