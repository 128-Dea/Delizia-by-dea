import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/detail_kue_page.dart';
import '../model/kue_kering.dart';
import '../model/kue_basah.dart';
import '../model/kue_ultah.dart';

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
      filtered = [];
    }

    if (_selectedSort == "Nama") {
      filtered.sort((a, b) => a.nama.compareTo(b.nama));
    } else if (_selectedSort == "Harga") {
      filtered.sort((a, b) => a.harga.compareTo(b.harga));
    }

    setState(() => _searchResults = filtered);
  }

  @override
  void initState() {
    super.initState();
    _filterResults();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final bannerHeight = isMobile ? 120.0 : 180.0;
    final gridCount = isMobile ? 2 : 3;

    final semuaProduk = _allKue();

    final List<Map<String, dynamic>> kategori = [
      {
        "nama": "Kue Kering",
        "icon": Icons.cookie,
        "warna": const Color.fromARGB(255, 158, 131, 121),
        "data": KueKering.daftarKueKering,
      },
      {
        "nama": "Kue Basah",
        "icon": Icons.bakery_dining,
        "warna": const Color.fromARGB(255, 127, 165, 142),
        "data": KueBasah.daftarKueBasah,
      },
      {
        "nama": "Kue Ulang Tahun",
        "icon": Icons.cake,
        "warna": const Color.fromARGB(255, 99, 134, 163),
        "data": KueUltah.daftarKueUltah,
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
            // === Header Sapa ===
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
                          style: TextStyle(
                            fontSize: isMobile ? 13 : 15,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Pelanggan $username 🍪",
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // === Search & Sort ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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

            // === Jika ada pencarian ===
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: _searchResults.isEmpty
                    ? const Text(
                        "Kue tidak ditemukan 😢",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final kue = _searchResults[index];
                          return GestureDetector(
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
                            child: Card(
                              color: const Color.fromARGB(255, 233, 215, 194),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      kue.gambar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          kue.nama,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text("Rp${kue.harga.toInt()}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            else
              Column(
                children: [
                  // === Banner Promosi ===
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: bannerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/promosi.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Surga Kue Lezat - Hanya di Delizia 🎉",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 14 : 18,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Nikmati kelezatan kue homemade berkualitas 💖",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 11 : 13,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // === Grid Kategori ===
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: gridCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: List.generate(kategori.length, (index) {
                        final item = kategori[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Scaffold(
                                  appBar: AppBar(
                                    title: Text(item["nama"]),
                                    backgroundColor: const Color.fromARGB(
                                      245,
                                      222,
                                      184,
                                      140,
                                    ),
                                  ),
                                  body: ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: (item["data"] as List).length,
                                    itemBuilder: (context, i) {
                                      final kue = (item["data"] as List)[i];
                                      return Card(
                                        color: const Color.fromARGB(
                                          255,
                                          233,
                                          215,
                                          194,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Harga: Rp${kue.harga.toInt()}",
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => DetailKuePage(
                                                  kue: kue,
                                                  onAddToCart:
                                                      widget.onAddToCart,
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
                              ),
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
                                Icon(
                                  item["icon"],
                                  size: isMobile ? 36 : 50,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  item["nama"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isMobile ? 13 : 16,
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
          ],
        ),
      ),
    );
  }
}
