import 'package:flutter/material.dart';
import '../services/review_service.dart';
import '../model/ulasan_model.dart';

class UlasanPage extends StatelessWidget {
  final String productId;
  const UlasanPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final reviewService = ReviewService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ulasan Pembeli"),
        backgroundColor: const Color.fromARGB(245, 222, 184, 140),
      ),
      body: StreamBuilder<List<Review>>(
        stream: reviewService.getReviews(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada ulasan."));
          }

          final reviews = snapshot.data!;
          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.grey),
                  title: Row(
                    children: [
                      Text(
                        review.user,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: List.generate(
                          review.rating.round(),
                          (i) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(review.comment),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
