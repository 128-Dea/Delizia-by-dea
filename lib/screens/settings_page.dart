import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../model/alamat_store.dart';
import '../services/preferences_service.dart';
import 'theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  final ThemeNotifier themeNotifier;

  const SettingsPage({super.key, required this.themeNotifier});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _deviceInfo = "Belum diambil";

  // Controller untuk form alamat
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jalanController = TextEditingController();
  final TextEditingController _desaController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kabupatenController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodeposController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final dark = await PreferencesService.getDarkMode();
    setState(() {
      _darkMode = dark;
    });
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String info = "";

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        info =
            "Nama Perangkat: ${androidInfo.device}\n"
            "Model: ${androidInfo.model}\n"
            "Brand: ${androidInfo.brand}\n"
            "Android Versi: ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})";
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        info =
            "Nama Perangkat: ${iosInfo.name}\n"
            "Model: ${iosInfo.utsname.machine}\n"
            "iOS Versi: ${iosInfo.systemVersion}";
      } else {
        info = "Platform tidak diketahui";
      }
    } catch (e) {
      info = "Gagal mengambil informasi perangkat: $e";
    }

    setState(() {
      _deviceInfo = info;
    });
  }

  void _showEditAlamatDialog() {
    final alamat = AlamatStore().alamat;
    if (alamat != null) {
      _namaController.text = alamat.nama;
      _jalanController.text = alamat.jalan;
      _desaController.text = alamat.desa;
      _kecamatanController.text = alamat.kecamatan;
      _kabupatenController.text = alamat.kabupaten;
      _provinsiController.text = alamat.provinsi;
      _kodeposController.text = alamat.kodepos;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Alamat"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: "Nama"),
                ),
                TextField(
                  controller: _jalanController,
                  decoration: const InputDecoration(labelText: "Jalan"),
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
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
                setState(() {});
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(245, 222, 184, 140),
              ),
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil"),
            subtitle: Text(
              AlamatStore().alamat != null
                  ? AlamatStore().alamat.toString()
                  : "Lihat dan ubah informasi akun",
            ),
            onTap: _showEditAlamatDialog,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notifikasi"),
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() {
                _notificationsEnabled = val;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Mode Gelap"),
            value: _darkMode,
            onChanged: (val) {
              widget.themeNotifier.toggle(val);
              setState(() => _darkMode = val);
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Tentang Aplikasi"),
            subtitle: Text("Versi 1.0.0 - Toko Delizia"),
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text("Informasi Perangkat"),
            subtitle: Text(_deviceInfo),
            onTap: _getDeviceInfo,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () async {
              await PreferencesService.setLoggedIn(false);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Berhasil logout")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
