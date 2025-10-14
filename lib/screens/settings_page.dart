import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../model/alamat_store.dart';
import '../services/preferences_service.dart';
import 'theme_notifier.dart';
import '../services/liked_service.dart';
import '../model/product.dart';

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
  final List<String> _produkDisukai = [];

  // Controller form alamat
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
    _loadLikedProducts();
  }

  Future<void> _loadPreferences() async {
    final dark = await PreferencesService.getDarkMode();
    setState(() {
      _darkMode = dark;
    });
  }

  Future<void> _loadLikedProducts() async {
    try {
      setState(() {
        _produkDisukai.clear();
        _produkDisukai.addAll(
          LikedService.likedProducts.map((p) => p.nama).toList(),
        );
      });
    } catch (e) {
      debugPrint("Gagal memuat produk disukai: $e");
    }
  }

  Future<String> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (kIsWeb) {
        final webInfo = await deviceInfoPlugin.webBrowserInfo;
        return "Browser: ${webInfo.userAgent ?? "Unknown"}";
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return "Model: ${androidInfo.model}\nMerek: ${androidInfo.brand}\nAndroid: ${androidInfo.version.release}";
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return "Model: ${iosInfo.utsname.machine}\niOS: ${iosInfo.systemVersion}";
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfoPlugin.windowsInfo;
        return "Windows Device: ${windowsInfo.computerName}";
      } else if (Platform.isLinux) {
        final linuxInfo = await deviceInfoPlugin.linuxInfo;
        return "Linux Device: ${linuxInfo.prettyName}";
      } else if (Platform.isMacOS) {
        final macInfo = await deviceInfoPlugin.macOsInfo;
        return "Mac Device: ${macInfo.model}";
      } else {
        return "Platform tidak dikenal";
      }
    } catch (e) {
      return "Gagal ambil info: $e";
    }
  }

  void _showDeviceInfo() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text("Info Perangkat"),
        content: SizedBox(
          height: 50,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );

    final info = await _getDeviceInfo();
    if (!mounted) return;
    Navigator.pop(context);

    setState(() {
      _deviceInfo = info;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Info Perangkat"),
        content: Text(info),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  void _showProfileOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Profil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.pink),
              title: const Text("Produk yang Disukai"),
              onTap: () {
                Navigator.pop(context);
                _showLikedProducts();
              },
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.brown),
              title: const Text("Alamat"),
              onTap: () {
                Navigator.pop(context);
                _showEditAlamatDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLikedProducts() async {
    await _loadLikedProducts(); // ✅ supaya update terbaru selalu muncul
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Produk yang Disukai"),
        content: _produkDisukai.isEmpty
            ? const Text("Belum ada produk yang disukai.")
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _produkDisukai.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: const Icon(
                      Icons.cake_outlined,
                      color: Colors.pink,
                    ),
                    title: Text(_produkDisukai[index]),
                  ),
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
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
            subtitle: const Text("Lihat dan ubah informasi akun"),
            onTap: _showProfileOptions,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notifikasi"),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
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
            onTap: _showDeviceInfo,
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
