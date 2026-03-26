import 'package:flutter/material.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int expandedIndex = 0;

  final List<Map<String, String>> faqList = [
    {
      "question": "What is this platform?",
      "answer":
          "This platform helps students, teachers, and parents manage school-related activities such as assignments, schedules, and communication.",
    },
    {
      "question": "What payment methods are accepted?",
      "answer":
          "We accept credit cards, debit cards, UPI, and other supported digital payment methods for school fees and services.",
    },
    {
      "question": "Is there a minimum fee amount?",
      "answer":
          "No, there is no minimum amount required for making payments such as fees or other school-related charges.",
    },
    {
      "question": "How can I track my assignments or progress?",
      "answer":
          "You can track assignments, grades, and progress in the student dashboard section of the app.",
    },
    {
      "question": "What is your refund policy?",
      "answer":
          "Refunds depend on school policies and the timing of cancellation or withdrawal.",
    },
    {
      "question": "Are there any additional charges?",
      "answer":
          "Additional charges may apply depending on extracurricular activities, transportation, or special services.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: Column(
            children: [
              const CustomAppBarWidget(title: "FAQ’s", showBackButton: true),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: faqList.length,
                  itemBuilder: (context, index) {
                    final isExpanded = expandedIndex == index;

                    return _faqTile(
                      index: index,
                      question: faqList[index]['question']!,
                      answer: faqList[index]['answer']!,
                      isExpanded: isExpanded,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _faqTile({
    required int index,
    required String question,
    required String answer,
    required bool isExpanded,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expandedIndex = isExpanded ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 24,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 10),
              Text(
                answer,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
