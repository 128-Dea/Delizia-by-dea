import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/product.dart';
import '../model/alamat_store.dart';
import 'package:badges/badges.dart' as badges;

class KeranjangPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  const KeranjangPage({super.key, required this.cart});

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
        builder: (context) =>
            CheckoutPage(items: selectedItems, total: _selectedTotal),
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
                        leading: badges.Badge(
                          // Badge animasi di tiap gambar produk
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
                            curve: Curves.easeInOut,
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

  const CheckoutPage({super.key, required this.items, required this.total});

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

  final Map<String, IconData> kurirIcons = {
    "JNE": Icons.local_shipping,
    "J&T": Icons.airport_shuttle,
    "SiCepat": Icons.delivery_dining,
    "POS Indonesia": Icons.mark_email_read,
  };

  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  double get _diskon {
    if (widget.total > 100000) return 10000;
    return 0;
  }

  int get _totalAkhir {
    final ongkir = _kurir != null ? ongkirKurir[_kurir!] ?? 0 : 0;
    return (widget.total - _diskon + ongkir).toInt();
  }

  Icon _iconPembayaran(String metode) {
    switch (metode) {
      case "Transfer Bank":
        return const Icon(Icons.account_balance, color: Colors.blue);
      case "COD":
        return const Icon(Icons.money, color: Colors.green);
      case "E-Wallet":
        return const Icon(Icons.payment, color: Colors.purple);
      default:
        return const Icon(Icons.payment);
    }
  }

  bool get _isFormComplete {
    return AlamatStore().alamat != null &&
        _metodePembayaran != null &&
        _kurir != null;
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
                  // ---------------- ALAMAT ----------------
                  const Text(
                    "Alamat Pengiriman",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        alamat != null
                            ? alamat.toString()
                            : "Belum ada alamat, silakan isi di Profil",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ---------------- PEMBAYARAN ----------------
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
                  if (_metodePembayaran != null)
                    Row(
                      children: [
                        _iconPembayaran(_metodePembayaran!),
                        const SizedBox(width: 8),
                        Text(_metodePembayaran!),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // ---------------- KURIR ----------------
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
                            Icon(kurirIcons[k], color: Colors.blue),
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

                  const SizedBox(height: 16),

                  // ---------------- BARANG ----------------
                  const Text(
                    "Barang yang dibeli",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
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
                        trailing: Text(
                          _currencyFormatter.format(kue.harga * qty),
                        ),
                      );
                    },
                  ),

                  const Divider(),
                  if (_diskon > 0)
                    Text("Diskon: ${_currencyFormatter.format(_diskon)}"),
                  const SizedBox(height: 8),
                  Text(
                    "Total Akhir: ${_currencyFormatter.format(_totalAkhir)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // ---------------- BUTTON KONFIRMASI ----------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
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
                              diskon: _diskon,
                              estimasi: estimasiFormat,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(245, 222, 184, 140),
                ),
                child: const Text("Konfirmasi Pembayaran"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- DETAIL PESANAN PAGE --------------------
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

  Icon _iconPembayaran(String metode) {
    switch (metode) {
      case "Transfer Bank":
        return const Icon(Icons.account_balance, color: Colors.blue);
      case "COD":
        return const Icon(Icons.money, color: Colors.green);
      case "E-Wallet":
        return const Icon(Icons.payment, color: Colors.purple);
      default:
        return const Icon(Icons.payment);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pesanan"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------- ALAMAT & INFORMASI ----------
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Alamat Pengiriman",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(alamat),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _iconPembayaran(metodePembayaran),
                        const SizedBox(width: 6),
                        Text("Metode Pembayaran: $metodePembayaran"),
                      ],
                    ),
                    Text("Kurir: $kurir"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ---------- DAFTAR BARANG ----------
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Barang yang dibeli",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final kue = item['kue'] as Product;
                            final qty = item['quantity'] as int;
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.asset(
                                kue.gambar,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(kue.nama),
                              subtitle: Text("Jumlah: $qty"),
                              trailing: Text(
                                currencyFormatter.format(kue.harga * qty),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ---------- TOTAL & DISKON ----------
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (diskon > 0)
                      Text(
                        "Diskon: ${currencyFormatter.format(diskon)}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      "Total Bayar: ${currencyFormatter.format(total)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Estimasi Tiba: $estimasi",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- STRUK PESANAN --------------------
class StrukPesananPage extends StatelessWidget {
  final String alamat;
  final String metodePembayaran;
  final String kurir;
  final List<Map<String, dynamic>> items;
  final int total;
  final double diskon;
  final String estimasi;

  const StrukPesananPage({
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
      appBar: AppBar(
        title: const Text("Struk Pesanan"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Column(
              children: const [
                Text(
                  "🍰 DELIZIA Cake Shop",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("Struk Pesanan", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // Info pengiriman
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alamat Pengiriman:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(alamat),
                  const SizedBox(height: 4),
                  Text("Kurir: $kurir"),
                  Text("Metode Pembayaran: $metodePembayaran"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Daftar barang
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final kue = item['kue'] as Product;
                  final qty = item['quantity'] as int;
                  final subtotal = kue.harga * qty;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("${kue.nama} x$qty")),
                        Text(currencyFormatter.format(subtotal)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            // Ringkasan pembayaran
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (diskon > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Diskon"),
                      Text(
                        "- ${currencyFormatter.format(diskon)}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Bayar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currencyFormatter.format(total),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Estimasi Tiba: $estimasi",
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Terima kasih telah berbelanja di DELIZIA Cake Shop!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- EDIT ALAMAT PAGE --------------------
class EditAlamatPage extends StatefulWidget {
  const EditAlamatPage({super.key});

  @override
  State<EditAlamatPage> createState() => _EditAlamatPageState();
}

class _EditAlamatPageState extends State<EditAlamatPage> {
  final _namaController = TextEditingController();
  final _jalanController = TextEditingController();
  final _kecamatanController = TextEditingController();
  final _desaController = TextEditingController();
  final _kabupatenController = TextEditingController();
  final _provinsiController = TextEditingController();
  final _kodeposController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final alamat = AlamatStore().alamat;
    if (alamat != null) {
      _namaController.text = alamat.nama;
      _jalanController.text = alamat.jalan;
      _kecamatanController.text = alamat.kecamatan;
      _desaController.text = alamat.desa;
      _kabupatenController.text = alamat.kabupaten;
      _provinsiController.text = alamat.provinsi;
      _kodeposController.text = alamat.kodepos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Alamat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: _jalanController,
              decoration: const InputDecoration(labelText: "Jalan/No Rumah"),
            ),
            TextField(
              controller: _desaController,
              decoration: const InputDecoration(labelText: "Desa"),
            ),
            TextField(
              controller: _kecamatanController,
              decoration: const InputDecoration(labelText: "Kecamatan"),
            ),
            TextField(
              controller: _kabupatenController,
              decoration: const InputDecoration(labelText: "Kabupaten"),
            ),
            TextField(
              controller: _provinsiController,
              decoration: const InputDecoration(labelText: "Provinsi"),
            ),
            TextField(
              controller: _kodeposController,
              decoration: const InputDecoration(labelText: "Kode Pos"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AlamatStore().alamat = Alamat(
                  nama: _namaController.text,
                  jalan: _jalanController.text,
                  desa: _desaController.text,
                  kecamatan: _kecamatanController.text,
                  kabupaten: _kabupatenController.text,
                  provinsi: _provinsiController.text,
                  kodepos: _kodeposController.text,
                );
                Navigator.pop(context, true);
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
