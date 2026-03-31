import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TermsShimmerScreen extends StatelessWidget {
  const TermsShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(height: 20, width: 200),
              const SizedBox(height: 16),
              _shimmerParagraph(),
              const SizedBox(height: 24),
              _shimmerBox(height: 20, width: 150),
              const SizedBox(height: 16),
              _shimmerParagraph(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shimmerBox({required double height, required double width}) {
    return Container(height: height, width: width, color: Colors.white);
  }

  Widget _shimmerParagraph() {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: 14,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
