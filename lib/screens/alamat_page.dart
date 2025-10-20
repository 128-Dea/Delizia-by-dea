import 'package:flutter/material.dart';
import '../model/alamat_store.dart';

// -------------------- EDIT ALAMAT PAGE SAJA --------------------
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
      appBar: AppBar(
        title: const Text("Edit Alamat"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(245, 222, 184, 140),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
