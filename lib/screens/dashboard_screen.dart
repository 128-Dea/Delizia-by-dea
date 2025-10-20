import 'package:flutter/material.dart';
import 'home.dart';
import 'keranjang_page.dart';
import 'settings_page.dart';
import 'theme_notifier.dart';
import 'notification_page.dart';
import 'trending_page.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  final int initialIndex;
  final ThemeNotifier themeNotifier;

  const DashboardScreen({
    super.key,
    required this.username,
    this.initialIndex = 0,
    required this.themeNotifier,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _selectedIndex;
  final List<Map<String, dynamic>> cart = [];
  Map<String, dynamic>? selectedDiscount;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Tambah produk ke keranjang
  void addToCart(Map<String, dynamic> item) {
    setState(() {
      int index = cart.indexWhere((element) => element["kue"] == item["kue"]);
      if (index >= 0) {
        cart[index]["quantity"] += item["quantity"];
      } else {
        cart.add(item);
      }
    });
  }

  // Hitung total keranjang + diskon
  int computeTotal() {
    double total = 0;
    for (var item in cart) {
      final kue = item["kue"];
      final harga = (kue != null)
          ? (kue.harga ?? 0)
          : (item["price"] ?? item["harga"] ?? 0);
      final quantity = item["quantity"] ?? 1;
      total += harga * quantity;
    }

    // Terapkan diskon jika ada
    if (selectedDiscount != null) {
      final d = selectedDiscount!;
      final discountVal = (d['value'] as num?)?.toDouble() ?? 0.0;
      if (d['type'] == 'percent') {
        total = total * (1 - discountVal);
      } else {
        total = total - discountVal;
      }
    }

    return total.round().clamp(0, 1 << 63 - 1);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Halaman Home
      HomePage(onAddToCart: addToCart, cart: cart),

      // Halaman Notifikasi
      const NotificationPage(),

      // Halaman Trending (pilih diskon)
      TrendingPage(
        onSelectDiscount: (discount) {
          setState(() {
            selectedDiscount = discount;
          });
        },
      ),

      // Halaman Keranjang
      KeranjangPage(cart: cart, selectedDiscount: selectedDiscount),

      // Halaman Settings
      SettingsPage(themeNotifier: widget.themeNotifier),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 242),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(245, 222, 184, 140),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: "Trending",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Keranjang",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          ],
        ),
      ),
    );
  }
}
