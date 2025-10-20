import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chat_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Pesanan Diterima 🎉",
      "message": "Terima kasih! Pesanan kamu sedang diproses oleh toko.",
      "time": DateTime.now().subtract(const Duration(minutes: 5)),
      "icon": Icons.check_circle_outline,
      "color": Colors.green,
    },
    {
      "title": "Diskon Spesial 💸",
      "message": "Nikmati diskon 20% untuk semua kue ulang tahun hari ini!",
      "time": DateTime.now().subtract(const Duration(hours: 2)),
      "icon": Icons.local_offer_outlined,
      "color": Colors.orange,
    },
    {
      "title": "Stok Terbaru 🍰",
      "message": "Kue Red Velvet dan Tiramisu baru saja tersedia lagi.",
      "time": DateTime.now().subtract(const Duration(days: 1)),
      "icon": Icons.cake_outlined,
      "color": Colors.pink,
    },
    {
      "title": "Pesanan Dikirim 🚚",
      "message": "Pesanan kamu sedang dalam perjalanan, harap tunggu ya!",
      "time": DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      "icon": Icons.local_shipping_outlined,
      "color": Colors.blueAccent,
    },
    {
      "title": "Promo Minggu Ini 🎂",
      "message": "Beli 2 kue ulang tahun gratis 1 kue kering favoritmu!",
      "time": DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      "icon": Icons.card_giftcard,
      "color": Colors.purple,
    },
    {
      "title": "Kue Favorit Kamu Hampir Habis ⚠️",
      "message":
          "Stok Brownies tinggal sedikit! Segera pesan sebelum kehabisan.",
      "time": DateTime.now().subtract(const Duration(days: 3)),
      "icon": Icons.warning_amber_rounded,
      "color": Colors.redAccent,
    },
    {
      "title": "Pesanan Telah Tiba 📦",
      "message": "Pesanan kamu sudah diterima oleh kurir.",
      "time": DateTime.now().subtract(const Duration(days: 2)),
      "icon": Icons.home_outlined,
      "color": Colors.green,
    },
    {
      "title": "Update Aplikasi 🛠️",
      "message": "Versi terbaru aplikasi Delizia sudah tersedia di Play Store.",
      "time": DateTime.now().subtract(const Duration(days: 5)),
      "icon": Icons.system_update_alt_outlined,
      "color": Colors.indigo,
    },
  ];

  bool _selectionMode = false;
  final Set<int> _selectedIndexes = {};

  // Format waktu
  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} menit lalu";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} jam lalu";
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  void _toggleSelectionMode() {
    setState(() {
      _selectionMode = !_selectionMode;
      _selectedIndexes.clear();
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  void _deleteSelected() {
    setState(() {
      notifications = notifications
          .asMap()
          .entries
          .where((entry) => !_selectedIndexes.contains(entry.key))
          .map((entry) => entry.value)
          .toList();
      _selectionMode = false;
      _selectedIndexes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 242),
      appBar: AppBar(
        title: Text(
          _selectionMode ? "${_selectedIndexes.length} dipilih" : "Notifikasi",
        ),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
        centerTitle: true,
        actions: [
          // tombol hapus kalau sedang mode pilih
          if (_selectionMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _selectedIndexes.isEmpty ? null : _deleteSelected,
            )
          // tombol edit kalau belum mode pilih
          else if (notifications.isNotEmpty) ...[
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              tooltip: "Buka Riwayat Chat",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: "Pilih notifikasi untuk dihapus",
              onPressed: _toggleSelectionMode,
            ),
          ],
        ],
        leading: _selectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleSelectionMode,
              )
            : null,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "Belum ada notifikasi",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                final selected = _selectedIndexes.contains(index);

                return ListTile(
                  onLongPress: () {
                    if (!_selectionMode) _toggleSelectionMode();
                    _toggleSelection(index);
                  },
                  onTap: () {
                    if (_selectionMode) {
                      _toggleSelection(index);
                    }
                  },
                  leading: _selectionMode
                      ? Checkbox(
                          activeColor: Colors.brown,
                          value: selected,
                          onChanged: (_) => _toggleSelection(index),
                        )
                      : CircleAvatar(
                          backgroundColor: notif["color"].withOpacity(0.2),
                          child: Icon(notif["icon"], color: notif["color"]),
                        ),
                  title: Text(
                    notif["title"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.brown : Colors.black,
                    ),
                  ),
                  subtitle: Text(notif["message"]),
                  trailing: Text(
                    _formatTime(notif["time"]),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}
