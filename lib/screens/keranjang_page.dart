import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/product.dart';
import '../model/alamat_store.dart';
import 'package:badges/badges.dart' as badges;
import 'detail_struk_alamat_page.dart';

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
    _selectedItems = {for (int i = 0; i < widget.cart.length; i++) i: false};
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
      _selectedItems = {
        for (int i = 0; i < widget.cart.length; i++)
          i: _selectedItems[i] ?? false,
      };
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
                        leading: badges.Badge(
                          badgeContent: const Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.white,
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: Colors.orangeAccent,
                            padding: EdgeInsets.all(5),
                          ),
                          position: badges.BadgePosition.topEnd(
                            top: -4,
                            end: -4,
                          ),
                          badgeAnimation: const badges.BadgeAnimation.slide(
                            animationDuration: Duration(milliseconds: 400),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              kue.gambar,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
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
                                  _currencyFormatter.format(kue.harga * qty),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeAt(index),
                              ),
                              Checkbox(
                                value: selected,
                                onChanged: (val) => setState(
                                  () => _selectedItems[index] = val ?? false,
                                ),
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

  bool get _isFormComplete {
    final alamat = AlamatStore().alamat;
    final alamatLengkap =
        alamat != null &&
        alamat.nama.isNotEmpty &&
        alamat.jalan.isNotEmpty &&
        alamat.kecamatan.isNotEmpty &&
        alamat.kabupaten.isNotEmpty &&
        alamat.provinsi.isNotEmpty &&
        alamat.kodepos.isNotEmpty;
    return alamatLengkap && _metodePembayaran != null && _kurir != null;
  }

  int get _totalAkhir {
    final ongkir = _kurir != null ? ongkirKurir[_kurir!] ?? 0 : 0;
    return widget.total + ongkir;
  }

  @override
  Widget build(BuildContext context) {
    final alamat = AlamatStore().alamat;
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alamat Pengiriman",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        alamat != null ? alamat.toString() : "Belum ada alamat",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: _metodePembayaran,
                    items: const [
                      DropdownMenuItem(
                        value: "Transfer Bank",
                        child: Text("Transfer Bank"),
                      ),
                      DropdownMenuItem(value: "COD", child: Text("COD")),
                      DropdownMenuItem(
                        value: "E-Wallet",
                        child: Text("E-Wallet"),
                      ),
                    ],
                    onChanged: (val) => setState(() => _metodePembayaran = val),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Kurir Pengiriman",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: _kurir,
                    items: ongkirKurir.keys.map((k) {
                      return DropdownMenuItem(
                        value: k,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_shipping,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(k),
                            const Spacer(),
                            Text(_currencyFormatter.format(ongkirKurir[k]!)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _kurir = val),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: _isFormComplete
                    ? () {
                        final alamatLengkap = AlamatStore().alamat!.toString();
                        final estimasiTanggal = DateTime.now().add(
                          const Duration(days: 3),
                        );
                        final estimasiFormat = DateFormat(
                          "EEEE, dd MMMM yyyy",
                          "id_ID",
                        ).format(estimasiTanggal);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPesananPage(
                              alamat: alamatLengkap,
                              metodePembayaran: _metodePembayaran!,
                              kurir: _kurir!,
                              items: widget.items,
                              total: _totalAkhir,
                              diskon: 0,
                              estimasi: estimasiFormat,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormComplete
                      ? const Color.fromARGB(245, 222, 184, 140)
                      : Colors.grey,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Konfirmasi Pembayaran",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
