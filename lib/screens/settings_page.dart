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
            onTap: () async {
              final result = await Navigator.pushNamed(context, '/edit_alamat');
              if (result != null) setState(() {});
            },
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
