import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;

import '../model/product.dart';
import '../model/alamat_store.dart';
import '../model/order_history.dart';
import '../services/order_history_service.dart';

// -------------------- KERANJANG PAGE --------------------
class KeranjangPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Map<String, dynamic>? selectedDiscount;

  const KeranjangPage({super.key, required this.cart, this.selectedDiscount});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  Map<int, bool> _selectedItems = {};
  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    final newMap = <int, bool>{};
    for (int i = 0; i < widget.cart.length; i++) {
      newMap[i] = _selectedItems[i] ?? false;
    }
    _selectedItems = newMap;
  }

  int get _selectedTotal {
    int total = 0;
    for (int i = 0; i < widget.cart.length; i++) {
      if (_selectedItems[i] == true) {
        final item = widget.cart[i];
        final kue = item['kue'] as Product;
        final qty = item['quantity'] as int;
        total += kue.harga.toInt() * qty;
      }
    }
    return total;
  }

  void _removeAt(int index) {
    setState(() {
      widget.cart.removeAt(index);
      final newMap = <int, bool>{};
      for (int i = 0; i < widget.cart.length; i++) {
        newMap[i] = _selectedItems[i] ?? false;
      }
      _selectedItems = newMap;
    });
  }

  void _onCheckout() {
    final selectedItems = <Map<String, dynamic>>[];
    for (int i = 0; i < widget.cart.length; i++) {
      if (_selectedItems[i] == true) selectedItems.add(widget.cart[i]);
    }

    if (selectedItems.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          items: selectedItems,
          total: _selectedTotal,
          selectedDiscount: widget.selectedDiscount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _selectedTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: badges.Badge(
              badgeContent: Text(
                widget.cart.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.redAccent,
                padding: EdgeInsets.all(6),
              ),
              badgeAnimation: const badges.BadgeAnimation.scale(
                animationDuration: Duration(milliseconds: 400),
                curve: Curves.elasticOut,
              ),
              child: const Icon(Icons.shopping_cart, size: 28),
            ),
          ),
        ],
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      final kue = item['kue'] as Product;
                      final qty = item['quantity'] as int;
                      final selected = _selectedItems[index] ?? false;

                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            kue.gambar,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(kue.nama),
                        subtitle: Text("Jumlah: $qty"),
                        trailing: SizedBox(
                          width: 160,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  _currencyFormatter.format(
                                    kue.harga.toInt() * qty,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeAt(index),
                                tooltip: "Hapus item",
                              ),
                              Checkbox(
                                value: selected,
                                onChanged: (bool? val) {
                                  setState(() {
                                    _selectedItems[index] = val ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: ${_currencyFormatter.format(total)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: total > 0 ? _onCheckout : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              245,
                              222,
                              184,
                              140,
                            ),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// -------------------- CHECKOUT PAGE --------------------

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final int total;
  final Map<String, dynamic>? selectedDiscount;

  const CheckoutPage({
    super.key,
    required this.items,
    required this.total,
    this.selectedDiscount,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _metodePembayaran;
  String? _kurir;
  bool _isProcessing = false;
  bool _isFormComplete = false;

  final Map<String, int> ongkirKurir = {
    "JNE": 15000,
    "J&T": 12000,
    "SiCepat": 10000,
    "POS Indonesia": 13000,
  };

  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  void _checkFormCompletion() {
    final alamat = AlamatStore().alamat;
    final alamatLengkap =
        alamat != null &&
        alamat.nama.isNotEmpty &&
        alamat.jalan.isNotEmpty &&
        alamat.kecamatan.isNotEmpty &&
        alamat.kabupaten.isNotEmpty &&
        alamat.provinsi.isNotEmpty &&
        alamat.kodepos.isNotEmpty;

    setState(() {
      _isFormComplete =
          alamatLengkap && _metodePembayaran != null && _kurir != null;
    });
  }

  int get _totalAkhir {
    final ongkir = _kurir != null ? ongkirKurir[_kurir!] ?? 0 : 0;
    double totalDiskon = 0;

    if (widget.selectedDiscount != null) {
      final d = widget.selectedDiscount!;
      final discountValue = (d["value"] as num?)?.toDouble() ?? 0.0;
      if (d["type"] == "percent") {
        totalDiskon = widget.total.toDouble() * discountValue;
      } else if (d["type"] == "flat") {
        totalDiskon = discountValue;
      }
    }

    return (widget.total.toDouble() - totalDiskon + ongkir).toInt();
  }

  Future<void> _konfirmasiPembayaran() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final now = DateTime.now();
      final tanggalJam = DateFormat(
        'EEEE, dd MMMM yyyy – HH:mm',
        'id_ID',
      ).format(now);

      final double diskon = widget.selectedDiscount != null
          ? (widget.selectedDiscount!["type"] == "percent"
                ? widget.total * (widget.selectedDiscount!["value"] ?? 0.0)
                : (widget.selectedDiscount!["value"] ?? 0.0))
          : 0.0;

      await OrderHistoryService.tambahPesanan(
        OrderHistory(
          items: widget.items.map((e) => e['kue'] as Product).toList(),
          total: _totalAkhir.toDouble(),
          diskon: diskon,
          metodePembayaran: _metodePembayaran ?? "-",
          kurir: _kurir ?? "-",
          estimasiTiba: "3–5 Hari",
          tanggalJam: tanggalJam,
        ),
      );

      if (!mounted) return;
      setState(() => _isProcessing = false);

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Pembayaran Berhasil ✅"),
          content: const Text(
            "Pesanan kamu sudah tersimpan ke Riwayat Pesanan. Terima kasih 🩷",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // tutup
                Navigator.of(context).pop(); // balik ke keranjang
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal menyimpan pesanan: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final alamat = AlamatStore().alamat;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isFormComplete && !_isProcessing
                  ? _konfirmasiPembayaran
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(245, 222, 184, 140),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Konfirmasi Pembayaran",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Alamat Pengiriman",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  alamat != null
                      ? "${alamat.nama}, ${alamat.jalan}, ${alamat.kecamatan}, ${alamat.kabupaten}, ${alamat.provinsi}, ${alamat.kodepos}"
                      : "Belum ada alamat, silakan isi di Profil",
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Metode Pembayaran",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _metodePembayaran,
              items: [
                DropdownMenuItem(
                  value: "Transfer Bank",
                  child: Row(
                    children: const [
                      Icon(Icons.account_balance, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Transfer Bank"),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "COD",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.money,
                        color: Color.fromARGB(255, 113, 108, 10),
                      ),
                      SizedBox(width: 8),
                      Text("COD"),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "E-Wallet",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.phone_android,
                        color: Color.fromARGB(255, 18, 145, 52),
                      ),
                      SizedBox(width: 8),
                      Text("E-Wallet"),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "DANA",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Color.fromARGB(255, 39, 114, 176),
                      ),
                      SizedBox(width: 8),
                      Text("DANA"),
                    ],
                  ),
                ),
              ],
              onChanged: (val) {
                setState(() => _metodePembayaran = val);
                _checkFormCompletion();
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text(
              "Kurir Pengiriman",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _kurir,
              items: ongkirKurir.keys.map((k) {
                return DropdownMenuItem(
                  value: k,
                  child: Row(
                    children: [
                      const Icon(Icons.local_shipping, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(k),
                      const Spacer(),
                      Text(_currencyFormatter.format(ongkirKurir[k]!)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => _kurir = val);
                _checkFormCompletion();
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text(
              "Barang yang Dibeli",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final kue = item['kue'] as Product;
                final qty = item['quantity'] as int;
                return ListTile(
                  leading: Image.asset(kue.gambar, width: 50, height: 50),
                  title: Text(kue.nama),
                  subtitle: Text("Jumlah: $qty"),
                  trailing: Text(_currencyFormatter.format(kue.harga * qty)),
                );
              },
            ),
            const Divider(),

            if (widget.selectedDiscount != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.selectedDiscount!["type"] == "percent"
                      ? "Diskon (${(widget.selectedDiscount!["value"] * 100).toInt()}%): -${_currencyFormatter.format((widget.total * widget.selectedDiscount!["value"]).toInt())}"
                      : "Diskon: -${_currencyFormatter.format(widget.selectedDiscount!["value"])}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),

            Text(
              "Total Akhir: ${_currencyFormatter.format(_totalAkhir)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
