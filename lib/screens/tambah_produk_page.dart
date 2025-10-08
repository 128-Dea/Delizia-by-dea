import 'package:flutter/material.dart';
import '../model/kue_kering.dart';
import '../model/kue_basah.dart';
import '../model/kue_ultah.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final deskripsiController = TextEditingController();
  final id = DateTime.now().millisecondsSinceEpoch.toString();

  String? _selectedKategori;

  final List<String> _kategori = ["Kue Kering", "Kue Basah", "Kue Ulang Tahun"];

  void _simpanProduk() {
    final nama = namaController.text.trim();
    final harga = double.tryParse(hargaController.text.trim()) ?? 0;
    final deskripsi = deskripsiController.text.trim();

    if (nama.isEmpty ||
        harga <= 0 ||
        deskripsi.isEmpty ||
        _selectedKategori == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data dengan benar")),
      );
      return;
    }

    if (_selectedKategori == "Kue Kering") {
      KueKering.daftarKueKering.add(
        KueKering(
          id,
          nama,
          harga,
          "Kue Kering",
          "assets/images/default.jpeg",
          10,
          deskripsi,
          "Original",
        ),
      );
    } else if (_selectedKategori == "Kue Basah") {
      KueBasah.daftarKueBasah.add(
        KueBasah(
          id,
          nama,
          harga,
          "Kue Basah",
          "assets/images/default.jpeg",
          10,
          deskripsi,
          "1 hari",
        ),
      );
    } else if (_selectedKategori == "Kue Ulang Tahun") {
      KueUltah.daftarKueUltah.add(
        KueUltah(
          id,
          nama,
          harga,
          "Kue Ultah",
          "assets/images/default.jpeg",
          5,
          deskripsi,
          "Sedang",
          "Happy Birthday!",
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Produk $nama berhasil ditambahkan!")),
    );

    Navigator.pop(context); // kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk"),
        backgroundColor: const Color.fromARGB(255, 144, 145, 98),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama Produk"),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              hint: const Text("Pilih Kategori"),
              items: _kategori.map((String kategori) {
                return DropdownMenuItem(value: kategori, child: Text(kategori));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedKategori = val;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Kategori",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _simpanProduk,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 144, 145, 98),
              ),
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
