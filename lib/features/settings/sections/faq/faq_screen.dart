import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/features/settings/cubit/account_cubit.dart';
import 'package:upd8s/features/settings/cubit/account_state.dart';
import 'package:upd8s/features/settings/data/faq_model.dart';


class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    context.read<AccountCubit>().getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: AppBackground(
              child: Column(
                children: [
                  const CustomAppBarWidget(title: "FAQ's", showBackButton: true),

                  const SizedBox(height: 10),

                  Expanded(child: _buildBody(state)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(AccountState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == AccountStatus.failure) {
      return Center(
        child: Text(
          state.errorMessage ?? "Failed to load FAQs.",
          style: const TextStyle(color: Colors.black54),
        ),
      );
    }

    if (state.faqs.isEmpty) {
      return const Center(
        child: Text(
          "No FAQs available.",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.faqs.length,
      itemBuilder: (context, index) {
        final FaqModel faq = state.faqs[index];
        return _faqTile(
          index: index,
          question: faq.question,
          answer: faq.answer,
          isExpanded: expandedIndex == index,
        );
      },
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