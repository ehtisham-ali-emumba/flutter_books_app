import 'package:books/components/shared_widgets/base_carousel.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'card_shimmer.dart';

class CarouselShimmer extends StatelessWidget {
  const CarouselShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define shimmer colors based on theme mode
    final baseColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDarkMode
        ? Colors.grey.shade700
        : Colors.grey.shade100;
    final containerColor = isDarkMode ? Colors.grey.shade700 : Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          BaseCarousel(
            options: CarouselOptions(
              enlargeCenterPage: false,
              autoPlay: false,
              height: 220,
              viewportFraction: 0.55,
              padEnds: false,
              enableInfiniteScroll: false,
            ),
            items: List.generate(5, (index) => const CardShimmer()),
          ),
        ],
      ),
    );
  }
}
