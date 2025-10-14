import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/chat_page.dart';
import 'package:intl/intl.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:getwidget/getwidget.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/product.dart';
import '../model/kue_kering.dart';
import '../model/kue_basah.dart';
import '../model/kue_ultah.dart';
import '../model/ulasan_model.dart';
import '../services/review_service.dart';
import 'keranjang_page.dart';
import '../services/liked_service.dart';

class DetailKuePage extends StatefulWidget {
  final Product kue;
  final Function(Map<String, dynamic>) onAddToCart;
  final List<Map<String, dynamic>> cart;
  final List<dynamic> semuaProduk;

  const DetailKuePage({
    super.key,
    required this.kue,
    required this.onAddToCart,
    required this.cart,
    required this.semuaProduk,
  });

  @override
  State<DetailKuePage> createState() => _DetailKuePageState();
}

class _DetailKuePageState extends State<DetailKuePage>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  double _rating = 4.0;
  final ReviewService _reviewService = ReviewService();
  bool isLiked = false;

  String? selectedUkuran;
  String? selectedTopping;
  String? selectedBerat;

  // controller untuk animasi
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> addReview() async {
    if (_nameController.text.isEmpty || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama dan komentar tidak boleh kosong!")),
      );
      return;
    }

    final newReview = Review(
      user: _nameController.text,
      rating: _rating,
      comment: _commentController.text,
    );

    try {
      await _reviewService.addReview(widget.kue.id, newReview);
      _nameController.clear();
      _commentController.clear();
      setState(() => _rating = 4.0);

      GFToast.showToast(
        "Ulasan berhasil dikirim!",
        context,
        backgroundColor: Colors.green.shade400,
        toastPosition: GFToastPosition.BOTTOM,
      );
    } catch (e) {
      GFToast.showToast(
        "Gagal mengirim ulasan: $e",
        context,
        backgroundColor: Colors.red.shade400,
        toastPosition: GFToastPosition.BOTTOM,
      );
    }
  }

  void addToCart() {
    //harus
    if (widget.kue.kategori == "Kue Ultah" &&
        (selectedUkuran == null || selectedTopping == null)) {
      GFToast.showToast(
        "Pilih ukuran dan topping terlebih dahulu!",
        context,
        backgroundColor: Colors.red.shade300,
        toastPosition: GFToastPosition.BOTTOM,
      );
      return;
    }

    if (widget.kue.kategori == "Kue Kering" && selectedBerat == null) {
      GFToast.showToast(
        "Pilih berat bersih terlebih dahulu!",
        context,
        backgroundColor: Colors.red.shade300,
        toastPosition: GFToastPosition.BOTTOM,
      );
      return;
    }

    widget.onAddToCart({
      "kue": widget.kue,
      "quantity": quantity,
      "ukuran": selectedUkuran,
      "topping": selectedTopping,
      "berat": selectedBerat,
    });

    GFToast.showToast(
      "${widget.kue.nama} ditambahkan ke keranjang!",
      context,
      backgroundColor: Colors.brown.shade300,
      toastPosition: GFToastPosition.BOTTOM,
    );

    setState(() {});
  }

  /// Ambil 5 produk random
  List<Product> getRelatedProducts({int take = 9}) {
    final random = Random();
    final others = widget.semuaProduk
        .where((p) {
          try {
            final prod = p as Product;
            return prod.id != widget.kue.id;
          } catch (_) {
            return false;
          }
        })
        .map((p) => p as Product)
        .toList();
    others.shuffle(random);
    return others.take(take).toList();
  }

  String formatCurrency(num value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(value);
  }

  String _infoTrendingFor(Product p) {
    //teks  trending
    final base =
        "${p.nama} sedang banyak diburu akhir-akhir ini — cocok untuk kado & acara spesial.";
    if (p is KueKering) {
      return "$base \nRekomendasi: padukan dengan teh manis untuk pengalaman terbaik.";
    } else if (p is KueBasah) {
      return "$base \nSimpan di pendingin agar tetap segar hingga ${p.dayaTahan} hari.";
    } else if (p is KueUltah) {
      return "$base \nCocok untuk pesta; ukuran populer: ${p.ukuran}. Tambah ucapan personal untuk sentuhan spesial.";
    }
    return base;
  }

  @override
  Widget build(BuildContext context) {
    final kue = widget.kue;
    final related = getRelatedProducts(take: 9);

    const bg = Color(0xFFFFF8F2);
    const cardBg = Color(0xFFFFFFFF);
    const accent = Color(0xFFDAB98F);
    const brown = Color(0xFF6F4E37);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          title: Text(kue.nama),
          backgroundColor: accent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: badges.Badge(
                badgeContent: Text(
                  widget.cart.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.redAccent,
                  padding: EdgeInsets.all(6),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KeranjangPage(cart: widget.cart),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image column
                        Expanded(flex: 5, child: _buildImageCard(kue)),
                        const SizedBox(width: 16),
                        // info column
                        Expanded(
                          flex: 5,
                          child: _buildInfoCard(kue, brown, accent),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageCard(kue),
                        const SizedBox(height: 12),
                        _buildInfoCard(kue, brown, accent),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  labelColor: brown,
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bg.withOpacity(0.1),
                  ),
                  tabs: const [
                    Tab(text: "Deskripsi"),
                    Tab(text: "Info Trending"),
                    Tab(text: "Ulasan"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 380,
                child: TabBarView(
                  children: [
                    // ----- Deskripsi -----
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kue.deskripsi,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Detail Produk",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              _infoChip("Stok: ${kue.stok}"),
                              if (kue is KueKering)
                                _infoChip("Rasa: ${kue.rasa}"),
                              if (kue is KueBasah)
                                _infoChip("Daya tahan: ${kue.dayaTahan} hari"),
                              if (kue is KueUltah)
                                _infoChip("Ukuran: ${kue.ukuran}"),
                              if (kue is KueUltah)
                                _infoChip("Ucapan: ${kue.ucapan}"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ----- Info Trending -----
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _infoTrendingFor(kue),
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Mengapa banyak yang suka?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "• Tekstur lembut dan rasa otentik.\n• Tampilan cantik cocok untuk hampers & acara.\n• Banyak pembeli mengulas positif soal aroma dan kesegaran.",
                            style: TextStyle(height: 1.6),
                          ),
                        ],
                      ),
                    ),

                    // ----- Ulasan -----
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tulis Ulasan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Nama",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          EasyStarsRating(
                            initialRating: _rating,
                            starCount: 5,
                            filledColor: Colors.orange,
                            starSize: 22,
                            onRatingChanged: (val) =>
                                setState(() => _rating = val),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              labelText: "Komentar",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: addReview,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accent,
                              foregroundColor: brown,
                            ),
                            child: const Text("Kirim Ulasan"),
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 8),
                          const Text(
                            "Ulasan Pembeli:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          StreamBuilder<List<Review>>(
                            stream: _reviewService.getReviews(widget.kue.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text("Belum ada ulasan.");
                              }
                              final reviews = snapshot.data!;
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: reviews.length,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (context, i) {
                                  final r = reviews[i];
                                  return ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.brown,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(r.user),
                                    subtitle: Text(r.comment),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        r.rating.round(),
                                        (i) => const Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ====== REKOMENDASI
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Kue Lainnya yang Mungkin Kamu Suka",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 220,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: related.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final p = related[index];
                    return _buildRelatedCard(p, accent, brown);
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(Product kue) {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.asset(
            kue.gambar,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(Product kue, Color brown, Color accent) {
    return Card(
      color: const Color(0xFFFFFFFF),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kue.nama,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                EasyStarsRating(
                  initialRating: 4.5,
                  starCount: 5,
                  filledColor: Colors.orange,
                  starSize: 18,
                  allowHalfRating: true,
                ),
                const SizedBox(width: 8),
                Text("(124)", style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              formatCurrency(kue.harga),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 14),
            Text(kue.kategori ?? "", style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 18),

            // ======== Pilihan Custom Sesuai Jenis Kue ========
            if (kue.kategori == "Kue Ultah") ...[
              const Text(
                "Pilih Ukuran (cm):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              DropdownButton<String>(
                value: selectedUkuran,
                hint: const Text("Pilih ukuran"),
                items: ["10 cm", "15 cm", "20 cm", "25 cm"].map((uk) {
                  return DropdownMenuItem(value: uk, child: Text(uk));
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedUkuran = value);
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "Pilih Topping:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              DropdownButton<String>(
                value: selectedTopping,
                hint: const Text("Pilih topping"),
                items: ["Cokelat", "Keju", "Buah", "Mix"].map((t) {
                  return DropdownMenuItem(value: t, child: Text(t));
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedTopping = value);
                },
              ),
              const SizedBox(height: 16),
            ] else if (kue.kategori == "Kue Kering") ...[
              const Text(
                "Pilih Berat Bersih (gram):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              DropdownButton<String>(
                value: selectedBerat,
                hint: const Text("Pilih berat"),
                items: ["250 gram", "500 gram", "750 gram", "1 kg"].map((b) {
                  return DropdownMenuItem(value: b, child: Text(b));
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedBerat = value);
                },
              ),
              const SizedBox(height: 16),
            ],

            // Tambah ke Keranjang ========
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) setState(() => quantity--);
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.brown,
                  ),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: addToCart,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Tambah"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(245, 222, 184, 140),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Beli Sekarang & Chat Penjual ========
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Validasi dulu biar gak lupa pilih varian
                      if (widget.kue.kategori == "Kue Ultah" &&
                          (selectedUkuran == null || selectedTopping == null)) {
                        GFToast.showToast(
                          "Pilih ukuran dan topping terlebih dahulu!",
                          context,
                          backgroundColor: Colors.red.shade300,
                          toastPosition: GFToastPosition.BOTTOM,
                        );
                        return;
                      }

                      if (widget.kue.kategori == "Kue Kering" &&
                          selectedBerat == null) {
                        GFToast.showToast(
                          "Pilih berat bersih terlebih dahulu!",
                          context,
                          backgroundColor: Colors.red.shade300,
                          toastPosition: GFToastPosition.BOTTOM,
                        );
                        return;
                      }

                      // Arahkan langsung ke halaman checkout (tanpa masuk keranjang)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutPage(
                            items: [
                              {
                                "kue": widget.kue,
                                "quantity": quantity,
                                "ukuran": selectedUkuran,
                                "topping": selectedTopping,
                                "berat": selectedBerat,
                              },
                            ],
                            total: (widget.kue.harga * quantity).toInt(),
                          ),
                        ),
                      );
                    },

                    icon: const Icon(Icons.shopping_bag),
                    label: const Text("Beli Sekarang"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(245, 222, 184, 140),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ChatPage(namaPenjual: "Delizia Cake Shop"),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text("Chat Penjual"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(245, 222, 184, 140),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Favorit & Share ========
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    LikedService.isLiked(kue)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    setState(() {
                      LikedService.toggleLike(kue);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          LikedService.isLiked(kue)
                              ? "${kue.nama} ditambahkan ke daftar suka ❤️"
                              : "${kue.nama} dihapus dari daftar suka 💔",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.purple,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedCard(Product p, Color accent, Color brown) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DetailKuePage(
              kue: p,
              onAddToCart: widget.onAddToCart,
              cart: widget.cart,
              semuaProduk: widget.semuaProduk,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  p.gambar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formatCurrency(p.harga),
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.brown.withOpacity(0.06),
      labelStyle: const TextStyle(color: Colors.brown),
    );
  }
}
