import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String? namaPenjual; // kalau dari DetailKuePage, otomatis isi nama toko

  const ChatPage({super.key, this.namaPenjual});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // contoh data riwayat chat
  List<Map<String, dynamic>> chatList = [
    {
      "nama": "Raraaa",
      "last": "Terima kasih kak, pesanan sudah dikonfirmasi 🎂...",
      "time": "Kemarin",
      "messages": [
        {"from": "Kamu", "text": "Mau pesan kue ulang tahun 1 kg kak"},
        {"text": "Halo kak, mau pesan kue apa ya? 😊"},
        {"from": "Delizia Cake", "text": "Baik kak, kami proses ya! 🎂"},
        {"from": "Kamu", "text": "Saya sudah order kak"},
        {
          "from": "Delizia Cake",
          "text":
              "Terima kasih kak, pesanan sudah dikonfirmasi 🎂\n ditunggu yaa",
        },
      ],
    },
    {
      "nama": "Reyhan",
      "last": "okee kak",
      "time": "2 hari lalu",
      "messages": [
        {"from": "Kamu", "text": "Kak, promo red velvet masih ada gak?"},
        {
          "from": "Delizia Cake",
          "text":
              "Masih tersedia kak untuk minggu ini👌\n untuk semua pembelian kue ulang tahun yaa",
        },
        {"from": "Delizia Cake", "text": "Silakan di order ya kak"},
        {
          "from": "Kamu",
          "text": "Kak, kalo beli kue ultah ucapan nya bisa custom gak yaa?",
        },
        {
          "from": "Delizia Cake",
          "text":
              "bisa ya kaka, nanti silakan chat saja disini setelah diorder yaa",
        },
        {"from": "Kamu", "text": "okee kak"},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    // jika datang dari DetailKuePage langsung ke chat penjual
    if (widget.namaPenjual != null) {
      Future.microtask(() {
        final toko = widget.namaPenjual!;
        final existing = chatList.firstWhere(
          (c) => c["nama"] == toko,
          orElse: () => {},
        );

        // buat data chat baru kalau belum ada
        final chatData = existing.isNotEmpty
            ? existing
            : {
                "nama": toko,
                "last": "Mulai chat dengan $toko",
                "time": "Sekarang",
                "messages": [
                  {
                    "from": toko,
                    "text": "Halo kak, ada yang bisa kami bantu? 😊",
                  },
                ],
              };

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ChatDetailPage(chatData: chatData)),
        );
      });
    }
  }

  void _openChatDetail(Map<String, dynamic> chatData) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatDetailPage(chatData: chatData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // tampilkan daftar chat kalau tidak dari DetailKuePage
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Chat"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9F6F1),
      body: chatList.isEmpty
          ? const Center(
              child: Text(
                "Belum ada riwayat chat",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: chatList.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final chat = chatList[index];
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFDAB98F),
                    child: Icon(Icons.store, color: Colors.white),
                  ),
                  title: Text(
                    chat["nama"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chat["last"]),
                  trailing: Text(
                    chat["time"],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () => _openChatDetail(chat),
                );
              },
            ),
    );
  }
}

class ChatDetailPage extends StatefulWidget {
  final Map<String, dynamic> chatData;

  const ChatDetailPage({super.key, required this.chatData});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _msgController = TextEditingController();
  late List<Map<String, String>> messages;

  @override
  void initState() {
    super.initState();
    messages = List<Map<String, String>>.from(widget.chatData["messages"]);
  }

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    final time = DateFormat('HH:mm').format(DateTime.now());
    setState(() {
      messages.add({"from": "Kamu", "text": text});
      widget.chatData["last"] = text;
      widget.chatData["time"] = time;
    });
    _msgController.clear();

    // Auto-reply penjual (biar terasa interaktif)
    Future.delayed(const Duration(seconds: 1), () {
      final replies = [
        "Baik kak, kami siap bantu ya 😊",
        "Terima kasih kak, pesanan akan segera kami proses 🎂",
        "Tunggu balasan dari admin kami ya 😊",
        "Siap kak! Ditunggu orderannya 💕",
      ];
      final reply = replies[DateTime.now().second % replies.length];
      setState(() {
        messages.add({"from": widget.chatData["nama"], "text": reply});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final namaPenjual = widget.chatData["nama"];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFDAB98F),
              child: Icon(Icons.store, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(namaPenjual),
          ],
        ),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      backgroundColor: const Color(0xFFF9F6F1),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg["from"] == "Kamu";
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFDAB98F) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(isMe ? 12 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg["text"]!,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.brown,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: "Tulis pesan...",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.brown),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
