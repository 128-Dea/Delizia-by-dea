import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/detail_kue_page.dart';
import '../model/kue_kering.dart';
import '../model/kue_basah.dart';
import '../model/kue_ultah.dart';
import 'tambah_produk_page.dart';

class HomePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final List<Map<String, dynamic>> cart;

  const HomePage({super.key, required this.onAddToCart, required this.cart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String username = "Delizia";

  String _searchQuery = "";
  String _selectedSort = "Nama";
  List<dynamic> _searchResults = [];

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "Selamat Pagi";
    if (hour >= 12 && hour < 15) return "Selamat Siang";
    if (hour >= 15 && hour < 18) return "Selamat Sore";
    return "Selamat Malam";
  }

  List<dynamic> _allKue() {
    return [
      ...KueKering.daftarKueKering,
      ...KueBasah.daftarKueBasah,
      ...KueUltah.daftarKueUltah,
    ];
  }

  void _filterResults() {
    final query = _searchQuery.trim().toLowerCase();
    final all = _allKue();

    List<dynamic> filtered;

    if (query.isNotEmpty) {
      filtered = all.where((kue) {
        final nama = kue.nama.toString().toLowerCase();
        String extra = "";
        if (kue is KueKering) extra = kue.rasa.toLowerCase();
        if (kue is KueBasah) extra = kue.dayaTahan.toString();
        if (kue is KueUltah) extra = kue.ucapan.toLowerCase();
        return nama.contains(query) || extra.contains(query);
      }).toList();
    } else {
      filtered = all;
    }

    if (_selectedSort == "Nama") {
      filtered.sort((a, b) => a.nama.compareTo(b.nama));
    } else if (_selectedSort == "Harga") {
      filtered.sort((a, b) => a.harga.compareTo(b.harga));
    }

    setState(() => _searchResults = filtered);
  }

  String _getCategoryForItem(dynamic item) {
    if (KueKering.daftarKueKering.contains(item)) return "Kue Kering";
    if (KueBasah.daftarKueBasah.contains(item)) return "Kue Basah";
    if (KueUltah.daftarKueUltah.contains(item)) return "Kue Ulang Tahun";
    return "Umum";
  }

  @override
  void initState() {
    super.initState();
    _filterResults();
  }

  @override
  Widget build(BuildContext context) {
    final semuaProduk = _allKue();

    final List<Map<String, dynamic>> kategori = [
      {
        "nama": "Kue Kering",
        "icon": Icons.cookie,
        "warna": const Color.fromARGB(255, 158, 131, 121),
        "page": Scaffold(
          appBar: AppBar(
            title: const Text("Kue Kering"),
            backgroundColor: const Color.fromARGB(245, 222, 184, 140),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: KueKering.daftarKueKering.length,
            itemBuilder: (context, index) {
              final kue = KueKering.daftarKueKering[index];
              return Card(
                color: const Color.fromARGB(255, 233, 215, 194),
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  leading: Image.asset(
                    kue.gambar,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    kue.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Rasa: ${kue.rasa}\nHarga: Rp${kue.harga.toInt()}",
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailKuePage(
                          kue: kue,
                          onAddToCart: widget.onAddToCart,
                          cart: widget.cart,
                          semuaProduk: semuaProduk,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      },
      {
        "nama": "Kue Basah",
        "icon": Icons.bakery_dining,
        "warna": const Color.fromARGB(255, 127, 165, 142),
        "page": Scaffold(
          appBar: AppBar(
            title: const Text("Kue Basah"),
            backgroundColor: const Color.fromARGB(245, 222, 184, 140),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: KueBasah.daftarKueBasah.length,
            itemBuilder: (context, index) {
              final kue = KueBasah.daftarKueBasah[index];
              return Card(
                color: const Color.fromARGB(255, 233, 215, 194),
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  leading: Image.asset(
                    kue.gambar,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    kue.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Daya Tahan: ${kue.dayaTahan} hari\nHarga: Rp${kue.harga.toInt()}",
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailKuePage(
                          kue: kue,
                          onAddToCart: widget.onAddToCart,
                          cart: widget.cart,
                          semuaProduk: semuaProduk,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      },
      {
        "nama": "Kue Ulang Tahun",
        "icon": Icons.cake,
        "warna": const Color.fromARGB(255, 99, 134, 163),
        "page": Scaffold(
          appBar: AppBar(
            title: const Text("Kue Ulang Tahun"),
            backgroundColor: const Color.fromARGB(245, 222, 184, 140),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: KueUltah.daftarKueUltah.length,
            itemBuilder: (context, index) {
              final kue = KueUltah.daftarKueUltah[index];
              return Card(
                color: const Color.fromARGB(255, 233, 215, 194),
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  leading: Image.asset(
                    kue.gambar,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    kue.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Ukuran: ${kue.ukuran}\nUcapan: ${kue.ucapan}\nHarga: Rp${kue.harga.toInt()}",
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailKuePage(
                          kue: kue,
                          onAddToCart: widget.onAddToCart,
                          cart: widget.cart,
                          semuaProduk: semuaProduk,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Kue DELIZIA"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==== HEADER SAPAAN ====
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(245, 222, 184, 140),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/profil.jpeg"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${getGreeting()},",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Pelanggan $username 🍪",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ==== SEARCHING & SORTING ====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari kue favoritmu...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      _searchQuery = value;
                      _filterResults();
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Urutkan berdasarkan:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedSort,
                        items: const [
                          DropdownMenuItem(value: "Nama", child: Text("Nama")),
                          DropdownMenuItem(
                            value: "Harga",
                            child: Text("Harga"),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedSort = value);
                          _filterResults();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ==== GRID KATEGORI ====
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: List.generate(kategori.length, (index) {
                  final item = kategori[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item["page"]),
                      );
                    },
                    child: Card(
                      color: item["warna"],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item["icon"], size: 50, color: Colors.white),
                          const SizedBox(height: 12),
                          Text(
                            item["nama"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
